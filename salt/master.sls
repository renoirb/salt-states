{%- set users = salt['pillar.get']('users', {}) -%}
{%- set level = salt['grains.get']('level', 'production') -%}
{%- set salt_master_ip = salt['pillar.get']('infra:hosts_entries:salt') -%}
{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') %}

include:
  - salt
  - users
  - mmonit
  - webplatform

/srv/opsconfigs/userdata.txt:
  file.managed:
    - source: salt://salt/files/userdata.txt.jinja
    - template: jinja
    - context:
        level: {{ level }}
{% if level == 'production' %}
        base64_yaml_level_line: bGV2ZWw6IHByb2R1Y3Rpb24=
{% else %}
        base64_yaml_level_line: bGV2ZWw6IHN0YWdpbmc=
{% endif %}
        salt_master_ip: {{ salt_master_ip }}
        # CANNOT set salt_master_ip to create new salt master
        # Looking if it works well to specify future salt master IP, before creation #TODO
        # #CHANGE_SALT_MASTER

/etc/profile.d/nova.sh:
  file.managed:
    - user: root
    - group: deployment
    - mode: 750
    - template: jinja
    - source: salt://webplatform/files/profile-nova.sh.jinja

{% for username in users %}
/home/{{ username }}/.my.cnf:
  file.managed:
    - source: salt://environment/files/my.cnf.jinja
    - user: {{ username }}
    - group: {{ username }}
    - mode: 640
    - template: jinja
    - require:
      - user: {{ username }}
{% endfor %}

vim-syntax-pkgs:
  pkg.installed:
    - pkgs:
      - vim-syntax-docker
      - vim-syntax-go
    - require:
      - pkg: vim-pkgs

## SecurityGroup port: TCP 4505 4506 @salt
salt-master-deps:
  pkg.installed:
    - pkgs:
      - python-dulwich
      - python-novaclient
      - python-neutronclient
      - python-libcloud
      - python-cffi
      - salt-cloud
      - salt-api
      - salt-master
      - jq
      - swaks
      - gnutls-bin

# ref: http://hardenubuntu.com/software/install-fail2ban
setup-fail2ban:
  pkg.installed:
    - name: fail2ban
  file.managed:
    - source: salt://salt/files/fail2ban.conf
    - name: /etc/fail2ban/jail.local


#/usr/local/bin/wpd-deploy:
#  file.managed:
#    - user: root
#    - group: root
#    - source: salt://salt/files/wpd-deploy
#    - mode: 755

/etc/ssh/sshd_config:
  file.append:
    - text: Banner /etc/issue.net

/etc/issue.net:
  file.managed:
    - source: salt://salt/files/banner.txt.jinja
    - template: jinja
    - context:
        level: {{ level }}
        tld: {{ tld }}

/etc/salt/master.d/reactor.conf:
  file.managed:
    - source: salt://salt/files/reactor.conf

/etc/salt/master.d/roots.conf:
  file.managed:
    - source: salt://salt/files/roots.conf

/etc/salt/master.d/runners.conf:
  file.managed:
    - source: salt://salt/files/runners.conf

/etc/salt/master.d/peers.conf:
  file.managed:
    - source: salt://salt/files/peers.conf.jinja
    - template: jinja

/etc/salt/master.d/gitfs.conf:
  file.managed:
    - source: salt://salt/files/gitfs.conf

/etc/salt/master.d/overrides.conf:
  file.managed:
    - source: salt://salt/files/master-overrides.conf

/etc/monit/conf.d/salt-master.conf:
  file.managed:
    - source: salt://salt/files/monit.conf
    - watch_in:
      - service: monit
