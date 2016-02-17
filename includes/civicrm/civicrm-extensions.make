core = 7.x
api = 2

defaults[libraries][download][type] = "git"
defaults[libraries][destination] = "modules/civicrm/extensions"
defaults[libraries][overwrite] = "1"

libraries[civicrm_activity_ical][download][url] = "git://git.drupal.org/project/civicrm_activity_ical.git"
libraries[civicrm_activity_ical][download][tag] = "7.x-1.1"

libraries[civisualize][download][url] = "https://github.com/agh1/civisualize.git"
libraries[civisualize][download][branch] = "member-viz"

libraries[clickatell_sms_provider][download][url] = "https://github.com/veda-consulting/org.civicrm.sms.clickatell.git"

libraries[event_calendar][download][url] = "https://github.com/osseed/com.osseed.eventcalendar.git"
libraries[event_calendar][download][tag] = "1.1"

libraries[mandrill_email][download][url] = "https://github.com/JMAConsulting/biz.jmaconsulting.mte.git"
libraries[mandrill_email][download][tag] = "v2.0"

libraries[reporterror][download][url] = "https://github.com/mlutfy/ca.bidon.reporterror.git"

libraries[twilio_sms][download][url] = "https://github.com/civicrm/org.civicrm.sms.twilio.git"

libraries[civicrm-metrics-server][download][url] = "https://github.com/ginkgostreet/civicrm-metrics-server"

libraries[civicrm-metrics-client][download][url] = "https://github.com/ginkgostreet/civicrm-metrics-client"

libraries[org.ndi.metrics][download][url] = "https://github.com/ginkgostreet/org.ndi.metrics"
