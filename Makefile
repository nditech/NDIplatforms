cores = drupal7 drupal8
stock = dkan civicrm
demtools = demtools/dkan demtools/civicrm

include .mk/*

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
demtools/%-test: demtools/% init
	$(d) make demtools/$*.lock.yml $(test_dir)/demtools-dkan-$(ts)
demtools/%-platform: demtools/%
	$(d) $(make) demtools/$*.lock.yml $(pl)/demtools-$*-$(ds)$(inc)
	drush provision-save @platform_demtools$*$(ds)$(inc) --root=$(pl)/demtools-$*-$(ds)$(inc) --makefile=$(makes)/demtools/$*.lock.yml --context_type=platform
	drush @hostmaster hosting-import @platform_demtools$*$(ds)$(inc)

