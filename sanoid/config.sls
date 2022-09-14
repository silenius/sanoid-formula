{% from "sanoid/map.jinja" import sanoid with context %}

include:
  - sanoid.install

sanoid_conf:
  file.managed:
    - name: {{ sanoid.conf_file }}
    - user: root
    - group: wheel
    - mode: 640
    - contents: |
        {% for section, props in sanoid.sections|dictsort %}
        [{{ section }}]
        {% for k,v in props|dictsort %}
        {{ k }} = {{ v }}
        {% endfor %}
        {% endfor %}
    - require:
      - pkg: sanoid

{% for d in ('cache-dir', 'run-dir') %}

sanoid_dir_{{ d }}:
  file.directory:
    - name: {{ sanoid[d] }}
    - user: root
    - group: {{ sanoid.group }}
    - mode: 770
    - require:
      - pkg: sanoid

{% endfor %}
