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
;;            Dkan core             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

includes[] = ../includes/dkan.make

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;          Dkan Extensions         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

includes[] = ../includes/dkan-extensions.make