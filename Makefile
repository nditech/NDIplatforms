cores = drupal7 drupal8
stock = dkan civicrm
demtools = demtools/dkan demtools/civicrm

include .mk/*

all: cores stock demtools

cores: $(cores)
$(cores): %: $(cores_dir)/%.lock.yml
$(cores_dir)/%.lock.yml: $(cores_dir)/%.build.yml $(cores_dir)/%.make.yml
	$(d) $(lock) $< --result-file=$@

stock: $(stock)
$(stock): %: $(stock_dir)/%.lock.yml
$(stock_dir)/%.lock.yml: $(stock_dir)/%.build.yml $(cores_dir)/drupal7.lock.yml $(stock_dir)/%.make.yml
	$(d) $(lock) $< --result-file=$@

demtools: $(demtools)
$(demtools): %: $(makefile_dir)/%.lock.yml
$(demtools_dir)/%.lock.yml: $(demtools_dir)/%.build.yml $(stock_dir)/%.lock.yml $(demtools_dir)/%/*
	$(d) $(lock) $< --result-file=$@
$(demtools_dir)/%-test: $(demtools_dir)/% init
	$(d) make demtools/$*.lock.yml $(test_dir)/demtools-dkan-$(ts)
$(demtools_dir)/%-platform: $(demtools_dir)/%
	$(d) $(make) $(demtools_dir)/$*.lock.yml $(pl)/demtools-$*-$(ds)$(inc)
	drush provision-save @platform_demtools$*$(ds)$(inc) --root=$(pl)/demtools-$*-$(ds)$(inc) --makefile=$(makes)/$(demtools_dir)/$*.lock.yml --context_type=platform
	drush @hostmaster hosting-import @platform_demtools$*$(ds)$(inc)

