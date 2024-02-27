# Hello, World Java app and basic CodeQL queries

This is a small Java app to demonstrate how to use CodeQL to find program patterns in code.

It prints "Hello, World!" to the console, and "Hello, foo!" if the first command-line argument is "foo".

It has no error handling, so will throw an exception if no command-line arguments are provided.

## Prerequisites

- Java 8 or later
- CodeQL CLI
- VSCode
- GitHub CLI
- GNU Make (though you can just use the commands in the `Makefile`, they are not complicated)

## Set up the CodeQL CLI and VSCode Starter workspace

You can [follow these instructions on how to get set up with CodeQL](https://github.com/codeql-workshops/codeql-learning-catalog/tree/master/docs/QLC/100).

It relies on the [GitHub CLI](https://cli.github.com/), and VSCode so grab them first if you haven't already.

## Build the app

```bash
make Main
```

## Run the app

```bash
make run
```

## Build the CodeQL database

```bash
make clean && make
```

## Run the CodeQL queries

Use the VSCode Starter workspace to load the CodeQL database and run the queries.

## License

This is a copyrighted work, and is not released under an open source license.

© Copyright 2024 GitHub, Inc.
