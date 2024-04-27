require_relative "node_visitor/version"

class NodeVisitor
  class InvalidAdapterError < StandardError; end

  autoload :Adapter, "node_visitor/adapter"
  autoload :ParserAdapter, "node_visitor/adapter/parser"
  autoload :PrismAdapter, "node_visitor/adapter/prism"
  autoload :SyntaxTreeAdapter, "node_visitor/adapter/syntax_tree"

  def initialize(adapter:)
    @adapter = get_adapter_instance(adapter)
    @callbacks = {}
  end

  def add_callback(node_type, at:, &block)
    @callbacks[node_type] ||= []
    @callbacks[node_type] << { block: block, at: at }
  end

  def visit(node)
    if node.is_a?(Array)
      node.each { |child_node| visit(child_node) }
      return
    end
    return unless @adapter.is_node?(node)

    callbacks = @callbacks[@adapter.get_node_type(node)]
    callbacks.each { |callback| instance_exec(node, &callback[:block]) if callback[:at] == 'start' } if callbacks
    @adapter.get_children(node).each { |child_node| visit(child_node) }
    callbacks.each { |callback| instance_exec(node, &callback[:block]) if callback[:at] == 'end' } if callbacks
  end

  private

  def get_adapter_instance(adapter)
    case adapter.to_sym
    when :parser
      ParserAdapter.new
    when :syntax_tree
      SyntaxTreeAdapter.new
    when :prism
      PrismAdapter.new
    else
      raise InvalidAdapterError, "adapter #{adapter} is not supported"
    end
  end
end
