# yala

> Yet Another LLM Agent

[English](README.md) | 中文

一个简易且功能完备的 Agent ，使用 Amber 编写，编译为 Bash，在任何 POSIX 系统中运行。

## 场景

- 安装 Arch Linux
- Live CD，不想安装软件
- 运维管理，临时调试

## 运行时依赖

- `bash`
- `curl`
- `jq`

每次启动时 yala 都会检查 jq，当 jq 不可用时，自动从 [jq Release](https://github.com/jqlang/jq/releases) 下载对应平台二进制到 `/tmp/yala/jq`。

## 安装

- 在当前目录下运行：

```bash
curl -L -o yala https://github.com/jel1yspot/yala/releases/latest/download/yala.sh && chmod +x ./yala && ./yala --help
```

- 安装到系统目录下：

```bash
curl -fL -o /tmp/yala.sh https://github.com/jel1yspot/yala/releases/latest/download/yala.sh && sudo install -m 0755 /tmp/yala.sh /usr/local/bin/yala && yala --help
```

- 使用 Nix：

```bash
# 不安装直接运行
nix run github:Jel1ySpot/yala -- --help

# 安装到用户 profile
nix profile install github:Jel1ySpot/yala
```

NixOS（flake）可以把 yala 加为 input，再用 overlay 或模块：

```nix
{
  inputs.yala.url = "github:Jel1ySpot/yala";

  # 用 overlay 后即可使用 pkgs.yala
  nixpkgs.overlays = [ inputs.yala.overlays.default ];
  environment.systemPackages = [ pkgs.yala ];

  # 或者导入模块，直接安装到系统
  imports = [ inputs.yala.nixosModules.default ];
}
```

## 命令

`yala --connect <provider>` 交互式配置 LLM 凭据。

`yala --model` 列出 API 端点提供的模型。

`yala --model/-m <model_id>` 选择使用的模型。

`yala --effort` 显示当前思考强度并列出可选等级。

`yala --effort <level>` 设置思考强度 (`disable` / `minimal` / `low` / `medium` / `high` / `xhigh` / `max` / `ultra`)。

`yala <message>` 发起对话。

`yala --new` 清空历史上下文，开始新对话。

`yala --continue/-c` 从最近一条 user prompt 或 tool result 发起重试。

`yala --help` 显示帮助，`yala --version` 显示版本。

### 环境变量

| 变量 | 说明 |
| --- | --- |
| `YALA_API_KEY` | LLM API key |
| `YALA_API_BASE` | LLM API 地址 |
| `YALA_MODEL` | 模型名 |
| `YALA_EFFORT` | 思考强度 |
| `YALA_SEARCH_API_KEY` | `web_search` 使用的 Anysearch API key，未设置时匿名调用 |
| `YALA_SEARCH_API_BASE` | Anysearch API 地址覆盖，默认 `https://api.anysearch.com` |
| `YALA_DEBUG` | 调试模式 |

## 开发

本项目在 Amber nightly 上开发验证。

```bash
make check    # 类型检查
make test     # 运行 tests/ 下的所有测试
make build    # 编译到 dist/yala
./dist/yala --help
make docs     # 从 /// 注释生成文档到 docs/
```

## 项目结构

```
src/
  main.ab     参数解析 + main 块
  cli.ab      命令行辅助
  agent.ab    agent loop
  llm.ab      会话消息组装与模型列表
  provider/openai.ab  OpenAI 兼容 API 客户端
  tools/bash.ab       工具 run / sudo_run
  tools/question.ab   工具 question
  tools/web.ab        工具 web_search
  tools/files.ab      文件读写辅助
  json.ab     JSON/jq 运行时
  config.ab   环境变量、/tmp/yala 状态文件、默认配置
  ui.ab       终端输出
tests/        amber test .
docs/         amber docs
dist/         amber build 的可执行脚本
flake.nix     Nix flake（package、overlay、NixOS 模块）
nix/package.nix     Nix 构建表达式（使用 nixpkgs 的 amber-lang）
```

## 许可证

MIT，详见 [LICENSE](LICENSE)。
