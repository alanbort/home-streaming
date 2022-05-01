# Macros
README = @cat README.md
TEST_DIRECTORY:=$(shell echo ${PWD}/../tmp)
DISTRIBUTION := $(shell lsb_release -cs)
VERSION := $(shell cat VERSION)
HELP_MAKE_TARGETS = @cat Makefile | \
                    grep -E -e '[a-z\-]*:\s*[a-z]*\-?[a-z]* \#.*$$' | \
                    grep -v '^ *\#' | \
                    sort | \
                    grep --color '^[a-z\-]*' 

# Makefile Functionality

default: help

## Documentation and help
.PHONY: help fullhelp

help: # show quick list of actions
	@echo Make Targets
	@echo =================
	$(HELP_MAKE_TARGETS)

fullhelp: # show full documentation and list of available actions
	$(README)
	@echo
	@echo =================
	@echo Make Targets
	@echo =================
	$(HELP_MAKE_TARGETS)

## Manage Status
.PHONY: start stop update restart
start: # Start full stack of applications
	docker-compose -f download_manager/docker-compose.yml up -d
	docker-compose -f media_server/docker-compose.yml up -d
	docker-compose -f landing_page/docker-compose.yml up -d

stop: # Stop full stack of applications
	docker-compose -f download_manager/docker-compose.yml down
	docker-compose -f media_server/docker-compose.yml down
	docker-compose -f landing_page/docker-compose.yml down

update: # Get latest docker images for all applications
	$(MAKE) stop
	docker-compose -f download_manager/docker-compose.yml pull
	docker-compose -f media_server/docker-compose.yml pull
	docker-compose -f landing_page/docker-compose.yml pull
	$(MAKE) start

restart: # Stop and Start full stack of applications
	$(MAKE) stop
	$(MAKE) start

## Cleanup
.PHONY: clean

clean:
	$(MAKE) stop
	find . -mindepth 2 -maxdepth 2 -not -path '*/.git/*' -not -path '*/landing_page/*' -type d -exec rm -fR {} \;
	sudo rm -fR landing_page/heimdall