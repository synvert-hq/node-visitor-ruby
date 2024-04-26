# frozen_string_literal: true

require 'prism'
require 'prism_ext'

class NodeVisitor::PrismAdapter
  def is_node?(node)
    node.is_a?(Prism::Node)
  end

  def get_node_type(node)
    node.type
  end

  def get_children(node)
    keys = []
    children = []
    node.deconstruct_keys([]).each do |key, value|
      next if [:flags, :location].include?(key)

      if key.to_s.end_with?('_loc')
        new_key = key.to_s[0..-5]
        unless keys.include?(new_key)
          keys << new_key
          children << node.send(new_key)
        end
      else
        unless keys.include?(key.to_s)
          keys << key.to_s
          children << value
        end
      end
    end
    children
  end
end
