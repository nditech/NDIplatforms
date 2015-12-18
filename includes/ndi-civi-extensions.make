core = 7.x
api = 2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      NDI Specific Extensions     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

defaults[libraries][download][type] = "git"
defaults[libraries][destination] = "modules/civicrm/extensions"
defaults[libraries][overwrite] = 1

libraries[ukrainerayons][download][type] = "git"
libraries[ukrainerayons][download][url] = "https://github.com/nditech/ukrainerayons.git"
libraries[ukrainerayons][destination] = "modules/civicrm/extensions"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      NDI Custom Components       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

includes[] = https://raw.githubusercontent.com/nditech/provision_ndi_legcase/7.x-3.x/legcase.make

includes[] = https://raw.githubusercontent.com/nditech/provision_ndi_civimp/7.x-3.x/civimp.make

includes[] = https://raw.githubusercontent.com/nditech/provision_ndi_civiparty/7.x-3.x/civiparty.make

includes[] = https://raw.githubusercontent.com/nditech/hosting_ndi/7.x-1.x/drush/makefiles/ndi.make

