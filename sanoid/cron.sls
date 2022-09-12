{% from "sanoid/map.jinja" import sanoid with context %}

{% for identifier, props in sanoid.cron.items() %}

sanoid_cron_{{ identifier }}:
  cron.present:
    {% for k,v in props.items() %}
    - {{ k }}: {{ v }}
    {% endfor %}

{% endfor %}
