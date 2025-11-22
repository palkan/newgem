[![Gem Version](https://badge.fury.io/rb/<%= name %>.svg)](https://rubygems.org/gems/<%= name %>)
<% if use_ga %>
[![Build](https://github.com/<%= repo_name %>/workflows/Build/badge.svg)](https://github.com/palkan/<%= name %>/actions)
<% if use_jruby %>
[![JRuby Build](https://github.com/<%= repo_name %>/workflows/JRuby%20Build/badge.svg)](https://github.com/<%= repo_name %>/actions)
<% end %>
<% end %>

# <%= human_name %>

TBD

## Installation

Adding to a gem:

```ruby
# my-cool-gem.gemspec
Gem::Specification.new do |spec|
  # ...
  spec.add_dependency "<%= name %>"
  # ...
end
```

Or adding to your project:

```ruby
# Gemfile
gem "<%= name %>"
```

### Supported Ruby versions

- Ruby (MRI) >= 3.0
<% if use_jruby %>
- JRuby ~> 10.0
<% end %>

## Usage

TBD

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/<%= repo_name %>](https://github.com/<%= repo_name %>).

## Credits

This gem is generated via [`newgem` template](https://github.com/palkan/newgem) by [@palkan](https://github.com/palkan).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
