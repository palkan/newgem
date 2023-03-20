# frozen_string_literal: true

require "test_helper"

class TemplateTest < Minitest::Test
  def test_template_compiles
    assert RubyBytes::Compiler.new(File.join(__dir__, "../template/newgem.rb")).render
  end
end

