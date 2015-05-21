{%- set dir = '/srv/webapps/etherpad' -%}
{%- set salt_master_ip = salt['pillar.get']('infra:hosts_entries:salt') -%}
{%- set upstream_port = salt['pillar.get']('upstream:etherpad:port', 8006) -%}
{%- set db_host   = salt['pillar.get']('infra:db_servers:mysql:masterdb', '127.0.0.1') -%}
{%- set etherpad_admin_password = salt['pillar.get']('accounts:etherpad:admin_password') %}
{%- set db = salt['pillar.get']('accounts:etherpad:db') %}

{{ dir }}/log:
  file.directory:
    - makedirs: True
    - user: webapps
    - group: webapps
    - recurse:
      - user
      - group

{{ dir }}/build:
  file.directory:
    - makedirs: True
    - user: webapps
    - group: webapps

{{ dir }}/docker-compose.yml:
  file.managed:
    - source: salt://code/files/etherpad/docker-compose.yml.jinja
    - template: jinja
    - user: webapps
    - group: webapps
    - mode: 644
    - context:
        upstream_port: {{ upstream_port }}
        salt_master_ip: {{ salt_master_ip }}

{{ dir }}/Dockerfile:
  file.managed:
    - source: salt://code/files/etherpad/Dockerfile
    - user: webapps
    - group: webapps

{{ dir }}/build/package.json:
  file.managed:
    - source: salt://code/files/etherpad/package.json
    - user: webapps
    - group: webapps

{{ dir }}/build/settings.json:
  file.managed:
    - source: salt://code/files/etherpad/settings.json.jinja
    - template: jinja
    - user: webapps
    - group: webapps
    - mode: 644
    - context:
        db: {{ db }}
        admin_password: {{ etherpad_admin_password }}
        db_host: {{ db_host }}

