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

list:
	@cat Makefile | grep "^[[:alpha:]]" | grep ":" | grep -v "^locks" | sed s/:[^:]*//

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


all: stock demtools

stock: drupal7 drupal8 dkan civicrm

demtools: demtools-dkan demtools-civi

drupal7: locks/drupal7.lock.yml
locks/drupal7.lock.yml: stubs/drupal7.make.yml includes/drupal/core.7.make.yml
	$(d) $(lock) stubs/drupal7.make.yml --result-file=locks/drupal7.lock.yml
drupal8: locks/drupal8.lock.yml
locks/drupal8.lock.yml: stubs/drupal8.make.yml includes/drupal/core.8.make.yml
	$(d) $(lock) stubs/drupal8.make.yml --result-file=locks/drupal8.lock.yml

dkan: locks/dkan.lock.yml
locks/dkan.lock.yml: locks/drupal7.lock.yml stubs/dkan.make.yml includes/dkan/profile.make.yml
	$(d) $(lock) stubs/dkan.make.yml --result-file=locks/dkan.lock.yml
demtools-dkan: locks/demtools-dkan.lock.yml
locks/demtools-dkan.lock.yml: locks/dkan.lock.yml stubs/demtools-dkan.make.yml includes/dkan/*
	$(d) $(lock) stubs/demtools-dkan.make.yml --result-file=locks/demtools-dkan.lock.yml
demtools-dkan-test: demtools-dkan
	$(d) make locks/demtools-dkan.lock.yml $(tmp_dir)/demtools-dkan-$(ts)

civicrm: locks/civicrm.lock.yml
locks/civicrm.lock.yml: locks/drupal7.lock.yml stubs/civicrm.make.yml includes/civicrm/civicrm.make.yml
	$(d) $(lock) stubs/civicrm.make.yml --result-file=locks/civicrm.lock.yml
demtools-civi: locks/demtools-civi.lock.yml
locks/demtools-civi.lock.yml: locks/civicrm.lock.yml stubs/demtools-civi.make.yml
	$(d) $(lock) stubs/demtools-civi.make.yml --result-file=locks/demtools-civi.lock.yml
demtools-civi-test: demtools-civi
	$(d) $(make) locks/demtools-civi.lock.yml $(tmp_dir)/demtools-civi-$(ts)
# Remove the `drush make` step once Aegir is using Drush 8+
demtools-civi-platform: demtools-civi
	$(d) $(make) locks/demtools-civi.lock.yml $(pl)/demtools-civi-$(ds)$(inc)
	drush provision-save @platform_demtoolscivi$(ds)$(inc) --root=$(pl)/demtools-civi-$(ds)$(inc) --makefile=$(makes)/locks/demtools-civi.lock.yml --context_type=platform
	drush @hostmaster hosting-import @platform_demtoolscivi$(ds)$(inc)
