include .mk/GNUmakefile

d=drush
lock=make-lock
make=make
pl=/var/aegir/platforms
makes=~/makefiles/NDIplatforms
makefile_dir=makefiles
cores_dir=$(makefile_dir)/cores
stock_dir=$(makefile_dir)/stock
demtools_dir=$(makefile_dir)/demtools
d7platforms_dir=$(makefile_dir)/d7platforms

tmp_dir=tmp
test_dir=$(tmp_dir)/tests
ts=`date --iso-8601=seconds`
ds=`date +%Y%m%d`

cores = drupal7 drupal8
stock = dkan civicrm d7 petitions
demtools = demtools/dkan demtools/civicrm demtools/petitions
d7platforms = d7platforms/iredd

all: cores stock demtools d7platforms

cores: $(cores)
$(cores): %: $(cores_dir)/%/lock.yml
$(cores_dir)/%/lock.yml: $(cores_dir)/%/build.yml $(cores_dir)/%/*.make.yml
	$(d) $(lock) $< --result-file=$@

stock: $(stock)
$(stock): %: $(stock_dir)/%/lock.yml
$(stock_dir)/%/lock.yml: $(stock_dir)/%/build.yml $(cores_dir)/drupal7/lock.yml $(stock_dir)/%/*.make.yml
	$(d) $(lock) $< --result-file=$@

demtools: $(demtools)
$(demtools): %: $(makefile_dir)/%/lock.yml
$(demtools_dir)/%/lock.yml: $(demtools_dir)/%/build.yml $(stock_dir)/%/lock.yml $(demtools_dir)/%/*.make.yml
	$(d) $(lock) $< --result-file=$@
demtools/%-test: demtools/% init
	$(d) make --working-copy $(demtools_dir)/$*/lock.yml $(test_dir)/demtools-$*-$(ts)
demtools/%-platform: demtools/%
	$(d) $(make) $(demtools_dir)/$*/lock.yml $(pl)/demtools-$*-$(ds)$(inc)
	drush provision-save @platform_demtools_$*_$(ds)$(inc) --root=$(pl)/demtools-$*-$(ds)$(inc) --makefile=$(makes)/$(demtools_dir)/$*/lock.yml --context_type=platform
	drush @hostmaster hosting-import @platform_demtools_$*_$(ds)$(inc)
demtools/%-dev: demtools/%
	$(d) $(make) $(demtools_dir)/$*/lock.yml $(pl)/demtools-$*-dev-$(ds)$(inc) --working-copy
	drush provision-save @platform_demtools_$*_dev_$(ds)$(inc) --root=$(pl)/demtools-$*-dev-$(ds)$(inc) --makefile=$(makes)/$(demtools_dir)/$*/lock.yml --context_type=platform
	drush @hostmaster hosting-import @platform_demtools_$*_dev_$(ds)$(inc)
	drush @hostmaster hosting-task @platform_demtools_$*_dev_$(ds)$(inc) lock

d7platforms: $(d7platforms)
$(d7platforms): %: $(makefile_dir)/%/lock.yml
$(d7platforms_dir)/%/lock.yml: $(d7platforms_dir)/%/build.yml $(stock_dir)/d7/lock.yml $(d7platforms_dir)/%/*.make.yml
	$(d) $(lock) $< --result-file=$@
d7platforms/%-test: d7platforms/% init
	$(d) make $(d7platforms_dir)/$*/lock.yml $(test_dir)/d7platforms-$*-$(ts)
d7platforms/%-platform: d7platforms/%
	$(d) $(make) $(d7platforms_dir)/$*/lock.yml $(pl)/d7platforms-$*-$(ds)$(inc)
	drush provision-save @platform_d7platforms_$*_$(ds)$(inc) --root=$(pl)/d7platforms-$*-$(ds)$(inc) --makefile=$(makes)/$(d7platforms_dir)/$*/lock.yml --context_type=platform
	drush @hostmaster hosting-import @platform_d7platforms_$*_$(ds)$(inc)

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

