# frozen_string_literal: true

require "test_helper"

class ExampleTest < GeneratorTestCase
  template <<~'CODE'
    <%= include "gem_details" %>
    say "NAME=#{name}"
    say "PATH=#{gem_path}"
    say "HUMAN_NAME=#{human_name}"
    say "AUTHOR=#{author}"
    say "EMAIL=#{email}"
    say "ROOT=#{root_dir}"
  CODE

  def test_gem_details
    run_generator(input: ["new-gem", "", "vova dem", "me@vladem.com"]) do |output|
      assert_line_printed(
        output,
        "NAME=new-gem"
      )
      assert_line_printed(
        output,
        "ROOT=#{TMP_DIR}/new-gem"
      )
      assert_line_printed(
        output,
        "PATH=new/gem"
      )
      assert_line_printed(
        output,
        "HUMAN_NAME=New Gem"
      )
      assert_line_printed(
        output,
        "AUTHOR=vova dem"
      )
      assert_line_printed(
        output,
        "EMAIL=me@vladem.com"
      )
    end
  end
end
