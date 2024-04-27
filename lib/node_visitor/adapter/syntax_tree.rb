# frozen_string_literal: true

require 'syntax_tree'
require 'syntax_tree_ext'

class NodeVisitor::SyntaxTreeAdapter
  def is_node?(node)
    node.is_a?(SyntaxTree::Node)
  end

  def get_node_type(node)
    node.class.name.split('::').last.to_sym
  end

  def get_children(node)
    node.deconstruct_keys([]).filter { |key, _value| ![:location, :comments].include?(key) }
        .values
  end
end
