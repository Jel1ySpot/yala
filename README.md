# yala

> Yet Another LLM Agent

English | [中文](README_CN.md)

A simple and fully functional agent, written in Amber and compiled to Bash, running on any POSIX system.

## Use cases

- Installing Arch Linux
- Live CD, without installing extra software
- Operations and debugging

## Runtime requirements

- `bash`
- `curl`
- `jq`

On every start yala checks for jq; when jq is unavailable it downloads the binary for your platform from the [jq releases](https://github.com/jqlang/jq/releases) to `/tmp/yala/jq`.

## Install

- Run in the current directory: `curl -L -o yala https://github.com/jel1yspot/yala/releases/latest/download/yala.sh && chmod +x ./yala && ./yala --help`
- Install system-wide: `curl -fL -o /tmp/yala.sh https://github.com/jel1yspot/yala/releases/latest/download/yala.sh && sudo install -m 0755 /tmp/yala.sh /usr/local/bin/yala && yala --help`

## Commands

`yala --connect <provider>` interactively save LLM credentials.

`yala --model` list the models offered by the API endpoint.

`yala --model/-m <model_id>` select the model to use.

`yala --effort` show the current thinking effort and list the available levels.

`yala --effort <level>` set the thinking effort (`disable` / `minimal` / `low` / `medium` / `high` / `xhigh` / `max` / `ultra`).

`yala <message>` start a conversation.

`yala --new` clear the conversation history and start a new one.

`yala --continue/-c` retry from the latest user prompt or tool result.

`yala --help` show help, `yala --version` show the version.

### Environment variables

| Variable | Description |
| --- | --- |
| `YALA_API_KEY` | LLM API key |
| `YALA_API_BASE` | LLM API base URL |
| `YALA_MODEL` | Model name |
| `YALA_EFFORT` | Thinking effort |
| `YALA_SEARCH_API_KEY` | Anysearch API key used by `web_search`, anonymous when unset |
| `YALA_SEARCH_API_BASE` | Anysearch API base URL override, defaults to `https://api.anysearch.com` |
| `YALA_DEBUG` | Debug mode |

## Development

The project is developed and verified against Amber nightly.

```bash
make check    # type check
make test     # run all tests under tests/
make build    # compile to dist/yala
./dist/yala --help
make docs     # generate docs from /// comments into docs/
```

## Project layout

```
src/
  main.ab     argument parsing + main block
  cli.ab      command line helpers
  agent.ab    agent loop
  llm.ab      session messages and model list
  provider/openai.ab  OpenAI-compatible API client
  tools/bash.ab       tools run / sudo_run
  tools/question.ab   tool question
  tools/web.ab        tool web_search
  tools/files.ab      file read/write helpers
  json.ab     JSON/jq runtime
  config.ab   environment, /tmp/yala state files, defaults
  ui.ab       terminal output
tests/        amber test .
docs/         amber docs
dist/         amber build output (the executable script)
```
