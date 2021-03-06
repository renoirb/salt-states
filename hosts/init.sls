{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') %}

/etc/hosts:
  file.managed:
    - source: salt://hosts/files/hosts.jinja
    - template: jinja
    - mode: 444
    - context:
        level: {{ salt['grains.get']('level', 'production') }}
        hostName: {{ salt['grains.get']('host', 'ubuntu') }}
        hosts_entries: {{ salt['pillar.get']('infra:hosts_entries', {}) }}
        hardcoded_entries: {{ salt['pillar.get']('infra:hardcoded_entries', {}) }}
        tld: {{ tld }}

