# NodeVisitor

[![Build Status](https://github.com/synvert-hq/node-visitor-ruby/actions/workflows/main.yml/badge.svg)](https://github.com/synvert-hq/node-visitor-ruby/actions/workflows/main.yml)
[![Gem Version](https://img.shields.io/gem/v/node_visitor.svg)](https://rubygems.org/gems/node_visitor)

NodeVisitor allows you to define callbacks based on node type, then visit the AST nodes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'node_visitor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install node_visitor

## Usage

1. initialize the visitor

```ruby
visitor = NodeVisitor.new(adapter: 'prism')
```

2. add callbacks

```ruby
# this will be triggered when it starts to visit class_node
visitor.add_callback(:class_node, at: 'start') do |node|
  node.name # get the name of class node
end

# this will be triggered after it finishes to visit class_node
visitor.add_callback(:class_node, at: 'end') do |node|
  node.name # get the name of class node
end
```

There is a special node type, `:all`, which is triggered before or after visiting all nodes.

```ruby
# this will be triggered after it finishes to visit all nodes
visitor.add_callback(:class_node, at: 'end') do
end
```

3. visit the AST node

```ruby
visitor.visit(node)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/synvert-hq/node_visitor.
