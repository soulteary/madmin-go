# Golang Admin Client API 参考（社区 fork）[![Slack](https://slack.min.io/slack?type=svg)](https://slack.min.io)

> [English](./README.md)

MinIO Admin Golang Client SDK 提供了用于管理 MinIO 服务的一系列 API。

本快速上手指南将介绍如何安装 MinIO Admin client SDK、连接到 MinIO admin 服务，并通过一个简单示例演示其用法。

本文档假设你已经具备可用的 [Golang 开发环境](https://golang.org/doc/install)。

> **⚠️ 本仓库是 `minio/madmin-go` 的独立社区维护 fork。**
>
> 本项目与 MinIO, Inc. **没有**任何隶属、背书或赞助关系。
> "MinIO" 是 MinIO, Inc. 的商标，此处仅用于标识本 fork 所派生自的上游项目。
> Apache License 2.0 不授予任何商标权利（见许可证第 6 节）。
>
> 本 fork 基于 `madmin-go` **最后一个 Apache License 2.0 版本**（在 MinIO 改用
> GNU AGPLv3 之前），并继续以 [Apache License, Version 2.0](./LICENSE) 分发。
> MinIO, Inc. 及所有第三方子组件的原始版权声明均予以保留，详见 [`NOTICE`](./NOTICE)。
>
> Fork 主页：https://github.com/soulteary/madmin-go

## 关于本 fork

本仓库是 `madmin-go` 的定制 fork，与上游存在以下差异：

- **构建工具链**：要求 Go `1.27.3` 及以上版本（详见 `go.mod`）。
- **依赖**：所有模块依赖均已升级到当前可用的最新版本。
- **工程化**：现代化的 CI 工作流、golangci-lint v2 配置，以及用于常见开发任务的 `Makefile`（`make check`、`make lint`、`make test`）。

> 说明：本文中出现的上游链接（`min.io`、`slack.min.io` 等）以及 `minio/madmin-go`
> 导入路径均指向**原始上游项目**。如需使用本 fork，请在你的 `go.mod` 中将依赖替换为
> `github.com/soulteary/madmin-go`（通过 `replace` 指令或直接 require）。

## 安装

```sh
go get github.com/soulteary/madmin-go
```

## 初始化 MinIO Admin Client

```go
package main

import (
	"context"
	"log"

	madmin "github.com/minio/madmin-go"
)

func main() {
	// 使用安全（HTTPS）连接。
	ssl := true

	// 初始化 minio admin client 对象。
	madmClnt, err := madmin.New("your-minio.example.com:9000", "YOUR-ACCESSKEYID", "YOUR-SECRETKEY", ssl)
	if err != nil {
		log.Fatalln(err)
	}

	// 获取服务信息。
	si, err := madmClnt.ServerInfo(context.Background())
	if err != nil {
		log.Fatalln(err)
	}
	log.Printf("%+v\n", si)
}
```

## 本地开发

```sh
# 安装开发依赖（golangci-lint、msgp、stringer）
make getdeps

# 校验 + 构建 + 测试
make check

# 仅执行 lint
make lint

# 仅执行测试
make test
```

## 完整 API 参考

完整的 API 列表（Service / Info / Healing / Config / Top / IAM / KMS 等操作及示例）请参阅英文文档 [README.md](./README.md)。

## License

本项目以 [Apache License 2.0](./LICENSE) 分发。
