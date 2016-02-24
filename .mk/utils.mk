tmp_dir=tmp
test_dir=$(tmp_dir)/tests
ts=`date --iso-8601=seconds`
ds=`date +%Y%m%d`

install: drush-source mkdocs

init:
	@mkdir -p $(tmp_dir)
	@mkdir -p $(test_dir)

list:
	@echo "The following targets are available:"
	@$(MAKE) -pq -f Makefile : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'| sed 's/^/  /' --

clean:
	@rm -rf $(tmp_dir)

clean-tests:
	@rm -rf $(test_dir)

