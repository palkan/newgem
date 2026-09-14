# frozen_string_literal: true

require "test_helper"

class HyperdriveDetailsTest < GeneratorTestCase
  template <<~'CODE'
    <%= include "gem_details" %>
    <%= include "rails_details" %>
    <%= include "hyperdrive_details" %>
    repo_name = "palkan/#{name}"
    use_ruby_next = false
    use_rspec = false
    use_ga = false
    use_jruby = false

    inside(root_dir) do
      file "#{name}.gemspec", <%= code("newgem.gemspec") %>
      file "README.md", <%= code("README.md") %>

      if hyperdrive_skill
        file "hyperdrive.yml", <%= code("hyperdrive.yml") %>
        file "skills/#{name}/SKILL.md", <%= code("skills/SKILL.md") %>
      end
    end
  CODE

  def test_with_dummy_skill
    run_generator(input: ["new-gem", "", "vova dem", "me@vladem.com", "y", "y", "y"]) do
      assert_file_contains "new-gem/new-gem.gemspec", %(s.metadata["hyperdrive_targets"] = "railties")
      assert_file_contains "new-gem/new-gem.gemspec", %(s.metadata["hyperdrive_artifacts"] = "skill")
      assert_file_contains "new-gem/new-gem.gemspec", %(s.files += Dir.glob("skills/**/*") + %w[hyperdrive.yml])
      refute_file_contains "new-gem/new-gem.gemspec", %(# s.metadata["hyperdrive_targets"])

      assert_file_contains "new-gem/hyperdrive.yml", "gems:\n  - new-gem\n"

      assert_file_contains "new-gem/skills/new-gem/SKILL.md", "name: new-gem"
      assert_file_contains "new-gem/skills/new-gem/SKILL.md", "# New Gem"

      assert_file_contains "new-gem/README.md", "## Agent skills"
    end
  end

  def test_without_dummy_skill
    run_generator(input: ["new-gem", "", "vova dem", "me@vladem.com", "n", "y", "n"]) do
      assert_file_contains "new-gem/new-gem.gemspec", %(# s.metadata["hyperdrive_targets"] = "*")
      assert_file_contains "new-gem/new-gem.gemspec", %(# s.metadata["hyperdrive_artifacts"] = "skill")
      assert_file_contains "new-gem/new-gem.gemspec", %(# s.files += Dir.glob("skills/**/*") + %w[hyperdrive.yml])
      refute_file_contains "new-gem/new-gem.gemspec", %(\n  s.metadata["hyperdrive_targets"])

      refute_file "new-gem/hyperdrive.yml"
      refute_file "new-gem/skills/new-gem/SKILL.md"
      refute_file_contains "new-gem/README.md", "Agent skills"
    end
  end

  def test_without_hyperdrive
    run_generator(input: ["new-gem", "", "vova dem", "me@vladem.com", "n", "n"]) do
      refute_file_contains "new-gem/new-gem.gemspec", "hyperdrive"
      refute_file "new-gem/hyperdrive.yml"
      refute_file "new-gem/skills/new-gem/SKILL.md"
      refute_file_contains "new-gem/README.md", "Agent skills"
    end
  end
end
