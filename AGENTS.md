# yala — Agent Notes

本文件是给 AI 编码助手看的项目记忆；`README.md`（英文）与 `README_CN.md`（中文）面向用户。

## 项目

- yala = Yet Another LLM Agent，用 Amber 编写、编译为 Bash。
- 入口 `src/main.ab`，模块 `src/{cli,config,llm,agent,ui}.ab` 与 `src/{provider,tools}/`，测试 `tests/*_test.ab`。
- 常用命令：`make check`、`make test`、`make build`（产物 `dist/yala`）、`make docs`。
- HTTP 响应与工具输出都不走 shell 变量：AI 响应由 `curl -o` 写入 `/tmp/yala/{请求序号}.out`，
  工具输出重定向到 `/tmp/yala/{tool_call_id}.tool.out`；解析函数接收文件路径、用 jq 直接读文件，
  tool 消息用 `jq --rawfile` 组装。不要把解析函数改回文本参数。
- 可能很长的 jq 输入（messages/message/value/tools/model/effort/query/calls/index/key）先经
  `jq_payload()` 写入 `/tmp/yala/jq.{pid}.{name}.tmp`，再用 `--rawfile`/`--slurpfile` 交给 jq；
  不要用 `--arg`/`--argjson` 传长文本（Linux 单参数上限 128 KiB，会 execve E2BIG）。
  用户 prompt 例外，仍走 `--arg`。

## Nix 打包

- `flake.nix` + `nix/package.nix`：用 nixpkgs 的 `amber-lang`（0.6.0-alpha）从源码构建；
  源码由 flake 传入（`src = self`），`doCheck` 会跑 `amber test .`，
  安装后用 `wrapProgram` 把 bash/coreutils/curl/gnugrep/jq 注入 PATH。
- `nix/package.nix` 的 `version` 要和 `src/cli.ab` 的 `VERSION` 同步，
  不一致时 `versionCheckHook` 会让构建失败；改动后用 `nix flake check` 验证。

## Amber 工具链

- 系统版已是 nightly：`/opt/amber/amber`（release `0.6.1-nightly-2026-04-30`，commit `4bb3c49`），
  `/usr/local/bin/amber` 是指向它的软链接；`amber --version` 只打印 commit。
- 升级方式：下载
  `https://github.com/amber-lang/amber/releases/download/nightly/amber-linux-gnu-x86_64.tar.xz`，
  解压后 `sudo install -m 755 amber /opt/amber/amber`。
- 文档快照：`amber_doc.md`（nightly-alpha，部分示例与实际行为不符）。
- 本工具箱容器 `sudo` 要密码且没有 polkit 图形代理，pkexec 会被判定为非受信调用方；
  需要 root 时用 xterm 弹窗输密码：
  `xterm -fa Monospace -fs 12 -e bash -lc 'sudo <cmd>; echo; read -r'`（DISPLAY=:1 共享自宿主机）。

## Amber 编译器实测特性（0.6.0-alpha 与 nightly 4bb3c49）

1. `:` 是单语句简写（文档明确），多语句分支必须用 `{}`，否则多出的语句会在分支外执行。
2. 没有 `else if`；用 if-chain 或嵌套 `if`，函数前加 `#[allow_nested_if_else]` 消警告。
3. 被 `import` 的模块里函数必须先定义后使用（入口文件无此限制）。
4. `main(args)` 的 `args[0]` 是执行器名字（`amber run`/shebang 是 `bash`，编译后是脚本路径），
   用户参数从 index 1 开始。
5. `env_var_get()` 返回 `Text?`，必须用 `trust`/`env_var_test`/`failed`/`?` 处理；
   文档里 `const x = env_var_get(...)` 的写法不能编译。
6. `amber build` 不会自动创建输出目录；`amber docs in.ab OUTDIR` 的 OUTDIR 相对输入文件解析；
   测试过滤参数是 `--test-case <前缀>`。
7. `and`/`or` 不会短路：两侧表达式都会被求值，有副作用的调用不能靠右侧"兜底"，
   必须放进独立的 `if` 或用自身校验（实测 `if known == true and set_x(...)` 会执行 `set_x`）。

## 编码约定

- 所有 `if`/`for` 分支一律用 `{}`；不用 `else if`。
- 被 import 的模块中先定义辅助函数，再定义调用它的函数。
- 用户参数统一走 `cli.ab` 的辅助函数（跳过 `args[0]`）。
- 只有 `main.ab` 有 `main` 块；顶层只放定义，导出用 `pub`，跨目录用相对路径。
