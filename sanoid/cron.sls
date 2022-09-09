{% from "sanoid/map.jinja" import sanoid with context %}

sanoid_cron:
  cron.present:
    {% for key, value in sanoid.cron.items() %}
    - {{ key }}: {{ value }}
    {% endfor %}
