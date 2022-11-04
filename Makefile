GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
BINARY_NAME=germanium

all: build test
build:
	$(GOBUILD) -o $(BINARY_NAME) -v ./cmd/$(BINARY_NAME) 

run: build
	./germanium -s research --no-line-number --no-window-access-bar -b#000 panel.go
test:
	$(GOTEST) -v ./...
gentest: build
	$(GOTEST) -v ./... -gen_golden_files
clean:
	$(GOCLEAN)
	rm -f $(BINARY_NAME)
