GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
BINARY_NAME=germanium

all: build test
build:
	$(GOBUILD) -o $(BINARY_NAME) -v ./cmd/$(BINARY_NAME) 

run: build
	./germanium -o assets/img/sqfinder.png -s research --no-line-number --no-window-access-bar -b#000 ../../GOsample/sqfinder.go

run-%: build
	if [ -e ../../GOsample/$(@:run-%=%) ]; then mkdir -p assets/img/$(basename $(@:run-%=%)); fi
	./germanium -o assets/img/$(basename $(@:run-%=%))/$(basename $(@:run-%=%))Res.png -s research --no-line-number --no-window-access-bar -b#000 ../../GOsample/$(@:run-%=%)
	./germanium -o assets/img/$(basename $(@:run-%=%))/$(basename $(@:run-%=%))Rai.png -s rainbow_dash --no-line-number --no-window-access-bar -b#000  ../../GOsample/$(@:run-%=%)

echo-%:
	echo $(basename $(@:run-%=%))

test:
	$(GOTEST) -v ./...
gentest: build
	$(GOTEST) -v ./... -gen_golden_files
clean:
	$(GOCLEAN)
	rm -f $(BINARY_NAME)
