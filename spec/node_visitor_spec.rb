require 'spec_helper'

RSpec.describe NodeVisitor do
  it "visits ast nodes" do
    node = prism_parse <<~EOS
      module Foo
        class Bar
          def baz
            42
          end
        end
      end
    EOS

    visitor = described_class.new(adapter: 'prism')
    names = []
    visitor.add_callback(:module_node, at: 'start') { |node| names << node.name.to_s }
    visitor.add_callback(:class_node, at: 'start') { |node| names << node.name.to_s }
    visitor.add_callback(:def_node, at: 'start') { |node| names << node.name.to_s }
    visitor.visit(node)
    expect(names).to eq ['Foo', 'Bar', 'baz']
  end

  it 'catch abort' do
    node = prism_parse <<~EOS
      module Foo
        class Bar
          def baz
            42
          end
        end
      end
    EOS

    visitor = described_class.new(adapter: 'prism')
    names = []
    visitor.add_callback(:module_node, at: 'start') { |node| names << node.name.to_s }
    visitor.add_callback(:class_node, at: 'start') { |node| throw(:abort) }
    visitor.add_callback(:def_node, at: 'start') { |node| names << node.name.to_s }
    visitor.visit(node)
    expect(names).to eq ['Foo']
  end
end
