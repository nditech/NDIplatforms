lock=make-lock
make=make
tmp_dir=tmp
d=$(tmp_dir)/drush
drush_dir=$(tmp_dir)/drush-source
branch=master
ts=`date --iso-8601=seconds`
ds=`date +%Y%m%d`
pl=/var/aegir/platforms
makes=~/makefiles/NDIplatforms
cores = drupal7 drupal8
stock = dkan civicrm
demtools = demtools/dkan demtools/civicrm

list:
	@echo "The following targets are available:"
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'| sed 's/^/  /' --

clean:
	@rm -rf $(tmp_dir)

clean-tests:
	@rm -rf $(tmp_dir)/demtools-*

clean-drush:
	@mkdir -p $(tmp_dir)
	@rm -f $(d)

drush: clean-drush
	@curl -SsL -z $(d) -o $(d) http://files.drush.org/drush.phar
	@chmod a+x $(d)
	@$(d) --version

drush-unstable: clean-drush
	@curl -SsL -z $(d) -o $(d) http://files.drush.org/drush-unstable.phar
	@chmod a+x $(d)
	@$(d) --version

drush-source: clean-drush
	@if ! [ -d $(drush_dir) ]; then git clone https://github.com/drush-ops/drush.git $(drush_dir); fi
	@cd $(drush_dir); git checkout $(branch)
	@cd $(drush_dir); curl -SsL -z ./composer.phar https://getcomposer.org/installer | php
	@chmod a+x $(drush_dir)/composer.phar
	@cd $(drush_dir); ./composer.phar install --prefer-source
	@ln -s drush-source/drush $(d)
	@chmod a+x $(d)
	@$(d) --version
	@echo " Drush git branch:" `cd tmp/drush-source/; git rev-parse --abbrev-ref HEAD`


all: cores stock demtools

cores: $(cores)
$(cores): %: cores/%.lock.yml
cores/%.lock.yml: cores/%.build.yml cores/%.make.yml
	$(d) $(lock) $< --result-file=$@

stock: $(stock)
$(stock): %: stock/%.lock.yml
stock/%.lock.yml: stock/%.build.yml cores/drupal7.lock.yml stock/%.make.yml
	$(d) $(lock) $< --result-file=$@

demtools: $(demtools)
$(demtools): %: %.lock.yml
demtools/%.lock.yml: demtools/%.build.yml stock/%.lock.yml demtools/%/*
	$(d) $(lock) $< --result-file=$@
demtools/%-test: demtools/%
	$(d) make demtools/$*.lock.yml $(tmp_dir)/demtools-dkan-$(ts)
demtools/%-platform: demtools/%
	#$(d) $(make) demtools/$*.lock.yml $(pl)/demtools-$*-$(ds)$(inc)
	#drush provision-save @platform_demtools$*$(ds)$(inc) --root=$(pl)/demtools-$*-$(ds)$(inc) --makefile=$(makes)/demtools/$*.lock.yml --context_type=platform
	#drush @hostmaster hosting-import @platform_demtools$*$(ds)$(inc)
