{% from "sanoid/map.jinja" import sanoid with context %}

include:
  - sanoid.install

sanoid_delete_tabs:
  file.replace:
    - name: {{ sanoid.conf_file }}
    - pattern: ^\t
    - repl: ''
    - require:
      - pkg: sanoid

{% if sanoid.sections_absent is defined %}
sanoid_sections_absent:
  ini.sections_absent:
    - name: {{ sanoid.conf_file }}
    - sections: 
        {% for dataset in sanoid.sections_absent %}
        - {{ dataset }}
        {% endfor %}
{% endif %}

sanoid_options_present:
  ini.options_present:
    - name: {{ sanoid.conf_file }}
    - strict: True
    - sections:
        {% for dataset, properties in sanoid.get('datasets', {}).items() %}
        {{ dataset }}:
          {{ properties|yaml }}
        {% endfor %}
    - require:
      - file: sanoid_delete_tabs
