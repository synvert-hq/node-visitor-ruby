# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NodeVisitor::PrismAdapter do
  let(:adapter) { described_class.new }

  describe "#is_node?" do
    it 'gets true for node' do
      node = prism_parse("class Synvert; end").body.first
      expect(adapter.is_node?(node)).to be_truthy
    end

    it 'gets false for other' do
      expect(adapter.is_node?("Synvert")).to be_falsey
    end
  end

  describe "#get_node_type" do
    it "gets the type of node" do
      node = prism_parse("class Synvert; end").body.first
      expect(adapter.get_node_type(node)).to eq :class_node
    end
  end

  describe "#get_children" do
    it "gets the children of node" do
      node = prism_parse("class Synvert; end").body.first
      child_nodes = adapter.get_children(node)
      expect(child_nodes.size).to eq 8
      expect(child_nodes[1]).to eq 'class'
      expect(child_nodes[2].class).to eq Prism::ConstantReadNode
      expect(child_nodes[2].name).to eq :Synvert
      expect(child_nodes[7]).to eq :Synvert
    end
  end
end
