PWD := $(shell pwd)
GOPATH := $(shell go env GOPATH)

all: check

getdeps:
	@mkdir -p ${GOPATH}/bin
	@which golangci-lint 1>/dev/null || (echo "Installing golangci-lint" && go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest)
	@which msgp 1>/dev/null || (echo "Installing msgp" && go install github.com/tinylib/msgp@latest)
	@which stringer 1>/dev/null || (echo "Installing stringer" && go install golang.org/x/tools/cmd/stringer@latest)

verifiers: getdeps vet lint check-gen

vet:
	@echo "Running $@"
	@go vet ./...

lint:
	@echo "Running $@"
	@${GOPATH}/bin/golangci-lint cache clean
	@${GOPATH}/bin/golangci-lint run --config ./.golangci.yml

check-gen:
	@echo "Running $@"
	@go generate ./... >/dev/null
	@(! git diff --name-only | grep -E '(_gen\.go|_string\.go)$$') || (echo "Non-committed changes in auto-generated code detected, please commit them to proceed." && false)

build:
	@echo "Running $@"
	@go build ./...

test:
	@echo "Running unit tests"
	@go test -v ./...

test-race:
	@echo "Running unit tests under -race"
	@go test -v -race ./...

check: verifiers build test

clean:
	@echo "Cleaning up all the generated files"
	@find . -name '*.test' | xargs rm -fv
	@go clean -testcache

.PHONY: all getdeps verifiers vet lint check-gen build test test-race check clean
