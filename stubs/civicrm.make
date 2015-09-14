core = 7.x
api = 2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               Core               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

includes[] = ../includes/core.make

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;             Defaults             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Specify common subdir
defaults[projects][subdir] = "contrib"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;         Released Modules         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

includes[] = ../includes/modules.make

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           CiviCRM core           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

includes[] = ../includes/civicrm.make

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        CiviCRM Extensions        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

includes[] = ../includes/civicrm-extensions.make
