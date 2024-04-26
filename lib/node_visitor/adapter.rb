# frozen_string_literal: true

# Abstract Adapter class
class NodeVisitor::Adapter
  # Check if it is a node
  # @return [Boolean]
  def is_node?(node)
    raise NotImplementedError, 'get_node_type is not implemented'
  end

  # Get the type of node
  # @param node [Node] ast node
  # @return [Symbol] node type
  def get_node_type(node)
    raise NotImplementedError, 'get_node_type is not implemented'
  end

  # Get the children of node
  # @param node [Node] ast node
  # @return [Array<Node>] node children
  def get_children(node)
    raise NotImplementedError, 'get_children is not implemented'
  end
end
