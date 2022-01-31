# Issues

> Practice project from Programming Elixir - Dave Thomas

Command-Line tool to list issues from a GitHub project.

## Installation

Package the comand-line executable:

```sh
$ mix escript.build
```

## Usage

The basic command:

```
$ ./issues <user> <project> [count | 4]
```

Example:

```sh
# See help
$ ./issues -h

# List 5 issues from elixir-lang/elixir project
$ ./issues elixir-lang elixir 5
```
