core = 7.x
api = 2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;       Core & CiviCRM & Custom    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

includes[] = ndi-custom.make

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      NDI Specific Extensions     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

includes[] = https://raw.githubusercontent.com/nditech/provision_ndi_legcase/7.x-3.x/legcase.make
includes[] = https://raw.githubusercontent.com/nditech/provision_ndi_civimp/7.x-3.x/civimp.make
includes[] = https://raw.githubusercontent.com/nditech/provision_ndi_civiparty/7.x-3.x/civiparty.make
