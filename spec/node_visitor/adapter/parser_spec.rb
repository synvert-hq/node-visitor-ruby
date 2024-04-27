# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NodeVisitor::ParserAdapter do
  let(:adapter) { described_class.new }

  describe "#is_node?" do
    it 'gets true for node' do
      node = parser_parse("class Synvert; end")
      expect(adapter.is_node?(node)).to be_truthy
    end

    it 'gets false for other' do
      expect(adapter.is_node?("Synvert")).to be_falsey
    end
  end

  describe "#get_node_type" do
    it "gets the type of node" do
      node = parser_parse("class Synvert; end")
      expect(adapter.get_node_type(node)).to eq :class
    end
  end

  describe "#get_children" do
    it "gets the children of node" do
      node = parser_parse("class Synvert; end")
      expect(adapter.get_children(node)).to eq [parser_parse("Synvert"), nil, nil]
    end
  end
end
