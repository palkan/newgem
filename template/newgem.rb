require "date"

say "👋 Let's scaffold your new gem!\n"

<%= include "gem_details" %>
<%= include "rails_details" %>
<%= include "ruby_next_details" %>
<%= include "github_details" %>
<%= include "ci_details" %>
<%= include "docs_details" %>
<%= include "testing_details" %>

# Move to the destination folder
inside(root_dir) do

  # Base files
  file ".gitignore", <%= code(".gitignore") %>
  file ".gem_release.yml", <%= code(".gem_release.yml") %>
  file "CHANGELOG.md", <%= code("CHANGELOG.md") %>
  file "Gemfile", <%= code("Gemfile") %>
  file "#{name}.gemspec", <%= code("newgem.gemspec") %>
  file "LICENSE.txt", <%= code("LICENSE.txt") %>
  file "README.md", <%= code("README.md") %>
  file "RELEASING.md", <%= code("RELEASING.md") %>
  file "Rakefile", <%= code("Rakefile") %>
  file ".rubocop.yml", <%= code(".rubocop.yml") %>
  file "gemfiles/rubocop.gemfile", <%= code("gemfiles/rubocop.gemfile") %>

  file "lib/#{name}.rb", <%= code("lib/name.rb") %>
  file "lib/#{name_path}/version.rb", <%= code("lib/dir/version.rb") %>

  if use_rails
    file "lib/#{name_path}/railtie.rb", <%= code("lib/dir/railtie.rb") %>
  end

  if lint_docs
    file ".rubocop-md.yml", <%= code(".rubocop-md.yml") %>
    file ".mdlrc", <%= code(".mdlrc") %>
    file "forspell.dict", <%= code("forspell.dict") %>
  end

  if use_github
    file ".github/PULL_REQUEST_TEMPLATE.md", <%= code(".github/PULL_REQUEST_TEMPLATE.md") %>
    file ".github/ISSUE_TEMPLATE/bug_report.md", <%= code(".github/ISSUE_TEMPLATE/bug_report.md") %>
    file ".github/ISSUE_TEMPLATE/feature_request.md", <%= code(".github/ISSUE_TEMPLATE/feature_request.md") %>
  end

  if use_ruby_next
    file ".rbnextrc", <%= code(".rbnextrc") %>
    file "Makefile", <%= code("Makefile") %>
  end

  if use_rspec
    file ".rspec", <%= code(".rspec") %>
    file "spec/spec_helper.rb", <%= code("spec/spec_helper.rb") %>

    file ".rubocop/rspec.yml", <%= code(".rubocop/rspec.yml") %>
  else
    file "test/test_helper.rb", <%= code("test/test_helper.rb") %>
  end

  if use_ga
    file ".github/workflows/test.yml", <%= code(".github/workflows/test.yml") %>
    file ".github/workflows/rubocop.yml", <%= code(".github/workflows/rubocop.yml") %>
    file ".github/workflows/release.yml", <%= code(".github/workflows/release.yml") %>

    if lint_docs
      file ".github/workflows/docs-lint.yml", <%= code(".github/workflows/docs-lint.yml") %>
    end

    if use_jruby
      file ".github/workflows/test-jruby.yml", <%= code(".github/workflows/test-jruby.yml") %>
    end

    if use_rails
      file "gemfiles/rails7.gemfile", <%= code("gemfiles/rails7.gemfile") %>
      file "gemfiles/rails8.gemfile", <%= code("gemfiles/rails8.gemfile") %>
      file "gemfiles/railsmain.gemfile", <%= code("gemfiles/railsmain.gemfile") %>
    end

    if use_jruby
      file "gemfiles/jruby.gemfile", <%= code("gemfiles/jruby.gemfile") %>
    end
  end

  git :init
end

say "Congrats! Your gem is ready. Try running `bundle install` and `bundle exec rake` to make sure we configured it correctly."
