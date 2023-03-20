# Interactive Ruby gem scaffold generator

This repository contains an application template to create a new Ruby gem with a bunch of stuff pre-configured:

- RuboCop w/ Standard (and other plugins).
- Test framework configuration (RSpec or Minitest).
- Rails-related configuration: Railtie, dummy test apps, multiple Gemfiles for CI.
- CI configuration (GitHub Actions only for now).
- Documentation linting tools (Markdown lint, Forspell, RuboCop Markdown, Lychee).
- [Ruby Next][] configuration.

You can pick what you want during the installation process.

## Usage

- Install [Ruby Bytes][]

- Run the command below and follow the instructions:

```sh
$ rbytes install https://railsbytes.com/script/Vqqs8d

What's gonna be the name of your gem?
...
```

[Ruby Bytes]: https://github.com/palkan/rbytes
[Ruby Next]: https://github.com/ruby-next/ruby-next
