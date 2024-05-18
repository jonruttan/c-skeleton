# c-skeleton

A minimalist C project skeleton to kickstart your C development. This repository provides a basic structure to help you set up your C projects quickly and efficiently.

## Introduction

c-skeleton is a simple and minimalistic starting point for C projects. It includes the essential files and directory structure needed to begin developing C applications.

## Features

- Basic project structure
- Makefile for building the project
- Sample source files
- Directory setup for source, header, and test files

## Prerequisites

Ensure you have the following installed on your system:

- GCC (GNU Compiler Collection)
- Make

## Installation

Clone the repository to your local machine:

```sh
git clone --recurse-submodules https://github.com/yourusername/c-skeleton.git
cd c-skeleton
```

## Usage

To build the project, simply run:

```sh
make
```

To run all tests:

```sh
make test
```

To run a specific test:

```sh
TST=test/main.test.c make test
```

To watch files for changes:

```sh
make watch
```

To clean up the compiled files, use:

```sh
make clean
```

## Project Structure

```
c-skeleton
├── include
│   ├── main.h
│   └── ...
├── src
│   ├── main.c
│   └── ...
├── test
│   ├── main.test.c
│   └── ...
├── .editorconfig
├── .gitignore
├── .gitmodules
├── CHANGELOG.md
├── LICENSE.md
├── Makefile
└── README.md
```

- **include/**: Contains the header files (.h files).
- **src/**: Contains the source files (.c files).
- **test/**: Contains the test files (.test.c files).
- **.editorconfig**: A file to define editor coding styles (https://editorconfig.org/).
- **.git**: Version control directory.
- **.gitignore**: Specifies intentionally untracked files to ignore.
- **.gitmodules**: Defines submodule properties.
- **CHANGELOG.md**: Changelog (https://keepachangelog.com/en/1.1.0/).
- **LICENSE**: License.
- **Makefile**: A file to automate the build process.
- **README.md**: This file.

## Contributing

Contributions are welcome! Please fork this repository and submit a pull request with your improvements.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
