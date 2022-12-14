{% from "sanoid/map.jinja" import sanoid with context %}

{% for lock, lock_file in sanoid.locks.items() %}

sanoid_lock_{{ lock }}:
  file.managed:
    - name: {{ lock_file }}
    - user: {{ sanoid.cron[lock].user }}
    - mode: 700

{% endfor %}

{% for identifier, props in sanoid.cron.items() %}

{% if props.get('present', True) %}

sanoid_cron_{{ identifier }}:
  cron.present:
    {% for k,v in props.items() %}
    - {{ k }}: {{ v }}
    {% endfor %}

{% else %}

sanoid_cron_{{ identifier }}:
  cron.absent:
    - name: {{ props.name }}
    - identifier: {{ props.identifier }}
    - user: {{ props.user }}

{% endif %}

{% endfor %}
