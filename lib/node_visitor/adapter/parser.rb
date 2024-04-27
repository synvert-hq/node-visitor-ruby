# frozen_string_literal: true

require 'parser'
require 'parser_node_ext'

class NodeVisitor::ParserAdapter
  def is_node?(node)
    node.is_a?(Parser::AST::Node)
  end

  def get_node_type(node)
    node.type
  end

  def get_children(node)
    node.children
  end
end
