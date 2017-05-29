d=$(tmp_dir)/drush
drush_dir=$(tmp_dir)/drush-source
branch=dev/2000
lock=make-lock
make=make
pl=/var/aegir/platforms
makes=~/makefiles/NDIplatforms
makefile_dir=makefiles
cores_dir=$(makefile_dir)/cores
stock_dir=$(makefile_dir)/stock
demtools_dir=$(makefile_dir)/demtools
d7platforms_dir=$(makefile_dir)/d7platforms

clean-drush:
	@rm -f $(d)

drush: init clean-drush
	@curl -SsL -z $(d) -o $(d) http://files.drush.org/drush.phar
	@chmod a+x $(d)
	@$(d) --version

drush-unstable: init clean-drush
	@curl -SsL -z $(d) -o $(d) http://files.drush.org/drush-unstable.phar
	@chmod a+x $(d)
	@$(d) --version

drush-source: init clean-drush
	@if ! [ -d $(drush_dir) ]; then git clone https://github.com/drush-ops/drush.git $(drush_dir); fi
	@cd $(drush_dir); git checkout $(branch)
	@cd $(drush_dir); curl -SsL -z ./composer.phar https://getcomposer.org/installer | php
	@chmod a+x $(drush_dir)/composer.phar
	@cd $(drush_dir); ./composer.phar install --prefer-source
	@ln -s drush-source/drush $(d)
	@chmod a+x $(d)
	@$(d) --version
	@echo " Drush git branch:" `cd tmp/drush-source/; git rev-parse --abbrev-ref HEAD`

