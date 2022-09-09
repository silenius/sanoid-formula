{% from "sanoid/map.jinja" import sanoid with context %}

sanoid_cron:
  cron.present:
    {{ sanoid.cron|yaml }}
