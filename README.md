# Hello, World Java app and basic CodeQL queries

This is a small Java app to demonstrate how to use CodeQL to find program patterns in code.

It prints "Hello, World!" to the console, and "Hello, foo!" if the first command-line argument is "foo".

It has no error handling, so will throw an exception if no command-line arguments are provided.

## Prerequisites

- Java 8 or later
- CodeQL CLI

## Build the app

```bash
make Main
```

## Run the app

```bash
java Main "foo"
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
