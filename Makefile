cores = drupal7 drupal8
stock = dkan civicrm d7
demtools = demtools/dkan demtools/civicrm
d7platforms = d7platforms/iredd d7platforms/cp-manual

include .mk/*

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
	$(d) make $(demtools_dir)/$*/lock.yml $(test_dir)/demtools-$*-$(ts)
demtools/%-platform: demtools/%
	$(d) $(make) $(demtools_dir)/$*/lock.yml $(pl)/demtools-$*-$(ds)$(inc)
	drush provision-save @platform_demtools$*$(ds)$(inc) --root=$(pl)/demtools-$*-$(ds)$(inc) --makefile=$(makes)/$(demtools_dir)/$*/lock.yml --context_type=platform
	drush @hostmaster hosting-import @platform_demtools$*$(ds)$(inc)

d7platforms: $(d7platforms)
$(d7platforms): %: $(makefile_dir)/%/lock.yml
$(d7platforms_dir)/%/lock.yml: $(d7platforms_dir)/%/build.yml $(stock_dir)/d7/lock.yml $(d7platforms_dir)/%/*.make.yml
	$(d) $(lock) $< --result-file=$@
d7platforms/%-test: d7platforms/% init
	$(d) make $(d7platforms_dir)/$*/lock.yml $(test_dir)/d7platforms-$*-$(ts)
d7platforms/%-platform: d7platforms/%
	$(d) $(make) $(d7platforms_dir)/$*/lock.yml $(pl)/d7platforms-$*-$(ds)$(inc)
	drush provision-save @platform_d7platforms_$*$(ds)$(inc) --root=$(pl)/d7platforms-$*-$(ds)$(inc) --makefile=$(makes)/$(d7platforms_dir)/$*/lock.yml --context_type=platform
	drush @hostmaster hosting-import @platform_d7platforms_$*$(ds)$(inc)

