os := $(shell sh -c 'uname -s 2>/dev/null || echo not')
debian := $(shell sh -c 'which apt > /dev/null; echo $$?')
mkdocs := $(shell sh -c 'which mkdocs > /dev/null; echo $$?')

mkdocs:
ifeq ($(mkdocs),1)
	@echo Installing MkDocs. Administrator rights are required.
ifeq ($(debian),0)
	@sudo apt-get install python-pip
else ifeq ($(os),Darwin)
	@sudo brew install python
else
	@echo Only Debian flavours of GNU/Linux and OSX are currently supported.
	@echo Install mkdocs manually: http://www.mkdocs.org/\#installation
	@exit 1
endif
	@sudo pip install mkdocs
endif

docs: mkdocs
	@mkdocs build --clean && mkdocs serve

docs-deploy: mkdocs
	@mkdocs gh-deploy --clean

