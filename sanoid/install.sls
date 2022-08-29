{% from "sanoid/map.jinja" import sanoid with context %}

sanoid_pkg:
  pkg.installed:
    - name: sanoid
