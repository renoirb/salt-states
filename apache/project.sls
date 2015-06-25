{%- set upstream_port = salt['pillar.get']('upstream:buggenie:port', 8006) %}

include:
  - apache
  - php

{% from "apache/module.sls" import a2mod %}
{{ a2mod('rewrite') }}
{{ a2mod('ssl') }}

extend:
  apache2:
    service:
      - watch:
        - cmd: a2enmod rewrite

a2dismod mpm_event:
  cmd.run

a2enmod mpm_prefork:
  cmd.run:
    - require:
      - cmd: a2dismod mpm_event
    - require_in:
      - cmd: a2enmod rewrite

buggenie-requirements:
  pkg.installed:
    - pkgs:
      - php5-sqlite

/etc/apache2/sites-available/project.conf:
  file.managed:
    - source: salt://apache/project
    - template: jinja
    - user: root
    - group: root
    - mode: 444
    - context:
        upstream_port: {{ upstream_port }}
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/03-project.conf:
  file.symlink:
    - target: /etc/apache2/sites-available/project.conf
    - require:
      - file: /etc/apache2/sites-available/project.conf
    - watch_in:
      - service: apache2

/etc/apache2/mods-enabled/ssl.load:
  file:
    - exists
