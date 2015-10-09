core = 7.x
api = 2

;****************************************
; CiviCRM core
;****************************************

; This "module" isn't hosted on drupal.org. Check for new updates at:
; http://sourceforge.net/projects/civicrm/files/civicrm-stable/

projects[civicrm][type] = "module"
projects[civicrm][subdir] = ""
projects[civicrm][download][type] = "get"
projects[civicrm][download][url] = "http://downloads.sourceforge.net/project/civicrm/civicrm-stable/4.6.8/civicrm-4.6.8-drupal.tar.gz"


;****************************************
; CiviCRM l10n -- most recent translations for use with gettext
;****************************************

libraries[civicrm_l10n_core][destination] = "modules"
libraries[civicrm_l10n_core][directory_name] = "civicrm/l10n"
libraries[civicrm_l10n_core][download][type] = "file"
libraries[civicrm_l10n_core][download][url] = "https://download.civicrm.org/civicrm-l10n-core/archives/civicrm-l10n-daily.tar.gz"
libraries[civicrm_l10n_core][overwrite] = TRUE

