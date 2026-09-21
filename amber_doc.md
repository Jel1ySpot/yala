# Amber Documentation (nightly-alpha)

> Single-file merge of `docs/nightly-alpha`, in the order defined by `index.json`. Generated on 2026-09-21.

## Contents

- [Getting Started](#getting-started)
  - [Installation](#installation)
  - [Usage](#usage)
  - [FAQ](#faq)
  - [Testing](#testing-1)
  - [What's new](#whats-new)
  - [Migration Guide](#migration-guide)

- [Basic Syntax](#basic-syntax)
  - [Data Types](#data-types)
  - [Expressions](#expressions)
  - [Variables](#variables)
  - [Conditions](#conditions)
  - [Commands](#commands)
  - [Arrays](#arrays)
  - [Loops](#loops)
  - [Functions](#functions)
  - [Importing](#importing)

- [Advanced Syntax](#advanced-syntax)
  - [As Cast](#as-cast)
  - [Builtins](#builtins)
  - [Union Types](#union-types-2)
  - [Type System](#type-system)
  - [Error Handling](#error-handling)
  - [Compiler Flags](#compiler-flags)

- [Standard Library](#standard-library)
  - [Array](#array-1)
  - [Date](#date)
  - [Environment](#environment)
  - [FileSystem](#filesystem)
  - [HTTP](#http)
  - [Math](#math)
  - [Test](#test)
  - [Text](#text-1)

- [Contributing](#contributing)
  - [How to](#how-to)
  - [Guide](#guide)
  - [Compiler structure](#compiler-structure)

- [Amber by Example](#amber-by-example)
  - [Backup Rotator](#backup-rotator)
  - [ShellCheck tester](#shellcheck-tester)
  - [Ubuntu Updater](#ubuntu-updater)
  - [Bot Detector](#bot-detector)
  - [LSP Installer](#lsp-installer)
  - [Awesome Amber](#awesome-amber)

- [Press](#press)

# Getting Started

Welcome to the documentation of Amber the programming language! 🎉

Here is a minimal hello world example:
```ab
echo("Hello world!")
```

## What is Amber?

Amber is a programming language compiled into Bash Script. It was designed with a modern syntax, safety features, type safety and practical functionalities that Bash could not offer. The subsequent section will demonstrate how Amber embodies these characteristics.

### Modern Syntax

Amber is designed based on the ECMA script syntax. The goal was to create a syntax that any developer could feel comfortable with. Hence, Amber draws on features from languages like Rust and Python.

### Safety Features

When Bash command fails - it carries on with the code execution as if nothing has happened. This could lead to some serious problems and side effects that are irreversible.

We dislike this behavior. This is why Amber will not compile if edge cases aren't handled - whether that involves displaying an error message to the user or failing silently.

### Type Safety

Amber comes with a straightforward type system that aids in identifying simple bugs and errors at compile time, yet it remains unobtrusive, allowing you to focus on what matters most in scripting: the logic.

### Extra Features

Amber supports things that are essential to developer like floating point arithmetic, a non-obscure way to handle arrays or even passing variables by reference instead of by copy. In addition to that Amber comes with a standard library that includes features like text trimming, summing all number in an array, splitting text and many more.

### Supported Environments

Amber's compiled Bash scripts are actively tested across a range of environments.

| Environment       | Version Range | Status               | Notes                                                              |
|-------------------|---------------|----------------------|--------------------------------------------------------------------|
| **Bash (Linux) GNU**  | 3.2 - 5.3     | Under Testing | All versions within this range are tested using [tianon/docker-bash](https://github.com/tianon/docker-bash). |
| **Bash (macOS)**  | 3.2           | Under Testing | Verified through GitHub Actions `macos-latest` environments.       |
| **Bash (Linux) Busy Box**           | Latest           | Under Testing | Busy box environment. As of right now latest is 5.3 |

---

If you're wondering who Amber is for or why to use it instead of other languages, check the [FAQ](getting_started/faq).

## Installation

#### Support for architectures

The Amber compiler currently works on:
- Linux x86 and ARM
- macOS x86 and ARM (Apple Silicon)
- Windows over WSL 2

#### Preparation for installation

### macOS
On macOS, you should have everything preinstalled (curl, bash, bc).

### Linux
Make sure that the operating system meets the following prerequisites
- Install the basic calculator:
  - On Debian and Ubuntu: `sudo apt install bc` 
  - On Arch: `sudo pacman -Syu bc`
  - On Fedora: `sudo dnf install bc`
  - On OpenSUSE: `sudo zypper install bc`
  
- `curl` and `bash` are both installed by default in most cases. 
  In the very rare case that they happen to be not available yet, download them as well.

> DETAILS: You should always update the system before you install a package in a rolling release distro, such as **Arch** and **Tumbleweed.**  Always reboot after an update of the kernel, init system, and similar software as well. 

### Installation with Homebrew

Running this snippet will install latest stable version.

```sh
brew install amber-lang/amber/amber-lang
```

### Installation via bin, the binary package manager

**Install bin itself**:

Download the binary for your platform here:

```
https://github.com/marcosnils/bin/releases 
```

And then make it executable: 

```
chmod +x ./bin_0.24.2_linux_amd64
```

And now run it from the directory where it is located:

```
./bin_0.24.2_linux_amd64 install github.com/marcosnils/bin
```

And now, install Amber:

```
bin install github.com/amber-lang/amber
```

Update it via:

```
bin update
```

> DETAILS: Bin can install all binaries that are hosted somewhere on GitHub, Codeberg, and other locations. For detailed documentation, see: [Commands Reference](https://github.com/marcosnils/bin?tab=readme-ov-file#-commands-reference)

### Installation via script

- **System-wide**
```bash
bash <(curl -sL "https://github.com/amber-lang/amber/releases/download/0.5.1-alpha/install.sh")
```
- **Local-user**
```bash
bash -- <(curl -sL "https://github.com/amber-lang/amber/releases/download/0.5.1-alpha/install.sh") --user
```

- **Available versions with package managers**

<div style="width:250px;margin: 0 auto;">
[![Packaging status](https://repology.org/badge/vertical-allrepos/amber-lang.svg)](https://repology.org/project/amber-lang/versions)
</div>

#### NixOS Channel

The name of the package is `amber-lang`.
- **configuration.nix**
```nix
  environment.systemPackages = [
    pkgs.amber-lang
  ];
```
- **And with home manager:**
```nix
  home.packages = with pkgs; [
    amber-lang
  ];
  programs.home-manager.enable = true;
```

- **Start a shell with:**

```nix
nix-shell -p amber-lang
```

#### NixOS with Flakes

- **You can use the Amber flake like this:**

```nix
{
    inputs = {
        # ...
        amber.url = "github:amber-lang/Amber";
    };
}
```

- **Flakes with home manager:**

```nix
home.packages = [ inputs.amber.packages.${pkgs.system}.default ];
```
While developing with Nix, the flake defines all dependencies for `nix develop` (or `direnv` if used).

#### Snap

```bash
sudo snap install amber-bash --classic
```

### Windows Support

As Windows does not come with bash installed, it makes no sense to support it.  
Please install WSL 2 on your Windows machine and install the Linux version of the Amber compiler inside.

For it to work, you may need to run the following code that pulls all the prerequisites.  
These count for Debian and Ubuntu-based images.

```sh
sudo apt install curl bc
sudo mkdir /opt /usr/local/bin
```

### Integration of external tools

Amber is currently an alpha-stage project, and to implement some features, we have chosen to integrate external tools.  
If these tools are available on your system, they will be executed at the end of the Bash compilation process.

* [bshchk](https://github.com/b1ek/bshchk): A runtime Bash dependency checker. Install it separately on your system to enable automatic checking of external command dependencies in your compiled scripts. See the [bshchk repository](https://github.com/b1ek/bshchk) for installation instructions.

> [!TIP]
> bshchk is not included with Amber. For more information about using it, including inline directives and disabling it when needed, see the [Postprocessors section in the Usage guide](getting_started/usage#postprocessors).

### Uninstallation

If you have installed it via the script installation option, simply run the following code snippet.

```sh
bash -- <(curl -sL "https://github.com/amber-lang/amber/releases/download/0.5.1-alpha/uninstall.sh")
```

## Usage

The Amber CLI can be used as a runtime or as a compiler.

### Command Line Interface

The Amber CLI syntax uses subcommands, like the Git CLI:

*This output is generated from the 0.5.2-alpha version.*
```
Usage: amber [OPTIONS] [INPUT] [ARGS]... [COMMAND]

Commands:
  eval        Execute Amber code fragment
  run         Execute Amber script
  check       Check Amber script for errors
  build       Compile Amber script to Bash
  docs        Generate Amber script documentation
  completion  Generate Bash completion script
  test        Run Amber tests
  help        Print this message or the help of the given subcommand(s)

Arguments:
  [INPUT]    Input filename ('-' to read from stdin)
  [ARGS]...  Arguments passed to Amber script

Options:
      --no-proc <NO_PROC>  Disable a postprocessor
                           Available postprocessors: 'bshchk'
                           To select multiple, pass multiple times with different values
                           Argument also supports a wildcard match, like "*" or "b*chk"
  -h, --help               Print help
  -V, --version            Print version
```

For detailed usage instructions, refer to the [Amber usage guide](https://docs.amber-lang.com/getting_started/usage).

#### Running Amber Code

The following command will simply execute `hello.ab` as a script file. Amber code will be compiled to Bash and then executed all in one go:

```sh
$ amber run hello.ab
Hello world!
```

Alternatively, if the file contains a _shebang_ line and has the executable bit set, it can be run like this:

```ab
#!/usr/bin/env amber
echo("Hello world")
```

```sh
$ ./hello.ab
Hello world
```

Additionally, command line arguments can be passed to the script:

```ab
#!/usr/bin/env amber
main(args) {
    for arg in args {
        echo(arg)
    }
}
```

```sh
$ ./args.ab 1 2 3
1
2
3
```

#### Preventing Execution with Bash

If you write an Amber script with a shebang pointing to `amber`, there is a risk that someone might accidentally execute it with `bash` instead. To prevent this, you can add a check at the top of your script using the following technique:

```ab
// 2> /dev/null; exit 1

// Your Amber code here
echo("Hello world")
```

This line is valid in both Amber and Bash:
- In **Amber**, `//` starts a comment, so the line is ignored
- In **Bash**, `//` is treated as a comment (ignored), `2> /dev/null` suppresses errors, and `exit 1` terminates the script with an error code

For more information about running Amber scripts, see [Running Amber Code](#running-amber-code).

If you want to run just a small code snippet, you can do that as well:

```sh
$ amber eval '
import * from "std/text"
echo(uppercase("Hello world!"))
'
HELLO WORLD!
```

#### Compiling Amber Scripts

There are times when you prefer to just compile Amber code to a script, for example when dealing with _cron jobs_:

```sh
$ amber build input.ab output.sh
```

You’ll notice that the compiled script is immediately callable; hence, there’s no need to add executable permissions using `chmod`, for instance. Amber grants the permission automatically.

Furthermore, Amber adds a _shebang_ at the top of the compiled script. This enables you to run the code simply, without any additional commands:

```sh
$ ./output.sh
```

### Testing

Amber comes with a built-in test runner. You can define named test blocks in your code and execute them using the `amber test` command.

```sh
$ amber test
```

For more details on writing and filtering tests, please refer to the [Testing guide](https://docs.amber-lang.com/getting_started/testing).

### Syntax Highlighting

[VS Code](https://code.visualstudio.com) as well as [Zed](https://zed.dev) now have built-in LSP integration.

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://docs.amber-lang.com/images/lsp-example-dark.webp">
  <img alt="Amber LSP Feature" src="https://docs.amber-lang.com/images/lsp-example-light.webp" width="100%">
</picture>


Here is a list of plugins that support syntax highlighting for Amber language.

| Icon | Name | Location |
|---|:----:|:-----:|
| LOGO:hx | **Helix Editor** | [Native Support](https://docs.helix-editor.com/lang-support.html) |
| LOGO:kate | **Kate/KWrite** | [GitHub](https://github.com/amber-lang/amber-kate) |
| LOGO:nova | **Nova** | [Nova extensions](https://extensions.panic.com/extensions/besya/besya.amber/) |
| LOGO:vim | **Vim** | [Our extension repository](https://github.com/amber-lang/amber-vim) |
| LOGO:vsc | **VS Code** | [VSC Marketplace](https://marketplace.visualstudio.com/items?itemName=Ph0enixKM.amber-language) or [Our extension repository](https://github.com/amber-lang/amber-vsc) |
| LOGO:zed | **Zed** | Zed extensions or [Our extension repository](https://github.com/amber-lang/zed-amber-extension) |
|| **JetBrains** | [JetBrains extension](https://plugins.jetbrains.com/plugin/32151-amber-language) | 


### Other interesting commands

#### Postprocessors

Amber supports postprocessors that can optionally run after compilation to enhance your scripts. These tools are not included with Amber but will be executed automatically if they are installed on your system.

##### bshchk

[bshchk](https://github.com/b1ek/bshchk) is a runtime Bash dependency checker. It analyzes your compiled Bash script to ensure all external commands used are available at runtime, preventing runtime failures due to unavailable dependencies.

**Features:**
- Detects missing external commands before script execution
- Prevents runtime failures due to unavailable dependencies
- Supports inline directives for fine-grained control

For installation instructions and usage details, please refer to the [bshchk README](https://github.com/b1ek/bshchk#readme).

#### Minification

Additionally, the `--minify` option compresses the generated Bash code to reduce its size:

```sh
$ amber build --minify input.ab output.sh
```

#### Generating Amber Documentation

The following command extracts comments prefixed with `///` (triple slashes) from a single Amber file, and generates a Markdown file for documentation, by default in the `docs` subdirectory:

```sh
$ amber docs stdlib.ab
```

#### Generating Bash Completion Scripts

The following command generates a [Bash completion](https://en.wikipedia.org/wiki/Command-line_completion) script:

```sh
$ amber completion
_amber() {
    local i cur prev opts cmd
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
...
```

This can be sourced in the `.bashrc` file via command redirection, so that command completion works in all subsequently opened Bash shells.  Assuming the `amber` binary is on the system path:

```sh
$ cat ~/.bashrc
...
source <(amber completion)
...
```

#### Disabling the Optimizer

The optimizer is still being improved. If you encounter any issues with optimization, you can disable it using an environment variable:

```sh
AMBER_NO_OPTIMIZE=1 amber ...
```

#### Custom Header and Footer

Amber allows you to customize the header and footer of compiled scripts using environment variables:

**AMBER_HEADER**: Path to a custom header file that replaces the default header. The header can use template variables:
- `{{ version }}` - Amber compiler version

**AMBER_FOOTER**: Path to a custom footer file that appends to the end of the script. The footer can use:
- `{{ version }}` - Amber compiler version

**Example custom header (`custom_header.sh`):**
```bash
#!/usr/bin/env bash
# Custom header for production scripts
# Project: {{ version }}
# Generated on: $(date)
```

**Example custom footer (`custom_footer.sh`):**
```bash
# Custom footer
# End of generated script
```

**Usage:**
```sh
# Using custom header
AMBER_HEADER=./custom_header.sh amber build input.ab output.sh

# Using both header and footer
AMBER_HEADER=./custom_header.sh AMBER_FOOTER=./custom_footer.sh amber build input.ab output.sh
```

**Default header:**
```bash
#!/usr/bin/env bash
# Written in [Amber](https://amber-lang.com/)
# version: {{ version }}
```

Note: Custom headers and footers are useful for adding project-specific metadata, license information, or runtime checks to your compiled scripts.

## FAQ

### Who is Amber for?

Amber is aimed at developers who need the power of a modern programming language while staying within the ubiquitous Bash environment. It is especially useful for:
- System administrators automating complex tasks.
- DevOps engineers writing portable scripts.
- Developers who want type‑safety and richer abstractions without abandoning the shell.

### Why not Python?

Python excels at many domains, but it requires a separate runtime and often incurs additional deployment overhead. Amber compiles directly to Bash, so you can:
- Leverage existing shell tooling and pipelines.
- Deploy a single script without installing a language interpreter.
- Benefit from Bash‑native features (process substitution, job control) while enjoying high‑level syntax and safety.

### Why not write Bash directly?

Pure Bash scripts lack static type checking, modular imports, and modern language constructs. Amber provides:
- A type system that catches errors early.
- Structured imports and modules for better code organization.
- Built‑in helpers (e.g., safe string interpolation, automatic error handling) that reduce boilerplate.

### How does Amber compare to other languages?

| Feature | Amber | Bash | Python | 
|---|---|---|---|
| Compiles to Bash | ✅ | ✅ | ❌ | 
| Static typing | ✅ | ❌ | ✅ |
| Native shell integration | ✅ | ✅ | ❌ |
| Learning curve | Low | Moderate | Moderate |

Amber fills a niche between lightweight shell scripting and full‑featured high‑level languages.

### Is Amber production‑ready?

Amber is under active development. The **nightly** provides the latest features and improvements, but may contain breaking changes.  
For production workloads, we recommend using the latest stable release (e.g., `0.5.x`) rather than the nightly build.

In the the project it is production ready because it is already used in this context because the Bash code generated is tested and confirmed that works, the language is evolving with the tooling set.

### Can I use Amber for system scripts?

Yes. Amber is designed for exactly that purpose. It can replace many typical Bash one‑liners and larger maintenance scripts, offering better readability, safety, and testability while still running on any POSIX‑compatible system.

### What shells does Amber support?

Currently, Amber targets **Bash** versions 3.2 through 5.3. We actively test across:
- Linux (GNU bash 3.2-5.3)
- macOS (bash 3.2)

The compiled code is highly portable and will run on any system with the target shell installed.

### Can Amber compile to other shells like Zsh or POSIX sh?

Yes, this is actively being developed. Amber currently targets Bash as its primary shell, but we're working on mechanisms to allow targeting different shells. For now, you can use Amber's built-in features that have equivalents in POSIX shell, and we're working on a target configuration that will let you specify the target shell.

### Why not just use an LLM to write scripts?

LLMs can generate scripts, but they come with their own challenges:
- Scripts may only work on your machine with your specific Bash version
- No type safety or compile-time error checking
- Security concerns with AI-generated code

Amber provides the ease of writing with a modern syntax while ensuring your scripts work reliably across different environments.

### Is Amber better than Python for shell tasks?

It depends on your needs:

| Consider Amber if... | Consider Python if... |
|---------------------|----------------------|
| You need maximum portability (only Bash required) | You need external dependencies (pip packages) |
| Your scripts should run on any Unix-like system | You control the strict deployment environment |
| You want type safety in shell scripting | You need complex data structures or pip dependencies |
| You prefer Bash-native features | You need complex APIs or specific integration with other technologies |

Many users use Amber for system administration and DevOps tasks where portability matters, and Python for application development where ecosystem matters more.

### Can I use Amber for CI/CD pipelines?

Absolutely! Amber shines in CI/CD because:
- Only Bash is required (pre-installed on all CI runners)
- Type safety catches errors before they reach production
- Scripts compile to clean, readable Bash
- *Bshchk* validation ensures dependencies exist
- The compiler itself can be installed via various methods (bin, brew, pip, etc.)

We even use Amber to generate parts of our own documentation!

### How does Amber handle error cases?

Amber enforces explicit error handling at compile time. If a function can fail, Amber will not compile your code unless you handle both success and failure cases, either by displaying an error message or failing silently. This prevents the "silent failure" problem common in Bash scripts where commands fail but execution continues as if nothing happened.

### Can Amber generate Bash that ShellCheck would accept?

Yes! Our focus on clean Bash generation means the compiled code follows ShellCheck (not yet at 100%) best practices. We're also working on integrating ShellCheck into our CI pipeline to ensure the generated code maintain high quality standards.

### Is Amber suitable for beginners?

Yes, Amber is designed to be approachable:
- Syntax similar to JavaScript/Python/Rust (familiar to most developers)
- Type system catches common mistakes early
- Built-in functions reduce boilerplate
- Documentation includes many examples
- The compiler provides helpful error messages

Many users start with Amber to learn scripting concepts before moving to more complex languages.

### Why was Amber created?

The project started as a PhD research topic, focusing on making Bash scripting safer and more maintainable. It gained community interest and evolved into a full project.

## Testing

Test blocks are dedicated scopes for writing tests. They are executed only when running the `amber test` command and are ignored during normal compilation. Test blocks can be optionally named using a string literal. This improves readability and allows for targetted execution.

#### Syntax
```ab
import { assert } from "std/test"

// Unique named test block
test "can multiply numbers" {
    let result = 10 * 2
    assert(result == 20)
}

// Unnamed test block (only one allowed per file)
test {
    let name = "Amber"
    assert(name + " Lang" == "Amber Lang")
}
```

### CLI Test Filtering

The `amber test` command is designed to verify the correctness of your code by executing test blocks. By default, it recursively finds and runs all tests in the current directory. You can narrow down which tests to run by providing filter arguments.

#### Filtering Tests

You can run a specific subset of tests by providing a filter argument. This argument performs a substring match against both the **filename** and the **test name**.

```bash
# Run all tests located in the current directory containing "variable" in their name or filename
amber test . "variable"
```

#### Targeting Specific Files

Instead of running tests from the current directory, you can specify a particular file or directory to scan.

```bash
# Run all tests inside main.ab
amber test main.ab

# Run all tests in main.ab that contain "zip" in their name
amber test main.ab "zip"
```

## What's new

> WARNING: Brief description of new changes TBD when releasing

### Union Types
Union types provide a flexible way to define function parameters that can accept values of multiple distinct types.

```ab
fun print_value(val: Int | Text | Bool) {
    echo(val)
}

print_value(42)       // Valid
print_value("Amber")  // Valid
print_value(true)     // Valid
```

### Testing suite
Amber now features a built-in testing suite. It allows you to write dedicated `test` blocks that are only executed when running the `amber test` command.

We also introduced a new `std/test` library. More on that in the [Standard library improvements](#standard-library-improvements) section.

```ab
test "can multiply numbers" {
    let result = 10 * 2
    // assertions ...
}
```

You can also name your tests for better readability and filter them by name or filename using CLI arguments. Read more in the [Testing Guide](testing).

### Improved variable diagnostics

The compiler now surfaces clearer warnings when variables are not used, helping you catch mistakes earlier. It also warns when a variable declared with `let` is never modified, encouraging the use of `const` for bindings that never need reassignment.

```ab
let unused = 1 // Warning: variable 'unused' is not used
let count = 3  // Warning: variable 'count' is never modified - consider using 'const'
echo(count)

```

### New builtins syntax

All builtins like `echo` now have new syntax similar to functions:

```ab
echo("Hello world")
cd("newdir")
mv("file.ab", "newdir")
exit(1)
```

### Array Type Resolution

Amber now supports type inference for empty arrays `[]`. You can initialize an empty array without specifying its type immediately. The type will be resolved later based on how the array is used, such as in assignments, binary operations, or function calls.

```ab
let arr = [] // Type is generic
arr += [1]   // Resolved to [Int]
```

### Array destructing

You can now destruct arrays into separate variables:

```ab
let arr = [1,2,3]
let [key1, key2, key3] = arr

echo("{key1} {key2} {key3}") // 1 2 3
```

### Standard library improvements

> WARNING: Brief description of new changes TBD when releasing

#### New std/test module

We introduced a new [`std/test`](stdlib/doc/test) library that provides `assert` and `assert_eq` functions to help you write tests.

```ab
import { assert, assert_eq } from "std/test"

test "can multiply numbers" {
    let result = 10 * 2
    assert(result == 20)
    assert_eq(result, 20)
}
```

#### New fetch function for HTTP requests

The `fetch` function provides a functionality for making HTTP requests. It intelligently utilizes available command-line tools for network operations, with a failover to bash's network sockets. This function supports a comprehensive set of HTTP methods, including `GET`, `POST`, `PUT`, and `DELETE`.

```ab
import { fetch } from "std/http"

let response = trust fetch("https://example.com")
let post_request = trust fetch("https://example.com", "POST", "hello world!", [ "content-type: text/plain" ]) // POST request
```

## Migration Guide

This guide provides a step-by-step walkthrough for migrating code from 0.4.0-alpha to 0.5.0-alpha. The current version introduces several breaking changes. This document outlines the modifications, explains how to adapt your code to maintain the same behavior, and highlights updated features. In this guide we will cover two main categories of changes:
1. **Language Features**: Changes and updates to the core language syntax and semantics.
2. **Standard Library Updates**: Modifications to existing standard library functions and their usage.

Follow along to ensure a smooth transition to the new version. Let’s get started!

### New integer Int data type

Previously, Amber supported only the `Num` type. This release introduces `Int`, which maps to Bash’s native integer arithmetic. To support this, we’ve updated parts of the language syntax.

#### Array subscript

Expression in the subscript can only be of type `Int`.

```ab
// Before
arr[12.0] // Ok; although fails

// After
arr[12.0] // Error: array subscript can only be an integer
```

#### Range

Expressions in range operator can only be of type `Int`.

```ab
// Before
10.0..15.0 // OK; although fails

// After
10.0..15.0 // Error: range can only be applied on integers
```

#### Iterator

Iterator variable in for-loop is now of type `Int`.

```ab
// Before
for i, item in items {} // `i` is a `Num`

// After
for i, item in items {} // `i` is an `Int`
```

#### Exit

Exit builtin now accepts only expressions of type `Int`.

```ab
// Before
exit 2.0 // Ok; although fails

// After
exit 2.0 // Error: exit accepts only `Int` type
```

#### Status

The `status` builtin now returns a value of type `Int`.

```ab
// Before
status // Returns `Num` value

// After
status // Returns `Int` value
```

#### Len

The `len` builtin now returns a value of type `Int`.

```ab
// Before
len(text) // Returns `Num` value

// After
len(text) // Returns `Int` value
```

### Text to Bool Casting Warning

Casting `Text` to any values including `Bool` and `Int`, now issues an "absurd cast" warning. While not an error, it indicates a potential logical issue and encourages explicit conversion for clarity.

```ab
// Before
echo "true" as Bool then 1 else 0 // OK

// After
echo("true" as Bool then 1 else 0) // Warning: Absurd cast
```

### Escaping Changes

#### String Literal Escaping Changes

A bug related to the escaping of `$` sequences within string literals has been fixed. Previously, `"\$variable"` would incorrectly interpolate the value of `variable` instead of treating `$` as a literal character. If your code inadvertently relied on the previous buggy behavior where `\$` within a string literal was interpolated, you will now observe the correct behavior where `\$` is treated as a literal dollar sign. You may need to adjust your string literals if you intended interpolation in such cases.

```ab
// Before
let var = 45
echo "\$var" // Output: 45

// After
let var = 45
echo("\$var") // Output: \$var
```

#### Command String Escaping Changes

The internal handling of text within commands has been refactored, leading to a breaking change in how double quotes (`"`) should be escaped within command strings. Previously, `"` might have been escaped with `\"` in some contexts, but this is no longer the correct behavior.

Double quotes (`"`) should *not* be escaped with a backslash (`\`) when used within command strings. The parser now handles this automatically. If your code contains command strings where double quotes are escaped (e.g., `$ echo \"hello\" $`), you must remove the backslash.

```ab
// Before (will now cause an error or incorrect behavior)
trust $ printf \"Amber\" $ // Incorrect: will now be interpreted as a literal backslash followed by a double quote

// After (correct behavior)
trust $ printf "Amber" $ // Correct: the double quote is handled by the parser
```

### Standard Library Updates

#### Redesigned std/date

The standard library’s Date module has been completely overhauled. We improved how its functions compose, removed obsolete ones, and repurposed others. The complete list of changes is below.

| Old Name | New Name | Description |
|:--|:--|:--|
| `date_posix` | `date_from_posix` | Converts textual representation in a default `YYYY-MM-DD HH:MM:SS` format to [unix epoch time](https://en.wikipedia.org/wiki/Unix_time) |
| *new* | `date_format_posix` | Converts [unix epoch time](https://en.wikipedia.org/wiki/Unix_time) to a textual representation. |
| `date_add` | `date_add` | Adds time to passed date. |
| *new* | `date_sub` | Subtracts time to passed date. |
| *removed* | `date_compare` | Compares two dates and returns value of a sign function. |

#### Regex Functions Compatibility Changes

To improve cross-platform compatibility, especially with macOS and BusyBox environments, the standard library functions `match_regex()` and `replace_regex()` no longer support certain GNU Sed-specific regular expression features. If your existing code relies on these GNU Sed-specific features within `match_regex()` or `replace_regex()`, you will need to update your regular expressions to use POSIX-compliant alternatives. For example, instead of `\b`, you might use `[[:<:]]` and `[[:>:]]` for word boundaries, or ensure you are using ERE for alternation (`|`).

The following regular expression features are no longer supported within `match_regex()` and `replace_regex()`:
*   `\b` (word boundary) in both Extended Regular Expressions (ERE) and Basic Regular Expressions (BRE).
*   `|` (alternation) in Basic Regular Expressions (BRE).

#### Function Renaming

The standard library function `parse_number` has been renamed to `parse_num` to align with the new `Int` data type and improve clarity. If your code directly calls `parse_number`, you will need to update these calls to `parse_num`.

```ab
// Before
const num_val = trust parse_number("123.45")

// After
const num_val = trust parse_num("123.45")
```

#### Functions Now Failable

Several standard library functions that previously returned a `Bool` to indicate success or failure have been updated to be failable functions. This change aligns with Amber's failable paradigm, providing a more consistent and robust error handling mechanism. These functions no longer return a `Bool`. Instead, they will either succeed or fail, triggering the failable mechanism (e.g., propagating failure with `?` or being caught by a `failed` block).

**Affected Functions:**
- `std/fs::symlink_create`
- `std/fs::dir_create`
- `std/fs::file_chmod`
- `std/fs::file_chown`
- `std/net::file_download`

```ab
// Before
if dir_create("my_directory") {
    echo "Directory created successfully."
} else {
    echo "Failed to create directory."
}

// After
dir_create("my_directory") exited(code) {
    if code == 0:
        echo("Directory created successfully.")
    else:
        echo("Failed to create directory.")
}
```

#### Removed env_const_get Function

The `env_const_get` function has been removed from `std/env`. Use `env_var_get` instead, which provides the same functionality.

```ab
// Before
env_const_get("VAR")

// After
env_var_get("VAR")
```

---

# Basic Syntax

> This documentation assumes a foundational understanding of programming concepts.

Since Amber is designed with a syntax inspired by ECMAScript, some aspects of the programming language may appear familiar.

> We suggest to take a look on [the examples](https://docs.amber-lang.com/by_example/examples) we provide to see real use cases written in Amber.

Here, we may notice an echo built-in function, which performs the same operation as Bash’s echo command.

Here is a code snippet that illustrates certain features of Amber. We will provide detailed explanations for each of these features and cover additional content in the forthcoming chapters.

```ab
// Define variables
let name = "John"
let age = 30

// Display a greeting
echo("Hello, my name is {name}")

// Perform conditional checks
if age < 18 {
    echo("I'm not an adult yet")
} else {
    echo("I'm an adult")
}

// Loop through an array
let fruits = ["apple", "banana", "cherry", "date"]
echo("My favorite fruits are:")
for fruit in fruits {
    echo(fruit)
}
```

## Data Types

In Bash there is only one primitive data type, string, which internal implementation is represented by an array of characters `char*`. Amber extends on this data type to introduce a few more.

Amber supports six data types:
- `Text` - The textual data type. In other programming languages it can also be called "string".
- `Int` - Integer data type.
- `Num` - The numeric data type. It's basically any number.
- `Bool` - The boolean data type. It's value can be either `true` or `false`.
- `Null` - The _nothing_ data type.
- `[]` - The array data type.

### Text

`Text` data type is the most basic data type in Amber. It's just a string of characters and is also stored as a string of characters under the hood.

Text literal in Amber is contained between double quotes. Amber makes sure to prevent content inside from [globbing](https://en.wikipedia.org/wiki/Glob_%28programming%29). This prevents unexpected behaviors from happening.

```ab
// `Text` literal:
"Welcome to the jungle"
```

Just like in other programming languages, characters in `Text` literals can be escaped.

| Escape Sequence | Description |
| :-------------- | :---------- |
| `\n`            | Newline     |
| `\t`            | Tab         |
| `\r`            | Carriage return |
| `\0`            | Null byte   |
| `\{`            | Literal `{` |
| `\$`            | Literal `$` |
| `\'`            | Literal `'` |
| `\"`            | Literal `"` |
| `\\`            | Literal `\` |

Any other escape sequence not listed above will be treated as a literal escape sequence, similar to how Bash handles them. For instance, escaping `\c` will result in the literal `\c` being output.

### Integer

Under the hood its value is stored as a string of characters - the same way as it's done in Bash. However when performing operations the values are treated as 64-bit signed integers.

```ab
// `Int` data type
42
-123
```

This data type is the most performant way to compute integers. Later we will discover how `Num` data type can let us compute numbers using floating point arithmetic.

### Number

Similarly to `Int` its value is stored as a string of characters. The difference is that Amber applies standard commands to do operations on numbers that support _floating point_ values so that you can simply write operator sign instead.

> WARNING: The `Num` data type currently requires the `bc` command to be installed on your operating system when running compiled Amber code. For portability, it is recommended to use the `Int` data type whenever possible.

```ab
// `Num` data type
42.0
-123.456

// You can implicitly cast `Int` to `Num`
let variable = 12.12
// The variable keeps type of `Num`
variable = 24
```

We will learn more about variables in the upcoming chapters.

### Boolean

Boolean values are translated to `0` or `1` numerical values. These values can be easily [cast](https://docs.amber-lang.com/advanced_syntax/as_cast) to numbers `Num`.

```ab
// `Bool` data type
true
false
```

### Null

```ab
// `Null` data type
null
```

The most common use of this data type is to indicate that a function does not return a value. Currently, there is no practical real-world scenario where using a null literal is necessary, as it serves no functional purpose at this time.

### Array

Arrays in Amber and Bash are dynamically allocated. When creating an array literal it is important to specify of which data type the array should be made. Type signature of arrays can be represented with `[T]` where `T` is the value type that this array holds. Example: an array of type `Num` is `[Num]` (in C like languages it would be `Num[]`).

To create an array literal simply enclose a list of elements separated with a comma `,` with square brackets `[]`.

```ab
// `[Num]` data type
[1, 2, 3]
// `[Text]` data type
["apple", "banana", "orange"]
```

#### Array Type Resolution

Amber supports type inference for empty arrays. You can initialize an empty array using `[]` without specifying its type immediately. The type will be resolved later based on how the array is used.

```amber
// Initializes an empty array with unresolved type
let array = [] 
// The type is resolved to [Int] upon this assignment
array += [1]
```

In edge cases, where type inference is not possible or explicit typing is preferred, you can use the type signature to create an explicitly typed empty array.

```ab
// Example of a value that represents empty array of text
[Text]
```

> WARNING: Due to the bash's limitations it's pretty hard to implement 2D+ arrays to behave as regular arrays. As of right now Amber does not support nested arrays

```ab
[[Bool]]
// Error: Arrays cannot be nested due to the Bash limitations
```

### Union Types

Union types provide a flexible way to define function parameters that can accept values of multiple distinct types. This feature enhances code reusability and polymorphism by allowing a single function to handle different data types safely. Currently, union types are exclusively supported for function parameters. To define a union type, separate the accepted types with a vertical bar (`|`).

#### Examples

Here is an example of a function that accepts either an array of Booleans or an array of Integers:

```amber
fun process_data(data: [Bool] | [Int]) {
    for item in data {
        echo(item)
    }
}

process_data([1, 2, 3])          // Valid
process_data([true, false])      // Valid
// process_data("Invalid")       // Compile-time Error
```

You can also combine primitive types like `Int`, `Text`, and `Bool`:

```amber
fun print_value(val: Int | Text | Bool) {
    echo(val)
}

print_value(42)       // Valid
print_value("Amber")  // Valid
print_value(true)     // Valid
```

## Expressions

Data type literals can be combined using operators, but these operators only function with values of **the same** data type. For example, attempting to add a `Text` value to a `Num` value will result in an error, as this is an unsupported operation. To combine different types of values into a single text, consider using [string interpolation](https://docs.amber-lang.com/basic_syntax/expressions#text-interpolation) instead.

### Addition Operator +

Addition can be performed on number, text and array. This operator applied on different data types yields different results:

- `Int` and `Num` - Arithmetic sum
- `Text` - String concatenation
- `[]` - Array join

```ab
12 + 42 // 54
"Hello " + "World!" // "Hello World!"
[1, 2] + [3, 4] // [1, 2, 3, 4]
```

### Arithmetic Operations

Arithmetic operations can only be used on `Int` and `Num` data types. Here is the list of all available ones:
- `+` Arithmetic sum
- `-` Substraction
- `*` Multiplication
- `/` Division
- `%` Modulo operation

```ab
((12 + 34) * 9) % 4
```

There is also a unary operator that negates the value stored in [variable](https://docs.amber-lang.com/basic_syntax/variables).

```ab
let value = 12
echo(-value) // Outputs: -12
```

### Comparison Operations

The equality `==` and inequality `!=` operations can be applied to any data type as long as both sides have the same type.

```ab
"foo" != "bar"
42 == 42
true != false
"equal" == "equal"
```

`Int` and `Num` values are compared using standard arithmetic rules. In contrast, `Text`, `[Text]`, and `[Int]` are compared lexically — that is, element by element (or character by character), based on Unicode (or ASCII) values, much like string comparison in most programming languages.

```ab
42 > 24
"file1.txt" > "file.txt"
[42, 12] > [24, 12]
["Hello world"] > ["Hello", "there"]
```

For sequences of different lengths, comparison continues left to right until a difference is found; if one sequence is a prefix of the other, the shorter one is considered smaller. For example, `"cat"` is less than `"catalog"`, and `[1, 2]` is less than `[1, 2, 0]`.

### Logical Operations

Logical operations can only be used on `Bool` data type. As opposed to C-like family of programming languages we've chosen to go for more Pythonic approach with literal names instead of symbols, as it suits the nature of the scripting programming language better: `and`, `or`, `not`.

```ab
18 >= 12 and not false
```

### Shorthand Operator

The addition operator, along with any arithmetic operator combined with the `=` symbol, can be used to automatically update the value of an existing variable with the calculated result.

```ab
let age = 18
age += 5
echo(age) // Outputs: 23
```

### Text Interpolation

Text interpolation is a form of embedding various values into the text literal that are combined with their textual representations.

```ab
echo("State: {false}") // Outputs: "State: 0"
// It's possible to also nest interpolation
echo("1 {" 2 {"3"} 4"} 5") // Outputs: "1 2 3 4 5"
```

In the following table we can see how the interpolation behaves for various data types:

Type  |Description          |Before         |After
------|---------------------|---------------|---------
`Text`|Identity             |`"{"Text"}"`   |`"Text"`
`Num` |Identity             |`"{12.34}"`    |`"12.34"`
`Bool`|`1` or `0`           |`"{true}"`     |`"1"`
`[]`  |Spaces between values|`"{[1, 2, 3]}"`|`"1 2 3"`

```ab
let name = "John"
let age = 18
echo("Hi, I'm {name}. I'm {age} years old.")
// Outputs: Hi, I'm John. I'm 18 years old
```
### Lexical Operations

Lexical operations allow you to compare sequences element by element (or character by character). These operations work with `Text`, `[Text]`, and `[Int]` data types.

```ab
"apple" < "banana" // true - 'a' comes before 'b'
["apple", "pie"] <= ["banana", "bread"] // true - "apple" < "banana"
[5, 1] > [4, 9] // true - 5 is greater than 4
```

## Variables

Variables are the way to store values we discussed earlier. In order to create a variable you can use a `let` keyword. Here is an example:

```ab
let name = "John"
```

The above example shows how to initialize a variable. However if you have already created the one you want, you can reassign it just by name (without using any keywords)

```ab
name = "Rob"
```

And to access the value stored by this variable - just refer to it by name, like so:

```ab
echo(name) // Outputs: "Rob"
```

> WARNING: The Amber compiler reserves all identifiers starting with double underscore `__` in addition to keywords like `let`, `if`, etc.

#### Overshadowing

Variable declarations in Amber can be overshadowed, allowing the redeclaration of an existing variable with a different data type within a specific scope if necessary. Here’s an example:

```ab
// `result` is a `Num`
let result = 123
// `result` is a `Text`
let result = "Hello my friend"
```

### Constant

Constant is a type of variable that cannot be modified.

```ab
const sunrise = "east"
sunrise = "west" // ERROR: Cannot reassign constant 'sunrise'
```

## Conditions

There are three ways to perform conditional logic:
- **If Statement** - This is a regular if statement that can be used anywhere
- **If Chain** - This is _syntactical sugar_ for pesky if-else chained together.
- **Ternary Expression** - This is a way to represent conditional logic within an expression.

### If Statement

The good old if statement that one may recognize from other modern programming languages:

```ab
if age >= 16 {
    echo("Welcome")
}
```

Let's add an `else` branch to the mix

```ab
if age >= 16 {
    echo("Welcome")
} else {
    echo("Entry not allowed")
}
```

In Amber, a simple if condition can often feel unnecessarily bulky. To address this, Amber allows the use of a `:` symbol to replace a full block when you only need to write a single statement. This feature is especially useful for handling multiple conditions with concise, single-statement actions.

```ab
if age >= 16: echo("Welcome")
else: echo("Entry not allowed")

// Or

if age >= 16:
    echo("Welcome")
else:
    echo("Entry not allowed")
```

### If Chain

The if-chain is a streamlined approach for handling a sequence of if-else conditions. Here’s an example to illustrate this concept:

```ab
if {
    drink == "water" {
        echo("Have a natural, mineralized water")
    }
    drink == "cola" {
        echo("Here is your fresh cola")
    }
    else {
        echo("Sorry, we have none of that")
    }
}

// Compact alternative:

if {
    drink == "water": echo("Have a natural, mineralized water")
    drink == "cola": echo("Here is your fresh cola")
    else: echo("Sorry, we have none of that")
}
```

Instead of using the traditional nested if-else structure:

```ab
if drink == "water" {
    echo("Have a natural, mineralized water")
} else {
    if drink == "cola" {
        echo("Here is your fresh cola")
    } else {
        echo("Sorry, we have none of that")
    }
}
```

The if-chain offers a cleaner, more concise, and readable way to handle multiple conditions.

### Ternary Expression

Ternary expressions are ideal for quickly assigning values based on simple conditions. They provide a compact and efficient alternative to traditional conditional statements. Here’s an example:

```ab
let candy = count > 1
    then "candies"
    else "candy"

echo("I have {count} {candy}")
```

To achieve an even more compact form, the ternary expression can be written inline when the expressions involved are concise.

```ab
let candy = count > 1 then "candies" else "candy"
```

This approach makes code concise and readable, especially for straightforward conditional assignments.

## Commands

The only way to access the bash shell is through Amber's commands. Commands can be used in the form of a statement or an expression.

Commands (as well as *failable functions*) can sometimes _fail_, so it’s important for whoever uses them to be ready to handle what happens next. There are different ways to deal with failures, each with its own pros and cons:
- `failed` - the recommended way to handle failing that enables you to write some specific logic to run when a command fails
- `succeeded` - allows you to write specific logic to run when a command completes successfully
- `exited` - allows you to write logic that runs regardless of whether the command failed or succeeded
- `?` - this shorthand for propagating the failure to the caller. This operator can only be used in a `main` block or inside of a function.
- `trust` - the discouraged way to handle failing. This modifier will treat commands as if they have completed successfully and will allow them to be parsed without any further steps.

Here is an example use:

```ab
// Command statement
$ mv file.txt dest.txt $ failed {
    echo("It seems that the file.txt does not exist")
}

// Command expression
let result = $ cat file.txt | grep "READY" $ failed {
    echo("Failed to read the file")
}
echo(result)
```

> DETAILS: Command expression result is sent to the variable instead of _standard output_.

Command can also be interpolated with other expressions and variables

```ab
let file_path = "/path/to/file"
$ cat {file_path} $ failed {
    echo("Could not open '{file_path}'")
}
```

##### Failed

The `failed` modifier allows you to write specific logic that runs only when a command fails. This is useful when you want to handle errors gracefully or perform recovery operations. Note that `failed` can optionally accept an exit code parameter, like `failed(code)`, to access the command's exit code.

```ab
$ cat file.txt $ failed(code) {
    echo("Exited with code {code}.")
}
```

##### Succeeded

Just like `failed` allows you to handle command failures, `succeeded` lets you write specific logic that runs only when a command completes successfully. This can be useful when you want to perform additional operations that should only happen if the command succeeds.

```ab
$ cat file.txt $ succeeded {
    echo("File was read successfully")
}
```

##### Exited

The `exited` modifier allows you to write logic that runs regardless of whether the command failed or succeeded. This is useful when you need to perform cleanup or logging operations that should always happen. Note that `exited` can only be used when an exit code parameter is provided, like `exited(code)`.

```ab
$ cat file.txt $ exited(code) {
    echo("Command finished with exit code {code}")
}
```


#### Status

The `status` keyword allows you to access the exit code of a command. This is the old school and Bash way of handling failures. Its trait is that it holds the exit code of only the previous command or *failable function* call.

```ab
trust $ no-access.txt < "some text" $ // status: 1
trust $ cat available-for-all.txt $ // status: 0
echo("The status code is: {status}" // The status code is 0)
```

#### Failure Propagation

In order to propagate failure to the context above, you can simply use the question mark syntax `?`.

Here is an example:

```ab
$ test -d /path/to/file $?
// Which is the same as

$ test -d /path/to/file $ failed {
    fail status
}
```

To learn more about fail keyword, please read the article covering [failures](https://docs.amber-lang.com/basic_syntax/functions#failing).

### Command Modifiers

Command modifier is a keyword that alters the behavior of a command. Here are some examples:
- `silent` - prevents command from displaying the result to the standard output.
- `trust` - disables Amber's mechanism that requires user to handle failures.

You can learn more details about each command modifier in the forthcoming chapters.

Here is the example usage of a command modifier:

```ab
silent trust $ my command $
```

You can use the command modifiers as modifier scopes. This way you don't have to repeat yourself on multiple commands.

```ab
silent trust {
    $ first command $
    if isReady:
            $ second command $
    $ third command $
}
```

#### Unsafe Command Execution

```ab
trust $ test -d /path/to/file $
```

This will be treated the same way Bash treats statements. If it fails, then carry on with the code execution. This behavior is the one that we were trying to avoid when building Amber. The cases when this method is encouraged are the following:

- You are **fully sure** that this command will complete successfully
- You **do not care** whether the command will fail or not

#### Silencing Commands

You can easily silent given command. Here is an example usage:

```ab
silent $ very loud command $
```

## Arrays

### Ranges

Amber gives us the ability to generate an array of numbers `[Num]` of certain range. There are two types of ranges:
- `a..b` is exclusive from `a` to `b` excluding `b`.
- `a..=b` is inclusive from `a` to `b` including `b`.

```ab
echo(0..10)
// Outputs: 0 1 2 3 4 5 6 7 8 9
echo(0..=10)
// Outputs: 0 1 2 3 4 5 6 7 8 9 10
```

Ranges also support reversed order:

```ab
echo(6..3)
// Outputs: 6 5 4
echo(6..=3)
// Outputs: 6 5 4 3
```

### Arrays

We learned about array literals in the first chapter. In this chapter we will learn how to make use of them. Arrays are indexed from zero.

To store or retrieve a value at a particular index of an array, we can use the following syntax:

```ab
let groceries = ["apple", "banana", "cherry", "date"]
groceries[0] = "kiwi"
echo(groceries[1])
// Outputs: banana
```

We can also _echo_ an entire array:

```ab
echo(groceries)
// Outputs: kiwi banana cherry date
```

To retrieve a slice between a pair of indices of an array, we can use an exclusive range `a..b` or inclusive range `a..=b` (see above) with the following syntax:

```ab
echo(groceries[1..3])
// Outputs: banana cherry
echo(groceries[1..=2])
// Outputs: banana cherry
```

> WARNING: It is not currently possible to *replace* a slice of an array. This means that we can't evaluate expressions like `groceries[1..=2] = ["kiwi"]` yet.

To add an element to an array, we can use the mentioned in the [expressions chapter](https://docs.amber-lang.com/basic_syntax/expressions) addition operator to merge two arrays together.

```ab
let capitals = ["London", "Paris"]
capitals += ["Warsaw"]
let cities = capitals + ["Barcelona", "Florence"]
```

Amber also supports automatic type resolution for empty arrays. You can initialize an empty array `[]` without explicitly typing it, and the compiler will figure out the type from later usages:
```ab
let items = [] // Currently a generic empty array
items += [1]   // Type is resolved to [Int]
```

In order to see more operations on the array data type take a look at the standard library documentation which covers functions such as `join`, `len` or `sum`.

#### Destructing arrays
You can also easily destruct an array into separate variables:
```ab
let groceries = ["apple", "banana", "cherry"]

let [fruit1, fruit2, berry] = groceries

echo(fruit1 // apple)
echo(fruit2 // banana)
echo(berry // cherry)
```

#### Nested Arrays

We already learned that Bash does not support nesting arrays. But what makes this limitation? The answer is that under the hood Bash defines arrays that essentially only store structures containing string value. You can learn more about Bash arrays by reading [the official source code](https://git.savannah.gnu.org/cgit/bash.git/tree/array.h).

```c
typedef struct array {
    arrayind_t max_index;
    arrayind_t num_elements;
#ifdef ALT_ARRAY_IMPLEMENTATION
    arrayind_t first_index;
    arrayind_t alloc_size;
    struct array_element **elements;
#else
    struct array_element *head;
    struct array_element *lastref;
#endif
} ARRAY;

typedef struct array_element {
    arrayind_t ind;
    char *value;
#ifndef ALT_ARRAY_IMPLEMENTATION
    struct array_element *next, *prev;
#endif
} ARRAY_ELEMENT;
```

## Loops

Amber supports three types of loop:
- **Infinite** loop that can only be broken with a `break` keyword
- **Iterator** loop that iterates over an array
- **While** loop that runs as long as a condition is true

Within loops, the `break` and `continue` keywords can be used to control the flow of execution effectively.

### Infinite Loop

An infinite loop executes its code repeatedly without end until a `break` statement is used to exit the loop.

```ab
let i = 0
let sum = 0
loop {
    if i == 5:
        break
    i += 1
    sum += i
}
echo(sum)
// Outputs: 15
```

### Iterator Loop

It's the most encouraged way to iterate over an array. The example in the previous chapter can be rewritten to a more concise version:

```ab
let sum = 0
for i in 0..5 {
    sum += i
}
echo(sum)
// Outputs: 10
```

Here is another example showing iterator loop in action:

```ab
let files = ["config.json", "file.txt", "audio.mp3"]

for index, file in files {
    $ mv {file} {index}{file} $ failed {
        echo("Failed to rename {file}")
    }
}
```

The above example will iterate through all the files in the array and index them according to their order in the array. As a result, these files will be renamed to `0config.json`, `1file.txt`, and `2audio.mp3`.

### While Loop

The `while` loop is used to repeat a block of code as long as a condition is true. It's most powerful in situations where the number of iterations is not easily known beforehand.

```ab
let number = 1

while number < 100 {
    echo(number)
    number *= 2
}
// Outputs:
// 1
// 2
// 4
// 8
// 16
// 32
// 64
```

## Functions

Functions can help you organize the structure of your code into reusable components. Here is how you can declare such function:

```ab
fun myFunction(arg1, arg2) {
    let result = arg1 + arg2
    return result
}

echo(myFunction(2, 3))
// Outputs: 5
echo(myFunction("Hello", " World"))
// Outputs: Hello World
```

Function declared in the example above has name `myFunction` and can take two arguments `arg1`, `arg2` of any type.

If you want to declare a function that takes arguments of certain type - you are encouraged to do this. However, for consistency you are required to specify the return type as well

```ab
fun myFunction(arg1: Int, arg2: Int): Int {
    let result = arg1 + arg2
    return result
}
```

An interesting fact about functions is that they are not parsed unless they are used. This behavior exists because Amber allows you to omit specifying any type at all. When you use such function - then it generates different variants of this function with types that were used (without any duplications).

On the condition that you specify an argument's type, you can also specify its default value — it will be used if none other is provided when the function is called:

```ab
fun addition(a: Int, b: Int = 100): Int {
    return a + b
}

echo(addition(10)) // Outputs: 110
echo(addition(10, 20)) // Outputs: 30
```
Notice that arguments with default values must come after the regular arguments.

### Modifiers

You can apply [Command Modifiers](https://docs.amber-lang.com/basic_syntax/commands) to function calls as well. This way you can suppress any output with `silent` modifier or run _failable_ functions as if they could never fail (although this is unrecommended) with `trust` keyword

For more information on failable functions, status codes, and error handling blocks, see [Error Handling](https://docs.amber-lang.com/advanced_syntax/error_handling).

### Variable References ref

You have the ability to accept variables passed by reference. To  do this you can use the `ref` keyword.

```ab
fun push(ref array, value) {
    array += [value]
}

let groceries = ["apples", "bananas"]
push(groceries, "oranges")
echo(groceries)
// Outputs: apples bananas oranges
```

The behavior of this keyword is pretty similar to `&` in other C-like programming languages.

### Reserved Prefix

The Amber compiler reserves all identifiers starting with double underscore `__` in addition to keywords like `let`, `if`, etc.

## Importing

In Amber, functions can be imported from other files. To make a function accessible externally, it must be declared as public in the file where it is defined.

### Public Functions

To declare a function as public we can use a `pub` keyword. Let's keep in mind that `pub` keyword has to be used before the `fun` keyword that declares our function:

```ab
pub fun sum(left: Int, right: Int): Int {
    return left + right
}
```

#### Importing from Other Files

It's possible to import functions individually.

```ab
import { foo, bar } from "./my-file.ab"

foo()
bar()
```

It's also possible to import all functions at once.

```ab
import * from "./arith.ab"

echo(sum(1, sub(2, mul(4, 5))))
```

### Public Imports

There are situations where we might need to re-export something we’ve imported. Amber makes this straightforward with the following syntax:

```ab
pub import * from "my/path/file.ab"
```

This statement imports all functions defined in file.ab and re-exports them, making them publicly accessible from the current file.

### Main Block

In case when we want a specific code to run only when a file is executed directly, Amber offers a clean and powerful solution. Similar to Python’s approach:

```py
if __name__ == '__main__':
    # code to execute
```

Amber uses a dedicated main scope for this purpose. However, it’s more than just a convenient syntax — it also provides additional functionality. Within the main block, we can use the `?` operator to propagate exit codes directly to the external shell, simplifying error handling.

```ab
echo("Running indirectly")

main {
    $ some command $?
    echo("Running directly")
}
```

> DETAILS: Key features of `main` block:
- Code outside the main block runs regardless of how the file is executed.
- Code inside the main block runs only when the file is executed directly.
- The `?` operator ensures that any exit code from a failable command or function call is automatically passed back to the shell, making it easy to handle script results effectively.

Now if we run this file the output will look like this:
```
Running indirectly
Running directly
```

Here is the behavior when we import the file instead.

```ab
import * from "./file.ab"
// Outputs: Running indirectly
```


#### Main Block and External Arguments

Main block can provide an array of arguments (that is of type `[Text]`) passed to this script.

```ab
main (args) {
    for i, arg in args {
        echo("{i}: {arg}")
    }
}
```

---

# Advanced Syntax

In the subsequent section we will learn more about Amber syntax that is recommended for advanced Amber or Shell Script developers.

## As Cast

As cast is a tool that might initially seem like an easy way to convert types. So, why has this functionality found its place in the advanced category? Well, with great power comes great responsibility. We could perform some casts that make sense, like from `Bool` to `Int`, but we could also perform casts that we refer to as _absurd_. An example of this might be converting `Text` to `Int`.

### Regular Casts

There might be times when we want to pass a variable that is a `Bool` to a function that accepts `Int`. Since Bool and Int are types that are compatible with each other, we can easily cast one into the other like so:

```ab
let isReady = systemIsReady()
processStatus(isReady as Int)
```

### Absurd Casts

Amber allows us to cast one data type to any other data type. This should be avoided and only used if necessary.

```ab
let a = "12"
let b = a as Int
```

We can clearly see that this could lead to some big bugs. For example one could pass `"abc"` instead of `"12"` in a string which is not a valid value for `Int` type. To convert a string to an integer, it's better to use `parse_int()` function from the [standard library]().

```ab
import { parse_int } from "std/text"

let a = "12"
let b = parse_int(a) failed {
    echo("Variable `a` is not a number.")
}

echo(b + 12)
// Outputs: 24
```

## Builtins

Builtins are native methods (built in the compiler itself) and they are also reserved keywords in Amber.

Similar to the standard library, they generate valid [Shellcheck](https://www.shellcheck.net/) code (though full support for this in Amber is still in progress).

All builtins use function-like syntax (with parentheses) and several operations are **failable**, requiring explicit error handling (e.g., using `trust`, `?`, or a `failed` block).

### Cd

Transpile to `cd` which changes the current directory, requires a `Text` parameter.

Because changing directories can fail, this builtin is **failable**.

```ab
trust cd("/tmp")

cd("/unknown") failed {
    echo("Could not change directory")
}
```

### Echo

Transpile to `printf` or `echo` which prints text to the console, requires a parameter.

```ab
echo("Hello World!")
```

### Exit

Terminate the script. Takes an `Int` parameter representing the exit code. This builtin is **not failable**.

```ab
exit(1)
```

### Len

For a `Text` value, this builtin calculates and returns the length (in ASCII characters) as an `Int` type.  It is transpiled to `${#TEXT}`:

```ab
// Returns 37
echo(len("Jackdaws love my big sphinx of quartz"))
```

For an `Array` `[]` value, it calculates and returns the length of the array as an `Int` type.  It is transpiled to `${#ARRAY[@]}`:

```ab
// Returns 5
echo(len(["one", "two", "three", "four", "five"]))
```

### Lines

This builtin reads one line at a time from a text file.  It can be used in place of an array in an iterative `for` loop (with or without an index). This is efficient because each line is read into memory, and processed before the next line is read.

Because reading files can fail, this builtin is **failable**.

```ab
for line in trust lines("foo.txt") {
    echo(line)
}

for index, line in trust lines("bar.txt") {
    echo("#{index} {line}")
}
```

Alternatively, it can be used as the right hand side of an array assignment.  This is inefficient because the entire file is read into memory in one go:

```ab
let foos = lines("foo.txt") failed {
    echo("Could not read foo.txt")
    exit(1)
}

echo("Read {len(foos)} lines")
```

### Mv

If we need to move files we can use the `mv` builtin, requires two `Text` parameters.
*Doesn't support the `mv` unix command parameters*.

Because moving files can fail, this builtin is **failable**.

```ab
trust mv("/tmp/a", "/tmp/b")

mv("/tmp/a", "/tmp/b") failed {
    echo("Error moving file")
}
```

### Nameof

For more advanced commands, we might need the name of the variable in the compiled script. The `nameof` keyword provides this functionality.

For example, this allows us to perform operations like:

```ab
let variable = null

trust $ {nameof(variable)}=12 $
// Which is the same as declaring (but it is more readable in this way)
let variable = 12
```

### Await

Wait for process IDs to finish executing. Takes an `Int` or `[Int]` parameter.

Because waiting for a process can fail, this builtin is **failable**.

```ab
trust await(1234)
```

### Cp

Copy files or directories. Takes two `Text` parameters for source and destination, and an optional `Bool` parameter for `force`.

Because copying files can fail, this builtin is **failable**.

```ab
trust cp("src.txt", "dst.txt")
trust cp("src.txt", "dst.txt", true)
```

### Ls

List directory contents. Takes an optional `Text` parameter for the path, and optionally two `Bool` parameters for `all` (show hidden files) and `recursive` (TODO). Returns an array of `Text`. Note that `ls` cannot be used with the `silent` modifier, as it will break the listing of directory contents. If you want to suppress error messages, use `suppress` modifier.

Because reading directories can fail, this builtin is **failable**.

```ab
let files = trust ls("dir")
let all_files = trust ls("dir", true)
let all_files_recursive = trust ls("dir", true, true)
```

### Rm

Remove files or directories. Takes a `Text` parameter for the path, and optionally two `Bool` parameters for `recursive` and `force`.

Because removing files can fail, this builtin is **failable**.

```ab
trust rm("file.txt")
trust rm("dir", true, true)
```

### Sleep

Delay for a specified amount of time. Takes a `Num` or `Int` parameter representing sleep duration.

Sleep duration must be greater or equal to 0.

Because sleeping can fail, this builtin is **failable**.

```ab
trust sleep(5)
```

### Touch

Change file timestamps or create empty files. Takes a `Text` parameter.

Because touching files can fail, this builtin is **failable**.

```ab
trust touch("newfile.txt")
```

### Lock

Acquire a file lock. Takes a `Text` parameter. Useful for preventing concurrent executions.

Because acquiring a lock can fail, this builtin is **failable**.

```ab
trust lock("my_script.lock")
```

### Clear

Clear the terminal screen.

```ab
clear()
```

### Pwd

Returns the current working directory as a `Text`.

```ab
let current_dir = pwd()
```

### Pid

Returns the process ID (PID) of the most recently started background job - type `Int`.

```ab
let process_id = pid()
```

### Disown

Disown a job. Takes an optional `Int` or `[Int]` parameter with process IDs.

```ab
disown() // Disowns latest job
disown(process_id)
disown([process_id1, process_id2])
```

### Shellname

Returns the name of the shell currently executing the compiled code (e.g. "bash", "zsh") as a `Text`.

```ab
echo(shellname())
```

### Shellversion

Returns the version of the shell currently executing the compiled code as a `Text`.

```ab
echo(shellversion())
```

## Union Types

Union types provide a flexible way to define function parameters and return types that can accept values of multiple distinct types. 

### Function Parameters

One of the most common use cases for union types is defining flexible function parameters. This allows functions to accept different types without resorting to dynamic typing:

```ab
fun print_value(val: Int | Text | Bool) {
    echo(val)
}

print_value(42)       // Valid
print_value("Amber")  // Valid
print_value(true)     // Valid
```

You can also use union types with multiple parameters:

```ab
fun describe(a: Int | Text, b: Bool | Num) {
    echo("First: {a}, Second: {b}")
}

describe(10, true)           // Valid
describe("hello", 3.14)     // Valid
describe("test", false)      // Valid
```

You can also use match expressions for more complex type narrowing:

```ab
fun analyze(data: Int | Text | Bool) {
    if {
        data is Int: echo("Got an integer")
        data is Text: echo("Got text: {data}")
        data is Bool: echo("Got a boolean")
    }
}
```

### Return Types

Union types are also useful for function return types, allowing functions to return different types based on their execution:

```ab
fun parse_input(input: Text): Int | Text {
    if input == "" {
        return "Empty input"
    }
    return 0
}

let result = parse_input("42")
```

### Arrays

Union types work seamlessly with arrays, allowing you to pass different types of arrays:

```ab

fun array_type(items: [Int] | [Text]): Text {
    if items is [Int] {
        return "Int array: {items}"
    } else {
        return "Text array: {items}"
    }
}

echo(array_type([1, 2, 3]))
// Returns: Int array: 1 2 3
```

---

For more information on related topics, see [Type System](https://docs.amber-lang.com/advanced_syntax/type_system), [Data Types](https://docs.amber-lang.com/basic_syntax/data_types), and [Functions](https://docs.amber-lang.com/basic_syntax/functions).

## Type System

Amber combines static type safety with powerful type inference, creating a flexible system that generates efficient, type-specific code at compile time. 

### Union Types

Union types allow a single variable to hold values of multiple types. This is covered in detail in the [Union Types](https://docs.amber-lang.com/advanced_syntax/union_types) documentation.

### Type Inference

Amber automatically infers types from usage, eliminating the need for explicit type annotations in many cases. The compiler analyzes how values are used throughout your code to determine their types.

#### Variable Type Inference

When you assign a value to a variable, Amber infers the type from the right-hand side:

```ab
let message = "Hello"           // Inferred as Text
let count = 42                  // Inferred as Int
let price = 19.99               // Inferred as Num
let flags = true                // Inferred as Bool
```

#### Inference from Operations

The compiler tracks types through operations and function calls:

```ab
let x = 10              // Int
let y = x + 5           // Int (result of Int + Int)
let text = "Number: "   // Text
let combined = text + y // Text (Text + Int → Text)
```

#### Empty Arrays

An empty array creates a Generic array which later resolves to the type of the first element:

```ab
let empty_ints = [Int]    // Type annotation required
let empty_text = [Text]   // Type annotation required
```

However, once you populate an array, type inference works normally:

```ab
var items = [1, 2, 3]         // Inferred as [Int]
items += [4]                 // Still [Int]
```

#### Function Parameter Inference

Function parameters can often omit type annotations when the compiler can determine usage:

```ab
fun double(x) {              // Type inferred from usage
    return x * 2
}

let result = double(5)       // x is inferred as Int
let text = double("a")       // ERROR: cannot multiply Text
```

### Generics and Type Specialization

Amber uses monomorphization—a compile-time process that generates type-specific versions of generic code. This approach combines the flexibility of generics with the performance of statically typed code.

#### How Monomorphization Works

When you call a function without explicit type declarations, Amber generates a specialized version for each unique type combination used:

```ab
fun identity(x) {
    return x
}

let num = identity(42)        // Generates: identity_Int
let txt = identity("hello")   // Generates: identity_Text
let flag = identity(true)    // Generates: identity_Bool
```

The compiler creates separate functions for each type, resulting in direct, efficient code without runtime type checking.

#### Type-Specific Variants

Each variant is optimized for its specific type:

```ab
fun add(a, b) {
    return a + b
}

// These calls generate three separate functions
let int_result = add(1, 2)      // add_Int(Int, Int) -> Int
let num_result = add(1.5, 2.5)  // add_Num(Num, Num) -> Num
let text_result = add("a", "b") // add_Text(Text, Text) -> Text
```

#### Variant Caching

The compiler caches generated variants. If multiple calls use identical type signatures, no new code is generated:

```ab
fun process(data) {
    return data
}

// Called with Int multiple times - only one variant generated
let a = process(1)
let b = process(2)
let c = process(3)

// Only one Int variant exists in the final code
```

This caching prevents code bloat while maintaining performance benefits.

#### Explicit Type Declarations

You can explicitly specify types to control specialization:

```ab
fun increment(x: Int): Int {
    return x + 1
}

fun greet(name: Text): Text {
    return "Hello, " + name
}
```

Explicit declarations are useful when you want to ensure a specific type is used or when the type cannot be inferred from usage.

### Overloading

Amber supports function overloading—multiple functions with the same name but different type signatures. Each overloaded version becomes a separate compiled variant.

#### Automatic Overloading

When you define functions with different type signatures, Amber alerts about a redeclaration error:

```ab
fun format(value: Int): Text {
    return "Number: " + value
}

fun format(value: Text): Text {
    return "\"" + value + "\""
}

WRONG!
```

#### Overloading and Type Inference

The compiler selects the appropriate variant based on argument types:

```ab
fun combine(a, b) {
    return a + b
}

// Type inference determines which variant to call
let num = combine(1, 2)           // combine_Int_Int
let txt = combine("a", "b")      // combine_Text_Text
let mixed = combine(1, "x")      // combine_Int_Text
```

#### Best Practices for Overloading

1. **Use distinct signatures** - Ensure overloaded functions have unambiguously different parameter types
2. **Document behavior** - When overloaded functions behave differently, document the variations
3. **Prefer explicit types** - For complex scenarios, use explicit type annotations to make intent clear

### Type Narrowing

Type narrowing is the process of refining a variable's type within a specific code path, typically within conditionals. Amber provides mechanisms to determine and narrow types at runtime.

#### Type Checking

Use `is` keyword to check the runtime type of a value:

```ab
fun describe(value: Int | Text) {
    if value is Int {
        echo("Got an integer")
    } else {
        echo("Got text")
    }
}
```

#### Safe Type Casting

After narrowing, use the `as` operator to cast to the narrowed type:

```ab
fun process(value: Int | Text) {
    if value is Int {
        let num = value as Int
        echo("Doubled: {num * 2}")
    } else {
        let txt = value as Text
        echo("Uppercase: {txt}")
    }
}
```

The `as` operator is only safe when dealing with specific type combinations where it's allowed, e.g. cast Int as Text or Bool as Int, otherwise the compiler will show a warning.

For unsupported type conversions, check [absurd cast](https://docs.amber-lang.com/advanced_syntax/as_cast#absurd-cast)

#### Match Expressions for Narrowing

For more complex scenarios, use if-chain with type checking:

```ab
fun analyze(value: Int | Text | Bool) {
    if {
        value is Int {
            echo("Integer: {value}")
        }
        value is Text {
            echo("Text length: {len(value)}")
        } 
        value is Bool {
            echo("Boolean: {value}")
        }
    }
}
```

---

For more information on related topics, see [Union Types](https://docs.amber-lang.com/advanced_syntax/union_types), [Data Types](https://docs.amber-lang.com/reference/data_types), and [Functions](https://docs.amber-lang.com/reference/functions).

## Error Handling

Amber provides several mechanisms for handling errors: failable functions, the `?` operator for error propagation, status codes, and error handling blocks.

### Failable Functions

Functions that include unhandled _failable_ statements - such as `fail` statements or the `?` error propagation operator - are also marked as _failable_. This allows errors to propagate naturally through the call stack, enabling centralized and consistent error handling.

```ab
fun failing() {
    fail 1
}
```

Here is another example of a failing function:

```ab
fun failing(name) {
    $ command $?
    parse(name)?
}
```

The `?` operator automatically fails the current function with the `status()` code of the failing operation. For example, if `parse` fails with exit code 2, the `failing` function itself fails with code 2:

```ab
failing("test") failed(code) {
    echo("Failed with code {code}")  // Outputs: Failed with code 2
}
```

### The ? Operator

The `?` operator is used for automatic error propagation. When a failable function or operation fails, the `?` operator will automatically fail the current function with the same exit code.

```ab
fun processFile(filename): Int? {
    let content = readFile(filename)?        // Fails if readFile fails
    let result = parseContent(content)?      // Fails if parseContent fails
    return result
}
```

If `readFile` fails with exit code 1, `processFile` immediately fails with code 1 — the `return result` line is never reached.

#### Failable Function Return Types

If you specify the return type of a failable function, you must also append the `?` to the type name.

```ab
fun failable(): Int? {
    if 0 > 5 {
        fail 1
    }

    return 1
}
```

Note that you cannot force a function to become failable by simply appending the `?` to the return type. The `?` can (and must) only be used in a function declaration, if the function is actually failable.

Conversely, if a function might fail (e.g. it calls another failable function or uses the `fail` keyword), it **must** have the `?` specifier if you annotate its return type.

### trust and ? Combinations

The `trust` modifier ignores failure handling requirements, while the `?` operator propagates failures. These two mechanisms are contradictory and cannot be combined on the same expression:

```ab
fun invalid(filename): Int? {
    let content = trust readFile(filename)?   // ERROR: cannot combine trust with ?
    return content
}
```

The compiler will correctly diagnose this as an invalid combination. Use either `trust` (to ignore failures) or `?` (to propagate them), but not both on the same expression.

### Status Code

Status code contains information about latest failing function or a command that was run. Accessing status is as simple as calling `status()` function.

```ab
fun safeDivision(a: Num, b: Num): Num? {
    if b == 0 {
        fail 1
    }
    return a / b
}
```

Now let's see how this code will behave in different scenarios:

```ab
let result = trust safeDivision(24, 4)
echo("{result}, {status()}")
// Outputs: 6, 0
```

This was a happy ending. Now let's see what happens when we divide by zero:

```ab
let result = safeDivision(15, 0) failed {
    echo("Function failed with status {status()}")
}
// Outputs: Function failed with status 1
```

Inside a `failed` block, `status()` returns the exit code of the failed operation.

### Error Handling Blocks

Amber provides three modifiers to handle the outcome of failable operations: `failed`, `succeeded`, and `exited`.

#### failed

The `failed` modifier runs its block only when the preceding operation fails. It can optionally capture the exit code into a variable:

```ab
let result = someFailableFunction() failed(code) {
    echo("Operation failed with code {code}")
    // Handle the error appropriately
}
```

#### succeeded

The `succeeded` modifier runs its block only when the preceding operation completes successfully:

```ab
let result = someFailableFunction() succeeded {
    echo("Operation completed successfully")
}
```

#### exited

The `exited` modifier runs its block regardless of whether the operation failed or succeeded. It can optionally capture the exit code:

```ab
let result = someFailableFunction() exited(code) {
    echo("Operation exited with code {code}")
}
```

For more examples of `failed`, `succeeded`, and `exited` with shell commands, see [Commands](https://docs.amber-lang.com/basic_syntax/commands).

### Best Practices

1. **Use `trust` when you're confident a failable operation will succeed**
2. **Use `?` for automatic error propagation in failable functions**
3. **Use `failed(code)` blocks when you want to handle specific failures gracefully**
4. **Use `exited(code)` for cleanup logic that must run regardless of outcome**
5. **Mark functions as failable (`Type?`) only when they can actually fail**

---

For more information on builtins that are failable, see [Builtins](https://docs.amber-lang.com/advanced_syntax/builtins).

## Compiler Flags

Compiler flags enable customization of the compiler’s behavior within the scope of a specific function. These flags are particularly useful for managing edge cases by temporarily relaxing certain restrictions. Below is a list of available compiler flags and their functions:
- `allow_nested_if_else` - Disables warnings that recommend using specialized [if-chain](https://docs.amber-lang.com/basic_syntax/conditions#if-chain) syntax.
- `allow_generic_return` - Suppresses warnings that prompt the developer to specify a concrete return type when using arguments with defined types.
- `allow_absurd_cast` - Turns off warnings about the potential for nonsensical results when using force-type casting, which may result in an [absurd cast](https://docs.amber-lang.com/advanced_syntax/as_cast#absurd-cast).

```ab
#[allow_nested_if_else]
fun foo() {
    // ...
}
```

---

# Standard Library

## Builtin vs Standard Library

[Builtins](https://docs.amber-lang.com/advanced_syntax/builtins) are methods that are included in the Amber compiler and don't need to be imported in the code.

In contrast, the standard library (stdlib) is a collection of Amber functions that are embedded in every Amber release. Each version of Amber may include changes to the standard library and you need to import these functions in your code. These functions are more advanced and can accept various parameters.

## Standard Library and Shellcheck

Just like the Amber's compiled Bash output, all standard library functions are built from the ground up to be shellcheck compliant. This means that you can focus more on building the logic and spend less time on keeping the code predictable and valid.

## How to Use It

Below is an example of how to use the standard library to generate documentation (using the [script](https://github.com/amber-lang/amber-docs/sync-stdlib-doc.ab) provided on the Amber Documentation repository):

```ab
import { download } from "std/http"
import { split, contains } from "std/text"
import { file_exist } from "std/fs"

trust $ rm -fr /tmp/amber-git $
if silent download("https://github.com/amber-lang/amber/archive/refs/heads/master.zip", "/tmp/amber-git.zip") {
    trust $ unzip "/tmp/amber-git.zip" -d /tmp/amber-git $

    let std = trust $ /usr/bin/ls "/tmp/amber-git/amber-master/src/std/" $
    let stdlib = split(std, "\n")

    for v in stdlib {
        if (contains(v, ".ab") and file_exist("/tmp/amber-git/amber-master/src/std/{v}")) {
            trust $ amber --docs "/tmp/amber-git/amber-master/src/std/{v}" "./docs/stdlib/doc" $
            echo("\n")
        }
    }
}
```

> WARNING: Each Amber release may have a different version of the standard library, so make sure to verify compatibility with the specific release you are using.

### Importing a Library

You can also import all functions from a module by using the following syntax:

```ab
import * from "std/http"
```

However, only the functions that are used in the script will be included in the generated Bash code, ensuring efficiency.

If you prefer a verbose import, you can specify a single function:

```ab
import { download } from "std/http"
```

## Array

### array_contains

```ab
pub fun array_contains(array, value) 
```

Checks if a value is in the array.

#### Usage
```ab
import { array_contains } from "std/array"

array_contains([1, 2, 3], 2) // Outputs true
```

### array_extract_at

```ab
pub fun array_extract_at(ref array: [], index: Int) 
```

Removes an element at the index from the array, and returns it; if the
index is negative or beyond the end, the function fails.

#### Usage
```ab
import { array_extract_at } from "std/array"

let array = [1, 2, 3]
let element = array_extract_at(array, 1)
echo element // Outputs 2
echo(array) // Outputs [1, 3]
```

### array_filled

```ab
pub fun array_filled(size, value = 0) 
```

Returns an array of length `size` with each element set to `value`; if `size`
is less than zero an empty array is returned

#### Usage
```ab
import { array_filled } from "std/array"

let array = array_filled(5, 1)
echo(array) // Outputs [1, 1, 1, 1, 1]
```

### array_find

```ab
pub fun array_find(array, value): Int 
```

Returns index of the first value found in the specified array.

If the value is not found, the function returns -1.

#### Usage
```ab
import { array_find } from "std/array"

array_find([1, 2, 3], 2) // Outputs 2
```

### array_find_all

```ab
pub fun array_find_all(array, value): [Int] 
```

Searches for a value in an array and returns an array with the index of the various items.

#### Usage
```ab
import { array_find_all } from "std/array"

array_find_all([1, 2, 3, 2], 2) // Outputs [1, 3]
```

### array_first

```ab
pub fun array_first(array) 
```

Returns the first element in the array; if the array is empty, the function
fails.

#### Usage
```ab
import { array_first } from "std/array"

array_first([1, 2, 3]) // Outputs 1
```

### array_last

```ab
pub fun array_last(array) 
```

Returns the last element in the array; if the array is empty, the function
fails.

#### Usage
```ab
import { array_last } from "std/array"

array_last([1, 2, 3]) // Outputs 3
```

### array_pop

```ab
pub fun array_pop(ref array) 
```

Removes the last element from the array, and returns it; if the array
is empty, the function fails, and the array will be unchanged.

#### Usage
```ab
import { array_pop } from "std/array"

let array = [1, 2, 3]
let element = array_pop(array)
echo(element) // Outputs 3
echo(array) // Outputs [1, 2]
```

### array_remove_at

```ab
pub fun array_remove_at(ref array: [], index: Int): Null 
```

Removes an element at the index from the array; if the index is negative
or beyond the end, the array will be unchanged.

#### Usage
```ab
import { array_remove_at } from "std/array"

let array = [1, 2, 3]
array_remove_at(array, 1)
echo(array) // Outputs [1, 3]
```

### array_reversed

```ab
pub fun array_reversed(array: []): [] 
```

Return the reversed array

#### Usage
```ab
import { array_reversed } from "std/array"

echo(array_reversed(["15", "-3", "foo", "bar"])) // Outputs ["bar", "foo", "-3", "15"]
```

### array_shift

```ab
pub fun array_shift(ref array) 
```

Removes the first element from the array, and returns it; if the array
is empty, the function fails, and the array will be unchanged.

#### Usage
```ab
import { array_shift } from "std/array"

let array = [1, 2, 3]
let element = array_shift(array)
echo(element) // Outputs 1
echo(array) // Outputs [2, 3]
```

### sort

```ab
pub fun sort(ref array: [], desc: Bool = false, version_sort: Bool = false): Null 
```

Sort the array in-place.
Pass `desc` value `true` for descending order.
Pass `version_sort` value `true` for version sort,
this only applies to text arrays.

#### Usage
```ab
import { sort } from "std/array"

let array = ["15","-3","foo","bar"]
sort(array)
echo(array) // Outputs ["-3", "15", "bar", "foo"]
```

### sorted

```ab
pub fun sorted(array: [], desc: Bool = false, version_sort: Bool = false): [] 
```

Return the sorted array, leaving the original array unchanged.
Pass `desc` value `true` for descending order.
Pass `version_sort` value `true` for version sort,
this only applies to text arrays.

#### Usage
```ab
import { sorted } from "std/array"

echo(sorted([-3,15,7,2], true)) // Outputs [-3, 2, 7, 15]
```

## Date

### date_add

```ab
pub fun date_add(date: Int, amount: Int, unit: Text): Int? 
```

Adds a value to a date passed in the unix epoch format in milliseconds.
Example : `date_add(date, 3, "days")`

Available units:
- years
- months
- days
- hours
- minutes
- seconds

#### Usage
```ab
import { date_add } from "std/date"

let date = date_now() // Example value: 1678887000
let new_date = date_add(date, 5, "hours") // Example value: 1678890600
```

### date_format_posix

```ab
pub fun date_format_posix(date: Int, format: Text = "%F %T", utc: Bool = false): Text? 
```

Transform date from unix epoch to a human-readable format described by a posix format string.
If no format is specified, "%F %T" is used.
For more info about format type "man date" in your shell or see <https://www.gnu.org/software/coreutils/date>.

Format includes the following patterns:
- `%%` - a literal %
- `%a` - locale's abbreviated weekday name (e.g., Sun)
- `%A` - locale's full weekday name (e.g., Sunday)
- `%b` - locale's abbreviated month name (e.g., Jan)
- `%B` - locale's full month name (e.g., January)
- `%d` - day of month (e.g., 01)
- `%D` - date; same as %m/%d/%y
- `%F` - full date; like %+4Y-%m-%d
- `%H` - hour (00..23)
- `%I` - hour (01..12)
- `%m` - month (01..12)
- `%M` - minute (00..59)
- `%N` - nanoseconds (000000000..999999999)
- `%p` - locale's equivalent of either AM or PM; blank if unknown
- `%T` - time; same as %H:%M:%S
- `%Y` - year

#### Usage
```ab
import { date_format_posix } from "std/date"

let date = date_now() // Example value: 1678887000
echo(date_format_posix(date)) // Outputs: 2023-03-15 14:30:00
```

### date_from_posix

```ab
pub fun date_from_posix(date: Text, format: Text = "%F %T", utc: Bool = false): Int? 
```

Transforms date from a format described by a posix format string to a unix epoch format (seconds since the Epoch (1970-01-01 00:00 UTC)).
If no format is specified, "%F %T" format is used.
For more info about format type "man date" on your shell or go to <https://www.gnu.org/software/coreutils/date>.

#### Usage
```ab
import { date_from_posix } from "std/date"

let date = "2023-03-15 14:30:00"
echo(date_from_posix(date)) // Output: 1678887000
```

### date_now

```ab
pub fun date_now(): Int 
```

Returns the current timestamp (seconds since the Epoch (1970-01-01 00:00 UTC)).

#### Usage
```ab
import { date_now } from "std/date"

let date = date_now() // Example value: 1678887000
```

### date_sub

```ab
pub fun date_sub(date: Int, amount: Int, unit: Text): Int? 
```

Subtracts a value from a date passed in the unix epoch format in milliseconds.
Example : `date_sub(date, 5, "hours")`

Available units:
- years
- months
- days
- hours
- minutes
- seconds

#### Usage
```ab
import { date_sub } from "std/date"

let date = date_now() // Example value: 1678887000
let new_date = date_sub(date, 5, "hours") // Example value: 1678882200
```

## Environment

### bold

```ab
pub fun bold(message: Text): Text 
```

Returns a text as bold.

#### Usage
```ab
import { bold } from "std/env"

printf("%s\n", [bold("Important message")])
```

### echo_colored

```ab
pub fun echo_colored(message: Text, color: Text | Int): Null 
```

Prints a text with a specified color.

#### Usage
```ab
import { echo_colored } from "std/env"

echo_colored("Red text", "red")
echo_colored("Blue text", 34)
```

#### Supported color names
| Color name | Code |
| - | - |
| black | 30 |
| red | 31 |
| green | 32 |
| yellow | 93 |
| orange | 33 |
| blue | 34 |
| purple | 35 |
| cyan | 36 |
| gray | 37 |
| white | 97 |

For all supported color codes, please visit https://en.wikipedia.org/wiki/ANSI_escape_code#3-bit_and_4-bit

### echo_error

```ab
pub fun echo_error(message: Text, exit_code: Int = 1): Null 
```

Prints a text as a error and exits if the status code is greater than 0.

#### Usage
```ab
import { echo_error } from "std/env"

echo_error("Fatal error occurred", 1)
```

### echo_info

```ab
pub fun echo_info(message: Text): Null 
```

Prints a text as a info message.

#### Usage
```ab
import { echo_info } from "std/env"

echo_info("Information message")
```

### echo_success

```ab
pub fun echo_success(message: Text): Null 
```

Prints a text as a success message.

#### Usage
```ab
import { echo_success } from "std/env"

echo_success("Operation completed successfully")
```

### echo_warning

```ab
pub fun echo_warning(message: Text): Null 
```

Prints a text as a warning message.

#### Usage
```ab
import { echo_warning } from "std/env"

echo_warning("Warning: Disk space low")
```

### env_const_set

```ab
pub fun env_const_set(name: Text, val: Text | Int | Bool): Null? 
```

Sets a constant inside the shell session. Note that `true` is saved as int (`1`).

#### Usage
```ab
import { env_const_set } from "std/env"

env_const_set("API_KEY", "secret123")
```

### env_file_load

```ab
pub fun env_file_load(file: Text = ".env"): Null? 
```

Loads the env file in the environment

#### Usage
```ab
import { env_file_load } from "std/env"

env_file_load(".env")?
```

### env_var_get

```ab
pub fun env_var_get(name: Text): Text? 
```

Gets a variable or constant inside the shell session.

#### Usage
```ab
import { env_var_get } from "std/env"

const debug = env_var_get("DEBUG")
```

### env_var_load

```ab
pub fun env_var_load(var: Text, file: Text = ".env"): Text? 
```

Retrieves the value of an environment variable from the file.

#### Usage
```ab
import { env_var_load } from "std/env"

const value = env_var_load("MY_VAR", ".env.local")
```

### env_var_set

```ab
pub fun env_var_set(name: Text, val: Text | Int | Bool): Null? 
```

Sets a variable inside the shell session. Note that `true` is saved as int (`1`).

#### Usage
```ab
import { env_var_set } from "std/env"

env_var_set("STATUS", "succeeded")
env_var_set("COUNT", 100)
env_var_set("DEBUG", true) // saved as int (`1`)
```

### env_var_test

```ab
pub fun env_var_test(name: Text): Bool 
```

Checks if a variable inside the shell session exists.

#### Usage
```ab
import { env_var_test } from "std/env"

if env_var_test("PATH") {
    echo("PATH exists")
}
```

### env_var_unset

```ab
pub fun env_var_unset(name: Text): Null? 
```

Removes a variable inside the shell session.

#### Usage
```ab
import { env_var_unset } from "std/env"

env_var_unset("TEMP_VAR")
```

### escaped

```ab
pub fun escaped(text: Text): Text 
```

Escapes the text to be used with `printf`.

#### Usage
```ab
import { escaped } from "std/env"

printf("%s\n", [escaped("100% done\\n")])
```

### has_failed

```ab
pub fun has_failed(command: Text): Bool 
```

Checks if the command has failed.

#### Usage
```ab
import { has_failed } from "std/env"

if has_failed("test -f config.txt") {
    echo("File doesn't exist")
}
```

### input_confirm

```ab
pub fun input_confirm(prompt: Text, default_yes: Bool = false): Bool 
```

Creates a confirm prompt (Yes/No), and returns true if the choice is Yes.

"No" is the default choice, set default_yes to true for "Yes" as default choice.

#### Usage
```ab
import { input_confirm } from "std/env"

if input_confirm("Continue?", false) {
    echo("Continuing...")
}
```

### input_hidden

```ab
pub fun input_hidden(prompt: Text): Text 
```

Creates a prompt, hides any user input and returns the value.

#### Usage
```ab
import { input_hidden } from "std/env"

const password = input_hidden("Enter password: ")
```

### input_prompt

```ab
pub fun input_prompt(prompt: Text): Text 
```

Creates a prompt and returns the value.

#### Usage
```ab
import { input_prompt } from "std/env"

const name = input_prompt("Enter your name: ")
```

### is_command

```ab
pub fun is_command(command: Text): Bool 
```

Checks if a command exists.

#### Usage
```ab
import { is_command } from "std/env"

if is_command("git") {
    echo("Git is installed")
}
```

### is_root

```ab
pub fun is_root(): Bool 
```

Checks if the script is running with a user with root permission.

#### Usage
```ab
import { is_root } from "std/env"

if is_root() {
    echo("Running as root")
}
```

### italic

```ab
pub fun italic(message: Text): Text 
```

Returns a text as italic.

#### Usage
```ab
import { italic } from "std/env"

printf("%s\n", [italic("Emphasized text")])
```

### kill

```ab
pub fun kill(process_id: Int, signal: Text = "TERM"): Null? 
```

Sends a signal to a process by PID.

#### Usage
```ab
import { kill } from "std/env"

kill(1234)?                  // Send SIGTERM (default)
kill(1234, "SIGKILL")?       // Send SIGKILL
kill(1234, "9")?             // Send signal 9 (SIGKILL)
```

### mount

```ab
pub fun mount(source: Text, target: Text, options: Text = ""): Null? 
```

Mounts a filesystem. Requires root privileges.

#### Usage
```ab
import { mount } from "std/env"

mount("/dev/sda1", "/mnt/disk")?
mount("/root", "/test", "bind,ro")? // mount /root to /test directory with read-only permission
```

### pgrep

```ab
pub fun pgrep(pattern: Text): [Int] 
```

Finds process IDs by name pattern.

#### Usage
```ab
import { pgrep } from "std/env"

const pids = pgrep("nginx")
for pid in pids {
    echo(pid)
}
```

### pgrep_exact

```ab
pub fun pgrep_exact(name: Text): [Int] 
```

Finds process IDs by exact name.

#### Usage
```ab
import { pgrep_exact } from "std/env"

const pids = pgrep_exact("nginx")
```

### pkill

```ab
pub fun pkill(pattern: Text): Null? 
```

Kills processes by name pattern.

#### Usage
```ab
import { pkill } from "std/env"

pkill("nginx")?
```

### pkill_exact

```ab
pub fun pkill_exact(name: Text): Null? 
```

Kills processes by exact name.

#### Usage
```ab
import { pkill_exact } from "std/env"

pkill_exact("nginx")?
```

### pkill_force

```ab
pub fun pkill_force(pattern: Text): Null? 
```

Forcefully kills processes by name pattern (SIGKILL).

#### Usage
```ab
import { pkill_force } from "std/env"

pkill_force("nginx")?
```

### printf

```ab
pub fun printf(format: Text, args: [Text] = []): Null 
```

`printf` the text following the arguments.

#### Usage
```ab
import { printf } from "std/env"

printf("Hello %s!", ["World"])
```

### shopt_disable

```ab
pub fun shopt_disable(optname: Text, set_opt: Bool = false): Null? 
```

Disables shopt or set option.

#### Usage
```ab
import { shopt_disable } from "std/env"

shopt_disable("dotglob")? // Hides files starting with "." during filename expansion
shopt_disable("noglob", true)? // Enables filename expansion (globbing)
```
For all available options, see:
- [bash options](https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html)
- [zsh options](https://zsh.sourceforge.io/Doc/Release/Options.html)
- [ksh options](https://www.mkssoftware.com/docs/man1/set.1.asp)
NOTE: set_opt argument is only for bash target, otherwise it's ignored

### shopt_enable

```ab
pub fun shopt_enable(optname: Text, set_opt: Bool = false): Null? 
```

Enables shopt or set option.

#### Usage
```ab
import { shopt_enable } from "std/env"

shopt_enable("globstar")? // Enables star (*) expansion for filenames
shopt_enable("noglob", true)? // Disables filename expansion (globbing). Note that this option doesn't properly work in a limited environment, e.g. GitHub Actions
```
For all available options, see:
- [bash options](https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html)
- [zsh options](https://zsh.sourceforge.io/Doc/Release/Options.html)
- [ksh options](https://www.mkssoftware.com/docs/man1/set.1.asp)
NOTE: set_opt argument is only for bash target, otherwise it's ignored

### styled

```ab
pub fun styled(message: Text, style: Int, fg: Int | Text, bg: Int | Text): Text 
```

Prepares a text with formatting options for `printf`.

#### Usage
```ab
import { styled } from "std/env"

printf("%s\n", [styled("Error!", 1, 31, 40)])
printf("%s\n", [styled("Warning!", 1, "white", "yellow")])
```

#### Supported color names
| Color name | Foreground code | Background code |
| - | - |
| black | 30 | 40 |
| red | 31 | 41 |
| green | 32 | 42 |
| yellow | 33 | 43 |
| orange | 93 | 103 |
| blue | 34 | 44 |
| purple | 35 | 45 |
| cyan | 36 | 46 |
| gray | 37 | 47 |
| white | 97 | 107 |

For all supported color codes, please visit https://en.wikipedia.org/wiki/ANSI_escape_code#3-bit_and_4-bit

### umount

```ab
pub fun umount(target: Text): Null? 
```

Unmounts a filesystem. Requires root privileges.

#### Usage
```ab
import { umount } from "std/env"

umount("/mnt/disk")?
```

### umount_force

```ab
pub fun umount_force(target: Text): Null? 
```

Force unmounts a filesystem. Requires root privileges.

#### Usage
```ab
import { umount_force } from "std/env"

umount_force("/mnt/disk")?
```

### uname_all

```ab
pub fun uname_all(): Text 
```

Returns all system information from uname.

#### Usage
```ab
import { uname_all } from "std/env"

const info = uname_all()
echo(info) // e.g., "Linux my-host 5.15.0 #1 SMP x86_64 GNU/Linux"
```

### uname_kernel_name

```ab
pub fun uname_kernel_name(): Text 
```

Returns the kernel name (e.g., "Linux", "Darwin").

#### Usage
```ab
import { uname_kernel_name } from "std/env"

const kernel = uname_kernel_name()
echo(kernel) // "Linux" or "Darwin"
```

### uname_kernel_release

```ab
pub fun uname_kernel_release(): Text 
```

Returns the kernel release version.

#### Usage
```ab
import { uname_kernel_release } from "std/env"

const release = uname_kernel_release()
echo(release) // e.g., "5.15.0-generic"
```

### uname_kernel_version

```ab
pub fun uname_kernel_version(): Text 
```

Returns the kernel version.

#### Usage
```ab
import { uname_kernel_version } from "std/env"

const version = uname_kernel_version()
echo(version)
```

### uname_machine

```ab
pub fun uname_machine(): Text 
```

Returns the machine hardware name (architecture).

#### Usage
```ab
import { uname_machine } from "std/env"

const arch = uname_machine()
echo(arch) // e.g., "x86_64" or "arm64"
```

### uname_nodename

```ab
pub fun uname_nodename(): Text 
```

Returns the network node hostname.

#### Usage
```ab
import { uname_nodename } from "std/env"

const host = uname_nodename()
echo(host) // e.g., "my-computer"
```

### uname_os

```ab
pub fun uname_os(): Text 
```

Returns the operating system name.

#### Usage
```ab
import { uname_os } from "std/env"

const os = uname_os()
echo(os) // e.g., "GNU/Linux" or "Darwin"
```

### underlined

```ab
pub fun underlined(message: Text): Text 
```

Returns a text as underlined.

#### Usage
```ab
import { underlined } from "std/env"

printf("%s\n", [underlined("Underlined text")])
```

## FileSystem

### dir_create

```ab
pub fun dir_create(path: Text): Null? 
```

Creates a directory with all parent directories as required.

#### Usage
```ab
import { dir_create } from "std/fs"

dir_create("/tmp/my/nested/directory")
```

### dir_exists

```ab
pub fun dir_exists(path: Text): Bool 
```

Checks if a directory exists.

#### Usage
```ab
import { dir_exists } from "std/fs"

if dir_exists("/tmp/mydir") {
    echo("Directory exists")
}
```

### file_append

```ab
pub fun file_append(path: Text, content: Text): Text? 
```

Appends content to a file.

Doesn't check if the file exists.

#### Usage
```ab
import { file_append } from "std/fs"

file_append("log.txt", "New log entry")
```

### file_chmod

```ab
pub fun file_chmod(path: Text, mode: Text): Null? 
```

Changes the permission bits of a file.

If the file doesn't exist, it fails and prints a message.

#### Usage
```ab
import { file_chmod } from "std/fs"

file_chmod("script.sh", "755")
```

### file_chown

```ab
pub fun file_chown(path: Text, user: Text): Null? 
```

Changes the owner of a file.

If the file doesn't exist, it fails and prints a message.

#### Usage
```ab
import { file_chown } from "std/fs"

file_chown("/var/www/html", "www-data")
```

### file_compress

```ab
pub fun file_compress(files: [Text], target: Text): Null? 
```

Compress file(s) or directories into an archive
Supports: bz2, gz, xz, bz2, deb, rar, rpm, tar(gz/xz/bz), zip(war/jar), 7z
Note: Not all supported methods support multiple files/directories
#### Usage
```ab
import { file_compress } from "std/fs"

file_compress(["main.ab", "src"], "amber.tar.gz")?
file_compress(["amber"], "amber.gz")?
```

### file_exists

```ab
pub fun file_exists(path: Text): Bool 
```

Checks if a file exists.

#### Usage
```ab
import { file_exists } from "std/fs"

if file_exists("config.txt") {
    echo("File exists")
}
```

### file_extract

```ab
pub fun file_extract(path: Text, target: Text): Null? 
```

Extract the file detecting from the filename the extension
Supports: bz2, gz, xz, bz2, deb, rar, rpm, tar(gz/xz/bz), zip(war/jar), 7z
Note: Not all the commands supports the output folder path

#### Usage
```ab
import { file_extract } from "std/fs"

file_extract("archive.tar.gz", "/tmp/extracted")
```

### file_glob

```ab
pub fun file_glob(path: Text): [Text] 
```

Finds all files or directories matching a file glob.

#### Usage
```ab
import { file_glob } from "std/fs"

let files = file_glob("*.txt")
```

### file_glob_all

```ab
pub fun file_glob_all(paths: [Text]): [Text] 
```

Finds all files or directories matching multiple file globs. When
we have union types, this functionality can be merged into the main
`file_glob` function.

#### Usage
```ab
import { file_glob_all } from "std/fs"

let files = file_glob_all(["*.txt", "*.md"])
```

Uses newline-only shell splitting so spaces survive glob expansion, keeps
existing paths and symlinks, and restores IFS after expanding each glob.

### file_read

```ab
pub fun file_read(path: Text): Text? 
```

Gets file contents from a path.

#### Usage
```ab
import { file_read } from "std/fs"

let content = file_read("data.txt")
```

### file_write

```ab
pub fun file_write(path: Text, content: Text): Text? 
```

Writes content to a file.
Doesn't check if the file exist

#### Usage
```ab
import { file_write } from "std/fs"

file_write("output.txt", "Hello, World!")
```

### is_mac_os_mktemp

```ab
fun is_mac_os_mktemp(): Bool 
```

Determine whether mktemp is macOS's.
```ab
import { is_mac_os_mktemp } from "std/fs"
```
### symlink_create

```ab
pub fun symlink_create(origin: Text, destination: Text): Null? 
```

Creates a symbolic link, if destination exists it will be replaced.

If the file doesn't exist, it fails and prints a message.

#### Usage
```ab
import { symlink_create } from "std/fs"

symlink_create("/usr/bin/python3", "/usr/local/bin/python")
```

### temp_dir_create

```ab
pub fun temp_dir_create(template: Text = "tmp.XXXXXXXXXX", auto_delete: Bool = false, force_delete: Bool = false): Text? 
```

Create a temporary directory and return the path.
Please note this does not respect _CS_DARWIN_USER_TEMP_DIR environment variable.

#### Usage
```ab
import { temp_dir_create } from "std/fs"

let temp = temp_dir_create("myapp.XXXXXX", true, false)
```

## HTTP

### fetch

```ab
pub fun fetch(url: Text, method: Text = "GET", data: Text = "", headers: [Text] = [""]): Text? 
```

Makes a HTTP request using available command-line tools or bash's network sockets as failover.

For POST requests with a custom data type, you should include `content-type` header in `headers[]`.

#### Usage
```ab
import { fetch } from "std/http"

let response = trust fetch("https://example.com")

// POST request example
let post_request = trust fetch("https://example.com", "POST", "hello world!", [
    "content-type: text/plain"
])
```

### file_download

```ab
pub fun file_download(url: Text, path: Text): Null? 
```

Downloads a file from a given URL and saves it to a specified path using available command-line tools.

It checks for the availability of common command-line tools (`curl`, `wget`, and `aria2c`, in order) and uses the first available tool to perform the download.
If none of the tools are available, the function fails.

#### Usage
```ab
import { file_download } from "std/http"

file_download("https://example.com/file.zip", "/tmp/file.zip")
```

## Math

### math_abs

```ab
pub fun math_abs(number) 
```

Returns the absolute value of a number

#### Usage
```ab
import { math_abs } from "std/math"

let absolute = math_abs(-42)
echo(absolute) // 42
```

### math_ceil

```ab
pub fun math_ceil(number: Num): Int 
```

Returns the smallest integer greater than or equal to a number

#### Usage
```ab
import { math_ceil } from "std/math"

let ceiled = math_ceil(3.1)
echo(ceiled) // 4
```

### math_floor

```ab
pub fun math_floor(number: Num): Int 
```

Returns the largest integer less than or equal to a number

#### Usage
```ab
import { math_floor } from "std/math"

let floored = math_floor(3.9)
echo(floored) // 3
```

### math_round

```ab
pub fun math_round(number: Num): Int 
```

Returns a number, rounded to the nearest integer

#### Usage
```ab
import { math_round } from "std/math"

let rounded = math_round(3.7)
echo(rounded) // 4
```

### math_sum

```ab
pub fun math_sum(list) 
```

Sums an array's contents

#### Usage
```ab
import { math_sum } from "std/math"

let total = math_sum([1, 2, 3, 4, 5])
echo(total) // 15
```

## Test

### assert

```ab
pub fun assert(condition: Bool) 
```

Asserts that a boolean condition is true. Fails the test with exit code `1` if false.
#### Usage
```ab
import { assert } from "std/test"

let user_age = 18
assert(user_age >= 18)
```

### assert_eq

```ab
pub fun assert_eq(left, right) 
```

Asserts that two values are equal. Fails the test with exit code `1` if they are not equal.
#### Usage
```ab
import { assert_eq } from "std/test"

let expected = [1, 2, 3]
let actual = [1, 2, 3]
assert_eq(expected, actual)
```

### refute

```ab
pub fun refute(condition: Bool) 
```

Asserts that a boolean condition is false. Fails the test with exit code `1` if true.
#### Usage
```ab
import { refute } from "std/test"

let user_age = 17
refute(user_age >= 18)
```

## Text

### capitalized

```ab
pub fun capitalized(text: Text): Text 
```

Capitalize the first letter of the given `text`.

#### Usage
```ab
import { capitalized } from "std/text"

const cap = capitalized("hello")
echo(cap) // "Hello"
```

### char_at

```ab
pub fun char_at(text: Text, index: Int): Text 
```

Returns the character from `text` at the specified `index` (0-based).

If `index` is negative, the substring starts from the end of `text` based on the absolute value of `index`.

#### Usage
```ab
import { char_at } from "std/text"

const ch = char_at("hello", 1)
echo(ch) // "e"
```

### count_chars

```ab
pub fun count_chars(text: Text): Int 
```

Counts the number of characters in the given text.

#### Usage
```ab
import { count_chars } from "std/text"

const count = count_chars("hello")
echo(count) // 5
```

### count_lines

```ab
pub fun count_lines(text: Text): Int 
```

Counts the number of lines in the given text.

#### Usage
```ab
import { count_lines } from "std/text"

const count = count_lines("one\ntwo\nthree")
echo(count) // 3
```

### count_words

```ab
pub fun count_words(text: Text): Int 
```

Counts the number of words in the given text.

#### Usage
```ab
import { count_words } from "std/text"

const count = count_words("hello world foo")
echo(count) // 3
```

### cpad

```ab
pub fun cpad(text: Text, pad: Text, length: Int): Text 
```

Pads `text` with the specified `pad` character to the center within the desired `length`

#### Usage
```ab
import { cpad } from "std/text"

let padded: Text

padded = cpad("42", "0", 5)
echo(padded) // "04200"

padded = cpad("42", "0", 6)
echo(padded) // "004200"

padded = cpad("42", "0", 1)
echo(padded) // "42"
```

### ends_with

```ab
pub fun ends_with(text: Text, suffix: Text): Bool 
```

Checks if text ends with a value.

#### Usage
```ab
import { ends_with } from "std/text"

if ends_with("hello world", "world") {
    echo("Ends with world!")
}
```

### join

```ab
pub fun join(list: [Text], delimiter: Text): Text 
```

Merges text using the delimiter specified.

#### Usage
```ab
import { join } from "std/text"

const joined = join(["a", "b", "c"], ",")
echo(joined) // "a,b,c"
```

### lowercase

```ab
pub fun lowercase(text: Text): Text 
```

Makes the text input lowercase using `tr`.

#### Usage
```ab
import { lowercase } from "std/text"

const lower = lowercase("HELLO")
echo(lower) // "hello"
```

### lpad

```ab
pub fun lpad(text: Text, pad: Text, length: Int): Text 
```

Pads `text` with the specified `pad` character on left until it reaches the desired `length`.

#### Usage
```ab
import { lpad } from "std/text"

const padded = lpad("42", "0", 5)
echo(padded) // "00042"
```

### match_regex

```ab
pub fun match_regex(source: Text, search: Text, extended: Bool = false): Bool 
```

Match all occurrences of a regex pattern.

Function uses `sed`

#### Usage
```ab
import { match_regex } from "std/text"

if match_regex("test123", "[0-9]+", true) {
    echo("Contains numbers!")
}
```

### match_regex_any

```ab
pub fun match_regex_any(text: Text, terms: [Text]): Bool 
```

Checks if an array value (with regular expression) is in the text.

#### Usage
```ab
import { match_regex_any } from "std/text"

if match_regex_any("test123", ["[a-z]+", "[0-9]+"]) {
    echo("Matches at least one pattern!")
}
```

### parse_int

```ab
pub fun parse_int(text: Text): Int? 
```

Attempts to parse a given text into an `Int` number.

#### Usage
```ab
import { parse_int } from "std/text"

const num = parse_int("42")?
echo(num) // 42
```

### parse_num

```ab
pub fun parse_num(text: Text): Num? 
```

Attempts to parse a given text into a `Num` number.

#### Usage
```ab
import { parse_num } from "std/text"

const num = parse_num("3.14")?
echo(num) // 3.14
```

### replace

```ab
pub fun replace(source, search, replace) 
```

Replaces all occurrences of a pattern in the content with the provided replace text.

#### Usage
```ab
import { replace } from "std/text"

const result = replace("Hello world", "world", "universe")
echo(result) // "Hello universe"
```

### replace_one

```ab
pub fun replace_one(source, search, replace) 
```

Replaces the first occurrence of a pattern in the content with the provided replace text.

#### Usage
```ab
import { replace_one } from "std/text"

const result = replace_one("foo foo foo", "foo", "bar")
echo(result) // "bar foo foo"
```

### replace_regex

```ab
pub fun replace_regex(source: Text, search: Text, replace_text: Text, extended: Bool = false): Text 
```

Replaces all occurrences of a regex pattern in the content with the provided replace text.
Function uses `sed` and supports capture groups syntax in extended mode.

#### Usage
```ab
import { replace_regex } from "std/text"

const result = replace_regex("test123", "[0-9]+", "456", true)
echo(result) // "test456"
// Also supports replace regex
echo(replace_regex("Put number 255 in brackets", "([0-9]+)", "(\1)", true)); // Put number (255) in brackets
```

### reversed

```ab
pub fun reversed(text: Text): Text 
```

Reverses text using `rev`.

#### Usage
```ab
import { reversed } from "std/text"

const reversed_text = reversed("hello")
echo(reversed_text) // "olleh"
```

### rpad

```ab
pub fun rpad(text: Text, pad: Text, length: Int): Text 
```

Pads `text` with the specified `pad` character on the right until it reaches the desired `length`.

#### Usage
```ab
import { rpad } from "std/text"

const padded = rpad("42", "0", 5)
echo(padded) // "42000"
```

### sed_version

```ab
fun sed_version(): Int 
```

### slice

```ab
pub fun slice(text: Text, index: Int, length: Int = 0): Text 
```

Returns a substring from `text` starting at the given `index` (0-based).

If `index` is negative, the substring starts from the end of `text` based on the absolute value of `index`.
If `length` is provided, the substring will include `length` characters; otherwise, it slices to the end of `text`.
If `length` is negative, an empty string is returned.

#### Usage
```ab
import { slice } from "std/text"

const sub = slice("hello world", 6, 5)
echo(sub) // "world"
```

### sort_lines

```ab
pub fun sort_lines(text: Text, desc: Bool = false, numeric: Bool = false): Text 
```

Sorts lines of text in ascending, descending or numerial order.

#### Usage
```ab
import { sort_lines } from "std/text"

let sorted = sort_lines("banana\napple\ncherry")
echo(sorted) // "apple\nbanana\ncherry"

sorted = sort_lines("banana\napple\ncherry", true) // Sorts lines of text in descending order
echo(sorted) // "cherry\nbanana\napple"

sorted = sort_lines("10\n2\n1", false, true) // Sorts lines of text numerically
echo(sorted) // "1\n2\n10"
```

### split

```ab
pub fun split(text: Text, delimiter: Text): [Text] 
```

Splits the input `text` into an array of substrings using the specified `delimiter`.

#### Usage
```ab
import { split } from "std/text"

const parts = split("a,b,c", ",")
echo(parts[0]) // "a"
```

### split_chars

```ab
pub fun split_chars(text: Text): [Text] 
```

Splits a text into an array of individual characters.

#### Usage
```ab
import { split_chars } from "std/text"

const chars = split_chars("hello")
echo(chars[0]) // "h"
```

### split_lines

```ab
pub fun split_lines(text: Text): [Text] 
```

Splits a `text` into an array of substrings based on newline characters.

#### Usage
```ab
import { split_lines } from "std/text"

const lines = split_lines("line1\nline2\nline3")
echo(lines[0]) // "line1"
```

### split_words

```ab
pub fun split_words(text: Text): [Text] 
```

Splits a `text` into an array of substrings based on space character.

#### Usage
```ab
import { split_words } from "std/text"

const words = split_words("hello world example")
echo(words[1]) // "world"
```

### starts_with

```ab
pub fun starts_with(text: Text, prefix: Text): Bool 
```

Checks if text starts with a value.

#### Usage
```ab
import { starts_with } from "std/text"

if starts_with("hello world", "hello") {
    echo("Starts with hello!")
}
```

### text_contains

```ab
pub fun text_contains(source: Text, search: Text): Bool 
```

Checks if some text contains a value.

#### Usage
```ab
import { text_contains } from "std/text"

if text_contains("hello world", "world") {
    echo("Found!")
}
```

### text_contains_all

```ab
pub fun text_contains_all(source: Text, searches: [Text]): Bool 
```

Checks if all the arrays values are in the string

#### Usage
```ab
import { text_contains_all } from "std/text"

if text_contains_all("hello world", ["hello", "world"]) {
    echo("All found!")
}
```

### text_contains_any

```ab
pub fun text_contains_any(source: Text, searches: [Text]): Bool 
```

Checks if an array value is in the text.

#### Usage
```ab
import { text_contains_any } from "std/text"

if text_contains_any("hello world", ["foo", "world", "bar"]) {
    echo("Found at least one!")
}
```

### text_find

```ab
pub fun text_find(text: Text, value: Text): Int 
```

Returns index of the first value found in the specified text.

If the value is not found, the function returns -1.

#### Usage
```ab
import { text_find } from "std/text"

text_find("abba", "b") // Outputs 1
```

### trim

```ab
pub fun trim(text: Text): Text 
```

Trims the spaces from the text input.

#### Usage
```ab
import { trim } from "std/text"

const trimmed = trim("   hello   ")
echo(trimmed) // "hello"
```

### trim_left

```ab
pub fun trim_left(text: Text): Text 
```

Trims the spaces at top of the text using `sed`.

#### Usage
```ab
import { trim_left } from "std/text"

const trimmed = trim_left("   hello")
echo(trimmed) // "hello"
```

### trim_right

```ab
pub fun trim_right(text: Text): Text 
```

Trims the spaces at end of the text using `sed`.

#### Usage
```ab
import { trim_right } from "std/text"

const trimmed = trim_right("hello   ")
echo(trimmed) // "hello"
```

### uniq_lines

```ab
pub fun uniq_lines(text: Text, remove_all: Bool = false): Text 
```

Removes duplicate lines from text.

#### Usage
```ab
import { uniq_lines } from "std/text"

let result = uniq_lines("foo\nfoo\nbar\nbar\nbaz")
echo(result) // "foo\nbar\nbaz"

let result = uniq_lines("foo\nbar\nfoo\nbaz\nbar", true) // Removes all duplicate lines from text (not just consecutive)
echo(result) // "foo\nbar\nbaz"
```

### uppercase

```ab
pub fun uppercase(text: Text): Text 
```

Makes the text input uppercase using `tr`.

#### Usage
```ab
import { uppercase } from "std/text"

const upper = uppercase("hello")
echo(upper) // "HELLO"
```

### zfill

```ab
pub fun zfill(text: Text, length: Int): Text 
```

Pads `text` with zeros on the left until it reaches the desired `length`.

#### Usage
```ab
import { zfill } from "std/text"

const padded = zfill("42", 5)
echo(padded) // "00042"
```

---

# Contributing

## How to

Welcome to the Amber Contributing Guidebook! 👋

This guide offers a clear and comprehensive introduction to getting started with contributing to Amber. If you haven’t already, consider joining our [Discord](https://discord.com/invite/cjHjxbsDvZ) community, where you can ask any questions and connect with other contributors.

### Contributing Guidelines

Before you dig into Amber, you should know a few things before you contribute.

Any code change is submitted [through a PR](https://github.com/amber-lang/Amber/pulls), which is then approved by at least 2 maintainers. Each pull request should be directed to the `staging` branch unless there is a specific justification for targeting the `master` branch.

The way we talk on GitHub is not the same as we would talk in person. When on GitHub, always get straight to the point and be critical.

Personal grudges are forbidden around here, as well as anything offtopic or offensive.

#### Opening a PR

Before a PR is opened, it usually has an issue about it first, where we discuss how exactly a feature must be implemented, to avoid making a mistake.

It is recommended that you see how features were already implemented. A good example is [#130](https://github.com/amber-lang/Amber/issues/130)

To create a PR, you should fork the repo, create a branch, do your work in there, and open a PR. It will then be reviewed and pushed into master.

The maintainers will check who it is the best reviewer, we suggest to open a ticket reporting the issue before starting to do the PR so we can discuss the implementation.

#### Getting Help

Along the way, you may need help with your code. The best way to ask is in [our Discord server](https://discord.com/invite/cjHjxbsDvZ), but you may also ask other contributors personally or post in [Discussions](https://github.com/amber-lang/Amber/discussions).

#### Development

Compile Amber with the following instructions:

```
git clone https://github.com/amber-lang/amber
cd amber
cargo build
```

In order to execute amber code, use the following command:

```bash
# `cargo run` - cargo command
# `run <file.ab>` - amber command
cargo run run <file.ab>
```

To compile amber code into a bash code, use the following command:

```bash
# `cargo run` - cargo command
# `build <input.ab> <output.sh>` - amber command
cargo run build <input.ab> <output.sh>
```

Debugging Amber:
```bash
# Displays Amber's AST trace of trying to parse code
AMBER_DEBUG_PARSER=true cargo run -- run <file.ab>
# Shows the time it took to compile each phase
AMBER_DEBUG_TIME=true cargo run -- run <file.ab>
# Flamegraph is a profiling tool that is used to visualize the time each function took to execute
sudo cargo flamegraph -- <file.ab> <file.sh>
```

##### Running Tests

Tests modules can be found in [`src/tests`](https://github.com/amber-lang/amber/tree/main/src/tests). Modules like [`erroring.rs`](https://github.com/amber-lang/amber/blob/main/src/tests/erroring.rs), [`stdlib.rs`](https://github.com/amber-lang/amber/blob/main/src/tests/stdlib.rs) and [`validity.rs`](https://github.com/amber-lang/amber/blob/main/src/tests/validity.rs) load test scenarios from directories `src/tests/erroring/`, `src/tests/stdlib/` and `src/tests/validity/` respectively.

To run ALL tests, run `cargo test`.

If you want to run only tests from a specific module, let's say from [`stdlib.rs`](https://github.com/amber-lang/amber/blob/main/src/tests/stdlib.rs), you can do that by adding the module name to the command: `cargo test stdlib`.

To run a single test case, for example `function_with_wrong_typed_return.ab` in `erroring`, you can filter by the test name:
`cargo test function_with_wrong_typed_return`

##### Github Actions

We use GitHub Actions to run tests and build binaries. When a new release tag is created, artifacts are built for Linux, macOS, and Windows (x86_64 and aarch64) and uploaded to the release page. We also generate installers and Debian packages.

## Guide

In this guidebook we will learn how the compiler works and how to contribute to it by adding new features or fixing bugs. We will cover the CLI interface, the compiler architecture, how to create builtins, the standard library and tests.

### CLI Interface

The entire CLI interface is defined in [`main.rs`](src/main.rs), using [`clap`](https://crates.io/crates/clap) for argument parsing. The `main` function initializes the `AmberCompiler` struct (defined in [`src/compiler.rs`](src/compiler.rs)), which serves as the main driver for the compilation process.

Available subcommands include:
*   `Run`: Compiles and executes an Amber script immediately.
*   `Build`: Compiles an Amber script to a Bash script.
*   `Eval`: Executes a snippet of Amber code passed as a string.
*   `Check`: parses and type-checks the code without generating output.
*   `Docs`: parsing the code and generating documentation for it.
*   `Test`: Runs tests defined in the Amber project.
*   `Completion`: Generates shell completion scripts.

When a command is executed, `main.rs` configures the `AmberCompiler` with the appropriate options and calls its methods (e.g., `compile()`, `execute()`, `generate_docs()`) to perform the requested task.

#### Compiler

Compiler consists of:
- `src/compiler.rs` - Main entry point for the compiler
- `src/rules.rs` - Syntax rules that are used by Heraclitus framework to correctly output tokens
- `src/utils` - Contains parsing environments, caches, contexts and Amber's implementations of metadata
- `src/modules` - Syntax modules that parse Amber syntax and also handle the translation process
- `src/translate` - Contains a definition of `TranslateModule` trait that is used to translate modules the previously mentioned `modules`

`AmberCompiler` struct by itself is just a bootstrapper for all the syntax modules. Here we will learn some practical facts about compiler. For a more in-depth guide, visit [our compiler guide](https://docs.amber-lang.com/contribute/compiler).

#### Parser & Tokenizer

Thanks to [`heraclitus`](https://github.com/amber-lang/Heraclitus), we can use simple abstractions to go through tokens.

Please open any syntax module code file, and find a line that says: 
```rs
impl SyntaxModule<ParserMetadata> for MODULE_NAME_HERE
```

It will have a `parse()` function, where all the magic happens. You can either dig into the code yourself or look at the example below to understand how it works.

<details>
<summary>Example parser</summary>


**Important: this is pseudo code. Its purpose is to demonstrate how it should look like.**

```rs
// This code parses the following: `1 + 2`
fn parse(meta: &mut ParserMetadata) -> SyntaxResult {
    let digit_1 = meta.get_current_token();     // gets the text (as an Option)
    token(meta, "+")?;                          // matches that there is a "+" and skips it
    let digit_2 = meta.get_current_token();

    self.digit_1 = digit_1.unwrap();
    self.digit_2 = digit_2.unwrap();

    Ok(())
}
```

</details>


#### Parsing Logic & Failures

The parsing process in Heraclitus revolves around the `SyntaxResult` type, which is an alias for `Result<(), Failure>`. The `Failure` type is critical for control flow and offers two distinct error modes:

*   **Quiet Error**: which means "This is not the syntax validation you are looking for."
    *   Returned when a syntax module doesn't match the current code (e.g., looking for a `let` keyword but finding `if`).
    *   The compiler catches this error and backtracks to try the next available syntax module.
*   **Loud Error**: which means "This IS the correct module, but the code is wrong."
    *   Returned when the compiler is certain it's parsing the correct construct but encounters invalid syntax (e.g., missing semicolon after variable declaration).
    *   This error halts the entire compilation process and reports a failure to the user.

#### Heraclitus Functions

Heraclitus provides a set of helper functions and macros to streamline parsing and error reporting:

*   `token(meta, "keyword")`: Attempts to consume a specific text token. Returns a **Quiet** error if the token doesn't match.
*   `token_by(meta, pattern)`: Matches a token based on a boolean predicate function. Returns a **Quiet** error failure.
*   `syntax(meta, &mut submodule)`: Recursively parses a nested syntax module. It propagates whatever error the submodule returns (Quiet or Loud).
*   `error!(meta, tok, ...)`: A macro that halts compilation with a **Loud** error at the position of provided token.
*   `error_pos!(meta, pos => ...)`: A macro that halts compilation with a **Loud** error at a *specific* position which can be more complex than single token, allowing for detailed error messages with context.

#### Translator

Same as parser open a syntax module, and find a line that says `impl TranslateModule for MODULE_NAME_HERE` and that should contain a `translate` function.

Same as before, you can either dig into the code you opened or look at the example below.

<details>
<summary>Example translator</summary>


**Important: this is pseudo code. Its purpose is to demonstrate how it should look like.**

```rs
// This will translate `1 + 2` into `(( 1 + 2 ))`
fn translate() -> String {

    // self.digit_1 and self.digit_2 is set earlier by the parser
    format!("(( {} + {} ))", self.digit_1, self.digit_2)
}
```

</details>


Basically, the `translate()` method should return a `FragmentKind` which represents a piece of the compiled shell script.

#### Fragments

Amber compiles to shell script fragments. The `FragmentKind` enum encapsulates these different types of output. You can find available fragment modules in `src/translate/fragments/`. Common ones include:

*   `RawFragment` (`raw`): Represents a raw string of shell code (e.g., `echo "hello"`).
*   `BlockFragment` (`block`): Represents a block of code, often used for bodies of functions or loops.
*   `ListFragment` (`list`): A list of fragments properly joined together.
*   `SubprocessFragment` (`subprocess`): For command substitutions `$(...)`.
*   `VarExprFragment` / `VarStmtFragment`: For handling variable usage and definition.

To construct these fragments easily, Amber provides helper macros:

*   `raw_fragment!("echo {}", value)`: Creates a `RawFragment` with formatted text.
*   `fragments!(a, b, c)`: joins multiple fragments into a `ListFragment`.

### Creating Builtins

In this guide we will see how to create a basic built-in function that in Amber syntax presents like:

```ab
example "Hello World"
```

And compiles to:

```sh
echo "Hello World"
```

For a real example based on this guide you can check the [`cd` builtin](https://github.com/amber-lang/amber/blob/master/src/modules/builtin/cd.rs) that is also Failable.

<details>
<summary>Let's start!</summary>


Create a `src/modules/builtin/builtin.rs` file with the following content:


```rs
// Import the core Heraclitus framework traits and types required for defining syntax modules
use heraclitus_compiler::prelude::*;
// Import the Expression module to parse arguments as expressions
use crate::modules::expression::expr::Expr;
// Import the TranslateModule trait to define how this syntax translates to shell code
use crate::translate::module::TranslateModule;
// Import metadata structures:
// - `ParserMetadata`: Tracks parsing state (declared variables, functions, warnings, current scope).
// - `TranslateMetadata`: Tracks translation state (indentation level, silent/eval modes).
use crate::utils::{ParserMetadata, TranslateMetadata};
// Import DocumentationModule (required trait, even if unused for internal builtins)
use crate::docs::module::DocumentationModule;
// Import the `raw_fragment` macro for easy construction of shell script fragments
use crate::raw_fragment;

// This struct represents the parsed state of our builtin.
// It holds the data extracted during parsing.
#[derive(Debug, Clone)]
pub struct Example {
    // We expect this builtin to take one argument, which is an expression.
    value: Expr,
}

// Implement the SyntaxModule trait to define how to parse this construct.
impl SyntaxModule<ParserMetadata> for Example {
    // Defines the name used for this module in compiler debug logs and traces.
    syntax_name!("Example");

    // Returns a default instance of the struct.
    fn new() -> Self {
        Example {
            value: Expr::new()
        }
    }

    // The core parsing logic.
    // Returns `SyntaxResult`, which is `Result<(), Failure>`.
    // See "2.1.1. Parsing Logic & Failures" for details on Quiet vs Loud errors.
    fn parse(&mut self, meta: &mut ParserMetadata) -> SyntaxResult {
        // 1. Match the keyword "example".
        // `token(...)` attempts to consume the specific token. If it fails, it returns a `Quiet` error.
        // The `?` operator propagates this error, allowing the compiler to try other modules.
        token(meta, "example")?;

        // 2. Parse the argument.
        // Once we've matched the keyword "example", we are committed to this syntax.
        // `syntax(...)` will return either a `Loud` or `Quiet` error from the submodule.
        syntax(meta, &mut self.value)?;
        Ok(())
    }
}

// Implement TypeCheckModule to validate types before translation.
impl TypeCheckModule for Example {
    fn typecheck(&mut self, meta: &mut ParserMetadata) -> SyntaxResult {
        // 1. Recursively typecheck the argument expression first.
        self.value.typecheck(meta)?;
        
        // 2. Validate that the argument is of the expected type (Text).
        if self.value.get_type() != Type::Text {
            let pos = self.value.get_position();
            // `error_pos!` creates a formatted `Loud` error message pointing to the specific
            // location in the user's code.
            return error_pos!(meta, pos => {
                message: "Builtin function `example` can only be used with values of type Text"
            });
        }
        Ok(())
    }
}

// Implement TranslateModule to convert the AST into the target shell script.
impl TranslateModule for Example {
    fn translate(&self, meta: &mut TranslateMetadata) -> FragmentKind {
        // 1. Translate the argument expression into a shell string.
        let value = self.value.translate(meta);
        
        // 2. Construct the final shell command.
        // `raw_fragment!` creates a code fragment that is inserted directly into the output script.
        raw_fragment!("echo {}", value)
    }
}

// Implement DocumentationModule.
// For internal builtins not exposed in standard docs, we return an empty string.
impl DocumentationModule for Example {
    fn document(&self, _meta: &ParserMetadata) -> String {
        String::new()
    }
}
```

Now let's import it in the main module for built-ins `src/modules/builtin/mod.rs`

```rs
pub mod echo;
pub mod nameof;
// ...
pub mod builtin;
```

Now we have to integrate this syntax module with either statement `Stmt` or expression `Expr`. Since this is a statement module, we'll add it to the list of statement syntax modules. Let's modify `src/modules/statement/stmt.rs`:

```rs
// 1. Import your new module
use crate::modules::builtin::builtin::Example;

// 2. Add it to the StmtType enum
// This allows the AST (Abstract Syntax Tree) to hold your new construct.
pub enum StmtType {
    // ...
    Example(Example)
}

// 3. Register it in the parsing loop
impl SyntaxModule<ParserMetadata> for Statement {
    // ...
    fn parse(&mut self, meta: &mut ParserMetadata) -> SyntaxResult {
        // `parse_statement!` iterates through the provided modules in order.
        // The order determines precedence (though keywords usually disambiguate).
        parse_statement!([
            // ...
            Example,
            // ...
        ], |module, cons| {
            // ...
        })
    }
}
```

</details>


Don't forget to add a test in the [`validity`](https://github.com/amber-lang/amber/tree/master/src/tests/validity) folder and to add the new builtin to the list of the [reserved keywords](https://github.com/amber-lang/amber/blob/master/src/modules/variable/mod.rs#L16).

### Standard Library

The Amber Standard Library (stdlib) is a collection of essential modules written in Amber itself, located in the `src/std` directory. It provides foundational capabilities that are available to every Amber program.

Modules include:
*   **Text** (`text.ab`): String manipulation functions (splitting, joining, trimming).
*   **Math** (`math.ab`): Mathematical constants and functions.
*   **Array** (`array.ab`): Utilities for handling arrays and lists.
*   **FS** (`fs.ab`): File system operations (reading, writing, checking existence).
*   **Env** (`env.ab`): Environment variable access and manipulation.
*   **Date** (`date.ab`): Date and time utilities.
*   **Http** (`http.ab`): Basic HTTP request capabilities.
and more...

Every function in the standard library is rigorously tested. You can find these tests in `src/tests/stdlib/`. When adding new standard library features, you must add corresponding tests to ensure correctness and prevent regressions.

### Tests

Amber uses `cargo test` for testing:
- `validity` - the validity of the compiler output (`src/tests/validity/`)
- `erroring` - the error handling of the compiler (`src/tests/erroring/`)
- `stdlib` - the standard library functions (`src/tests/stdlib/`)

For every test written in Amber there are 3 ways to check the result following this order:

* if a `// Output` comment on top that include the output to match
* `Succeeded` word will be matched against the test output

Tests will be executed without recompilation. Amber will load the scripts and verify the output in the designated file to determine if the test passes.

Some tests require additional setup, such as those for `download` that needs Rust to load a web server. These functions require special tests written in Rust that we can find in `src/tests/stdlib.rs` file.

<details>
<summary>Let's write a simple test</summary>


```rs
#[test]
fn prints_hi() {
    let code = "
        echo \"hi!\"
    ";
    test_amber(code, "hi!", TestOutcomeTarget::Success);
}
```

</details>

## Compiler structure

The Amber compiler follows a standard compilation pipeline to transform Amber source code into Bash scripts.

```mermaid
flowchart LR
    Lexer --> Parser
    Parser --> TypeCheck[Type Checker]
    TypeCheck --> Translator
    Translator --> Optimizer
    Optimizer --> Renderer
```

1.  **Lexer**: Transforms source code text into a stream of tokens (Keywords, Operators, Identifiers, etc.).
2.  **Parser**: Consumes tokens to build an Abstract Syntax Tree (AST), representing the code structure.
3.  **Type Checker**: Traverses the AST to validate types, ensure safety, and infer missing type information.
4.  **Translator**: Converts the typed AST into an intermediate representation called `FragmentKind` (Lower IR).
5.  **Optimizer**: Performs optimizations on the intermediate representation.
6.  **Renderer**: Converts the final IR into the target Bash string.

Here you will find out how the compiler is structured, how the parser works and how to write new syntax modules. Let's begin!

### Lexer

Beforehand the code is transformed into an array of tokens that contain information about:
- `word` - the token content
- `pos` - the token location in the document (row, column)
- `start` - the index in the code string where the token starts

```rs
struct Token {
    word: String,
    pos: (usize, usize),
    start: usize
}
```

Tokens are created with lexical rules that are contained in the [src/rules.rs](https://github.com/amber-lang/amber/blob/master/src/rules.rs) file.

Here is the example of how an array of Amber tokens can look like, where strings represent instances of `Token`:
```js
[Token<"let">, Token<"is_alive">, Token<"=">, Token<"true">, ...]
```

### Parser

Parser takes in Tokens and forms an Abstract Syntax Tree that represents the code written in Amber.

#### Syntax Module

What transforms tokens into the AST (Abstract Syntax Tree) is a `SyntaxModule`. It can be a `Text` literal, `echo` builtin or `Add` operator. The `SyntaxModule` is a trait that implements:
- `parse` method that parses the module and determines whether or not the corresponding token string represents this sytax module. If otherwise, then a `Failure::Quiet` is returned that means that this is not the correct module to parse the tokens. However if this is the correct module but an error is encountered, then `Failure::Loud` is returned with an error (or warning / info) is returned.
- `new` method that instantiates a new SyntaxModule.
- `syntax_name!("<name of this module>")` that identifies this syntax module with its name.

The most important method here is `parse` that is defined with the following signature:

```rs
fn parse(&mut self, meta: &mut M) where M: Metadata -> SyntaxResult;
```

Parsing returns a `SyntaxResult` that under the hood is represented as `Result<(), Failure>`. It means that parsing can be finished successfully or it can fail returning a `Failure` object.

Here is an example `SyntaxModule` that parses `Bool` literal:
```rs
impl SyntaxModule<ParserMetadata> for Bool {
    syntax_name!("Bool");

    fn new() -> Self {
        Bool {
            value: false
        }
    }

    fn parse(&mut self, meta: &mut ParserMetadata) -> SyntaxResult {
        let value = token_by(meta, |value| ["true", "false"].contains(&value.as_str()))?;
        self.value = value == "true";
        Ok(())
    }
}
```

#### Metadata

You can see that in the `parse` method mentioned above we pass some object called `meta`. This is a metadata parameter of type `ParserMetadata` that inherits from `Metadata` provided by Heraclitus. The structure instance is carried through the parsing process to keep a track of current state. It holds information such as declared variables, functions, boolean parameters telling if current context is within a loop or a function etc. `ParserMetadata` is represented as:

```rs
struct ParserMetadata {
    // Parsing contenxt
    pub context: Context
    // Error / Warning messages
    pub messages: Vec<Message>
    // ...
}
```

You can find out more about this structure in [src/utils/metadata/parser.rs](https://github.com/amber-lang/amber/blob/master/src/utils/metadata/parser.rs) file.

#### Parsing Flow

The journey starts with parsing the global `Block` that can be located in [src/modules/block.rs](https://github.com/amber-lang/amber/blob/master/src/modules/block.rs) file. The `Block` parses a sequence of statements (`Statement` located in [src/modules/statement/stmt.rs](https://github.com/amber-lang/amber/blob/master/src/modules/statement/stmt.rs)).

##### Statement

Statement (`Statement`) is a structure that can represent any `SyntaxModule` that is of statement type. In other words Statement is a wrapper for syntax modules that represents a statement type such as loop, if condition, variable declaration etc.

```rs
struct Statement {
    value: Option<StmtType>
}
```

Here we can see that the `value` field accepts `StmtType` enum that is declared above and represents a syntax module.

```rs
enum StmtType {
    Expr(Expr),
    VariableInit(VariableInit),
    VariableSet(VariableSet),
    IfCondition(IfCondition),
    // ...
}
```

Statement is built of a macro `parse_statement!` that can be located in [src/modules/statement/stmt.rs](https://github.com/amber-lang/amber/blob/master/src/modules/statement/stmt.rs). The syntax modules provided to the macro are parsed sequentially in the order from top to bottom. This means that the parser will first try to match `Import` and then `FunctionDeclaration`. The expression  (`Expr` located in [src/modules/expression/expr.rs](https://github.com/amber-lang/amber/blob/master/src/modules/expression/expr.rs)) is passed as the final parameter to the `parse_statement!` macro so that it's parsed at the very end.

```rs
parse_statement!([
    Import,
    FunctionDeclaration,
    // ...
    Expr
], ...);
```

This macro iterates through the provided syntax modules and attempts to parse them one by one. If a module successfully parses the code, the loop breaks and the result is returned.

The `StatementDispatch` derive macro is used on the `StmtType` enum to automatically generate dispatch methods for traits like `TranslateModule`, `TypeCheckModule`, etc. preventing the need to verify matches manually.

##### Expr

Expression (`Expr` located in [src/modules/expression/expr.rs](https://github.com/amber-lang/amber/blob/master/src/modules/expression/expr.rs)) represents a syntax that is a value of certain type (also referred to as _kind_ because of the Rust's type keyword). For example `1 + 1` is an addition of type `Num`.

```rs
struct Expr {
    // The value of the expression
    value: Option<ExprType>,
    // The type of the expression
    kind: Type,
    // The position of the expression
    position: Option<PositionInfo>
}
```

Analogically to `Statement`, expression also is a wrapper for syntax modules that are of expression type. Instead of `StmtType` enum `ExprType` is declared.

```rs
enum ExprType {
    Bool(Bool),
    Number(Number),
    Text(Text),
    Add(Add),
    Sub(Sub),
    // ...
}
```

Since certain expressions require different approaches to parsing, there is a different macro used here to automate the process. There are a couple of different types of expressions:
- `TernOp` - a ternary operator that is parsed from right to left. It's used for conditional ternary operator.
- `BinOp` - a binary operator that is parsed from left to right.
- `UnOp` - a unary operator that is parsed from left to right, where the symbol expression is on the left side.
- `TypeOp` - a binary expression that is represented as expression followed by operator and then a type. Example of such operator is a cast operator: `12 as Bool`.
- `Literal` - a Literal that doesn't have any directional precedence. Literal is the final group of expression precedence.

The hierarchy of the groups is represented within the `parse_expression!` macro (defined in [src/modules/expression/macros.rs](https://github.com/amber-lang/amber/blob/master/src/modules/expression/macros.rs)). It returns an Expr` that has been parsed.

<details>
<summary>How exactly does parsing expressions work?</summary>


```rs
let result = parse_expression!(meta, [
    ternary @ TernOp => [ Ternary ],
    range @ BinOp => [ Range ],
    addition @ BinOp => [ Add, Sub ],
    multiplication @ BinOp => [ Mul, Div, Modulo ],
    types @ TypeOp => [ Is, Cast ],
    unops @ UnOp => [ Neg, Not ],
    literals @ Literal => [ Bool, Number, Text ]
]);
```

The pattern that the macro follows can be represented as `<function_group_name> @ <group_type> => [<syntax_modules>]`. The macro is declared as a recurrent relation of functions (groups) that are calling each other (inside of an internal macro `parse_expr_group!`).

```rs
let result = {
    fn _terminal(...) {
        panic!("Please end the recurrence in the group before");
    }

    fn literal(...) {
        parse_expr_group!(... {literal, _terminal} ...);
    }

    // ...

    fn range(...) {
        parse_expr_group!(... {range, addition} ...);
    }

    fn ternary(...) {
        parse_expr_group!(... {ternary, range} ...);
    }

    return ternary(...);
};
```

The main objective of `parse_expr_group!` is to implement given function's body with appropriate parsing mechanism. If it's a `BinOp` that parses from left to right, then first we parse left expression by calling the lower order group, then we parse the operator, and then the right expression. You can read more on how parsing groups works in the macros file.

</details>


#### Type Checking

After the parsing phase is completed, the Compiler performs a Type Check that validates types of variables and expressions. This logic is contained within the `TypeCheckModule` trait located in [src/modules/typecheck.rs](https://github.com/amber-lang/amber/blob/master/src/modules/typecheck.rs).

```rs
pub trait TypeCheckModule {
    fn typecheck(&mut self, meta: &mut ParserMetadata) -> SyntaxResult;
}
```

This method is called after parsing but before translation. It allows the module to infer types, check for type mismatches, and mutate the module state (e.g. storing the inferred type) using the `ParserMetadata`.

#### Translation

The next step is translating the AST into an Intermediate Representation (Fragments) which is structurally closer to the target language (Bash). This is handled by the `TranslateModule` trait located in [src/translate/module.rs](https://github.com/amber-lang/amber/blob/main/src/translate/module.rs).

```rs
pub trait TranslateModule {
    fn translate(&self, meta: &mut TranslateMetadata) -> FragmentKind;
}
```

This method takes `TranslateMetadata` and transforms the module into a `FragmentKind`.

#### FragmentKind

`FragmentKind` is a crucial enum that represents a piece of generated code. It serves as an intermediate representation that abstracts over different types of Bash constructs before they are rendered into the final string. It is defined in [src/translate/fragments/fragment.rs](https://github.com/amber-lang/amber/blob/main/src/translate/fragments/fragment.rs).

```rs
pub enum FragmentKind {
    Raw(RawFragment),
    VarExpr(VarExprFragment),
    VarStmt(VarStmtFragment),
    Block(BlockFragment),
    Interpolable(InterpolableFragment),
    List(ListFragment),
    Subprocess(SubprocessFragment),
    Arithmetic(ArithmeticFragment),
    Comment(CommentFragment),
    Log(LogFragment),
    #[default] Empty
}
```

Its purpose is to provide structured generation of Bash code. For example:
- `VarExpr` handles variable access (like `$VAR`).
- `Subprocess` handles `$(...)` command substitutions.
- `Block` handles sequences of statements (like `{ ... }`).
- `Arithmetic` handles `(( ... ))` arithmetic contexts.

`FragmentKind` implements `FragmentRenderable` trait which allows it to be converted to a string. This is the final stage of compilation where Lower IR is rendered into actual Bash code:

```rs
fn to_string(self, meta: &mut TranslateMetadata) -> String;
```

---

# Amber by Example

> WARNING: Experimental standard library is used here. The full documentation covering it will be created soon as it get's more stable.

Here, you’ll find a collection of practical scripts designed to help you quickly grasp the fundamentals and advanced features of the Amber programming language. Whether you are new to programming or an experienced developer, these examples will guide you through.

Also check out [Awesome Amber](https://github.com/amber-lang/awesome-amberlang) - a curated list of awesome Amber tools, libraries, and resources.

## Backup Rotator

This script demonstrates an automated backup rotation system that keeps only the most recent backups while deleting older ones.

```ab
import { dir_exists, dir_create } from "std/fs"
import { parse_int, trim } from "std/text"
import { date_now, date_format_posix } from "std/date"

fun get_backup_count(backup_dir: Text): Int? {
    let count_output = trust $ ls -1 "{backup_dir}" | wc -l $
    return parse_int(trim(count_output))?
}

fun create_backup(source: Text, backup_dir: Text): Int? {
    let timestamp = date_format_posix(date_now())?
    let backup_name = "backup_{timestamp}.tar.gz"

    echo("Creating backup: {backup_name}")
    sudo $ tar -czf "{backup_dir}/{backup_name}" "{source}" $?

    echo("Backup created successfully")
    return 0
}

fun rotate_backups(backup_dir: Text, max_backups: Int) {
    let current_count = get_backup_count(backup_dir)?
    echo("Current backup count: {current_count}")

    // Remove old backups while we have too many
    while current_count > max_backups {
        echo("Removing oldest backup (count: {current_count}/{max_backups})")

        // Get the oldest backup file
        let oldest = trust $ ls -1t "{backup_dir}" | tail -n 1 $

        sudo $ rm "{backup_dir}/{oldest}" $ succeeded {
            echo("Removed: {oldest}")
        }
        current_count = get_backup_count(backup_dir)?
    }
    echo("Backup rotation complete. Keeping {current_count} backups.")
}

main(args) {
    if len(args) < 2 {
        echo("Usage: backup-rotator <source_dir> <backup_dir> [max_backups]")
        echo("Example: backup-rotator /var/www /backups 5")
        exit(1)
    }

    let source_dir = args[0]
    let backup_dir = args[1]
    let max_backups = len(args) >= 3
        then parse_int(args[2])?
        else 5

    // Validate source directory
    if not dir_exists(source_dir) {
        echo("Error: Source directory '{source_dir}' does not exist")
        exit(1)
    }

    // Create backup directory if it doesn't exist
    if not dir_exists(backup_dir) {
        echo("Creating backup directory: {backup_dir}")
        sudo dir_create(backup_dir) failed {
            echo("Failed to create backup directory")
            exit(1)
        }
    }

    // Create new backup
    create_backup(source_dir, backup_dir)?

    // Rotate old backups
    rotate_backups(backup_dir, max_backups)?
}
```

## ShellCheck tester

This script is used within the project to automate the process of identifying any ShellCheck validation issues in our test cases after they are compiled to Bash scripts.

> The script loops through all files in the Amber project's standard library test folder (`src/tests/stdlib/`), compiles each test to a Bash script, and then runs ShellCheck on the resulting script.
> If ShellCheck detects any issues (i.e., returns a non-zero exit code), the script generates a `.txt` report detailing the problems found. This report is stored in a designated temporary directory (`/tmp/amber-sc-tests`).

```ab
import { split, text_contains } from "std/text"
import { file_write, file_append, dir_exists, file_exists, dir_create } from "std/fs"

let path = "/tmp/amber-sc-tests"

if (not dir_exists(path)) {
    dir_create(path) failed {
        echo("Failed to create directory {path}")
        exit(1)
    }
}
trust $ cp -r "src/tests/stdlib/" {path} $
let report = "{path}/report.txt"
file_write(report, "Report for Shellcheck") failed {
    echo("Failed to write report file")
    exit(1)
}
let output = ""

let stdtests = trust $ /usr/bin/ls "src/tests/stdlib/" $
let stdlib = split(stdtests, "\n")

for v in stdlib {
    if not text_contains(v, ".txt") and file_exists("src/tests/stdlib/{v}") {
        echo("Generating Bash script for test {v}")
        trust $ ./target/debug/amber build "src/tests/stdlib/{v}" "{path}/{v}.sh" $
        
        $ shellcheck "{path}/{v}.sh" $ exited(code) {
            if code != 0 {
                echo("Shellcheck found something!")
                file_append(report, "\n--- Issues in {v} ---\n") failed {
                    echo("Failed to append to report")
                }
            }
        }
    }
}
```

## Ubuntu Updater

Here is an example script to periodically install software updates on an Ubuntu system. The update commands are wrapped in a `main` block, so that all commands between `$` signs can pass up errors with the `?` operator. The script will stop in that case and not execute any further commands.

> As you can see, the Amber code currently looks as if it is intertwined with bash commands. As development progresses, executing custom commands will be even better integrated with special syntax and improved runtime safety features to aid this process.

```ab
import { date_now, date_format_posix } from "std/date"

main {
    // Print output and log it at the same time.
    $ exec > >(tee -a /var/log/autoapt.log) 2>&1 $?
    // Log the current date so that we can check when any failed runs happened.
    echo(trust date_format_posix(date_now()))

    // Internet is slow on Austrian trains. Check the Wifi SSID and stop in that
    // case.
    $ iwgetid -r | grep -E '(OEBB|WESTlan)' $ succeeded {
        echo("Skipping updates because of slow Wifi")
        exit(0)
    }

    $ export DEBIAN_FRONTEND=noninteractive $?
    $ apt update $?
    // By default answer all user interaction questions with yes, for example
    // for debconf.
    // Use the old configuration file when new config files arrive.
    // Also say yes to setting up config files.
    $ yes '' | apt \
        -o Dpkg::Options::=--force-confold \
        -o Dpkg::Options::=--force-confdef \
        -y --allow-downgrades --allow-remove-essential \
        --allow-change-held-packages \
        upgrade $?
    // Clean up any packages that are not needed anymore.
    $ apt autoremove -y $?
    // Also update Snap packages.
    $ snap refresh --color=never --unicode=never $?
}
```

## Bot Detector

This script is meant for periodic execution and must be run as root. It scans an Nginx webserver log file for large volumes of requests from automated bots not identifying themselves as bots. If a bad bot makes more than 1000 requests per hour then the IP address is added to a blocklist file that can be picked up by firewall block software such as ipset.

```ab
// Script for detecting unwanted bots on our sites and blocking their IPs.
// Usage: ./bot-detector.sh <LOG_FILE_PATH>
// The script is triggered by a cronjob every 10 minutes.

import * from "std/text"

main (args) {
    if len(args) < 1 {
        echo("Path to log file missing.")
        echo("Usage: bot-detector.sh <logfile>")
        echo("       bot-detector.sh /var/log/nginx/access.log")
        exit(1)
    }

    let logfile = args[0]
    $ test -r {logfile} $ failed {
        echo("File not found or not readable: {logfile}")
        exit(1)
    }

    let start = parse_int($ date +%s $?)?

    // Get server IP address for excluding.
    let server_ip = $ hostname -i $?

    // We want to check the previous hour and the current hour.
    let timeframes = ["1 hour ago", "now"]
    for timeframe in timeframes {
        if timeframe == "1 hour ago" {
            echo("Checking the previous hour...")
        } else {
            echo("Checking the current hour...")
        }

        let hour_timestamp = $ date "+%d/%b/%Y:%H" -d "{timeframe}" $?
        // Get the top 20 IP addresses that accessed job pages for the given hour
        // timestamp. Includes a count per IP address in the format: "<count> <ip>".
        // Only check GET requests to certain job-related paths.
        // Ignore requests from well-behaved bots that send a bot user agent.
        // Never block requests from Google in the user agent.
        // Exclude requests to /files/ paths.
        // Check the top 20 results.
        let ip_log = trust $ grep -e "{hour_timestamp}" "{logfile}" | \
            grep \
                -e "GET /job/" \
                -e "GET /jobs/" \
                -e "GET /stelle/" \
                -e "GET /stellen/" \
                -e "GET /stellenangebot/" \
                -e "GET /de/stelle/" \
                -e "GET /de/stellen/" \
                -e "GET /de/stellenangebot/" | \
            grep -i -v "bot" | \
            grep -v "Google" | \
            grep -v /files/ | \
            awk '\{print \$1}' | sort | uniq -c | sort -nr | \
            grep -v "{server_ip}" | \
            head -n 20 $

        for line in lines(ip_log) {
            let parts = split(line, " ")
            let count = parse_int(parts[0])?
            // Skip IP addresses that sent less than 1000 requests.
            if count < 1000 {
                continue
            }

            let ip = parts[1]
            trust $ grep "{ip}" /etc/ipblocklist.txt $ succeeded {
                echo("IP address {ip} is already blocked.")
                continue
            }
            trust $ grep "{ip}" /etc/ipexcludedlist.txt $ succeeded {
                echo("IP address {ip} is allow-listed and will not be blocked.")
                continue
            }
            echo("Blocking IP address: {ip} ({count} requests)")
            $ echo "{ip}" >> /etc/ipblocklist.txt $?
            $ echo "\$(date) | IP addess {ip} added to the block list, RPH={count}" >> /var/log/bot-detector.log $?
        }
    }
    let end = parse_int($ date +%s $?)?
    let duration = end - start
    echo("Execution time: {duration} seconds")
}
```

## LSP Installer

This script automates the installation of several Language Server Protocol (LSP) tools, primarily by downloading them from GitHub and installing them on your system. The latest version of the script (and also **complete**) can be found [here](https://github.com/Mte90/My-Scripts/blob/master/dev/lsp-installer/install.ab).

> The script uses standard library functions to simplify the process of downloading, unpacking, and installing various LSP tools. It checks for necessary permissions, downloads the latest releases of selected LSPs, moves them to system directories, makes them executable, and installs additional LSPs using `npm`, `pip`, and `gem` as needed.
> For each tool, if the download or installation fails, an error message is displayed, and the script exits to prevent partial installations.

```ab
import { dir_exists, file_chmod, symlink_create } from "std/fs"
import { file_download } from "std/http"
import { is_root } from "std/env"
import { text_contains } from "std/text"

if not is_root() {
    echo("This script requires root permissions!")
    exit(1)
}

fun get_download_path(repo, position) {
    return trust $ curl -sL "https://api.github.com/repos/{repo}/releases" | jq -r ".[0].assets.[{position}].browser_download_url" $
}

fun move_to_bin(download_url, binary) {
    file_download(download_url, binary) failed {
        echo("Download for {binary} at {download_url} failed")
        exit(1)
    }
    
    mv binary "/usr/local/bin" failed {
        echo("Move {binary} to /usr/local/bin failed!")
        exit(1)
    }
    
    file_chmod("/usr/local/bin/{binary}", "+x") failed {
        echo("Failed to make {binary} executable")
        exit(1)
    }
}

fun download_to_bin(download_url, binary, packed_file) {
    file_download(download_url, packed_file) failed {
        echo("Download for {binary} at {download_url} failed")
        exit(1)
    }
    
    trust {
        if text_contains("tar.gz", packed_file) {
            $ tar -zxvf "./{packed_file}" -C ./ > /dev/null 2>&1 $
            trust mv "./{binary}" "/usr/local/bin"
        } else {
            $ gunzip -c - > "/usr/local/bin/{binary}" $
        }
        $ rm "./{packed_file}" $
    }
    
    file_chmod("/usr/local/bin/{binary}", "+x") failed {
        echo("Failed to make {binary} executable")
        exit(1)
    }
}

cd("/tmp")

echo("Install Typos LSP")
download_to_bin(get_download_path("tekumara/typos-lsp", 6), "typos-lsp", "typos.tar.gz")

echo("Install Rust LSP")
download_to_bin("https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz", "rust-analyzer", "rust-analyzer-x86_64-unknown-linux-gnu.gz")

echo("Install Lua LSP")
if not dir_exists("/opt/lua-language-server") {
    cd("/opt/")
    trust $ git clone https://github.com/LuaLS/lua-language-server $
} else {
    cd "/opt/lua-language-server"
}
silent trust {
    cd "lua-language-server"
    $ git pull $
    $ ./make.sh $
}
symlink_create("/opt/lua-language-server/bin/lua-language-server", "/usr/local/bin/lua-language-server") failed {
    echo("Failed to create symlink for lua-language-server")
    exit(1)
}

cd "/tmp"

let npm_lsp = ["vscode-langservers-extracted", "@tailwindcss/language-server", "@olrtg/emmet-language-server", "intelephense", "bash-language-server"]
let npm_lsp_name = ["CSS, HTML, JSON LSP", "Tailwind LSP", "Emmet LSP", "Intelephense LSP", "Bash LSP"]
for index, lsp in npm_lsp {
    echo("Install {npm_lsp_name[index]}")
    $ npm i -g "{lsp}" $ failed(code) {
        echo("Error! Exit code: {code}")
    }
}
```

## Awesome Amber

A curated list of Amber tools, libraries, and resources: [github.com/amber-lang/awesome-amberlang](https://github.com/amber-lang/awesome-amberlang).

---

# Press

Amber has attracted attention from various media outlets and community platforms, highlighting its innovative approach to compiling to Bash and its growing ecosystem.

## Articles

- [Amber compiles to Bash – Hackaday (May 2024)](https://hackaday.com/2024/05/22/amber-compiles-to-bash/) – An overview of Amber’s design and its ability to generate Bash scripts.
- [Bash via transpiler – Hackaday (Feb 2026)](https://hackaday.com/2026/02/12/bash-via-transpiler/) – Discusses Amber as a modern transpiler targeting Bash.

## Zine

- [Paged Out #8](https://pagedout.institute/?page=issues.php) - A 1-page article about Amber

## Conference talks

- [FOSDEM 2026 – Amber: Bash Transpiler (talk slides)](https://fosdem.org/2026/schedule/event/GGLZS9-amber-lang-bash-transpiler/) – Presentation at FOSDEM with slide deck hosted at https://mte90.tech/Talk-Amber/.

## Interviews

- [ClueCon Weekly with Daniele Scasciafratte: A Modern Way to Write Bash w/ Amber Lang](https://www.youtube.com/watch?v=oGQg3FdSpXc)
