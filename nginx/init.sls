{#
 # NGINX common states
 #
 # See also:
 #   - https://github.com/kevva/states/blob/master/nginx/
 #   - [Difference between NGINX versions](https://gist.github.com/jpetazzo/1152774)
 #   - [Strong SSL security on NGINX](https://raymii.org/s/tutorials/Strong_SSL_Security_On_nginx.html)
 #   - http://nginx.org/en/docs/http/ngx_http_core_module.html#variables
 #   - http://www.cyberciti.biz/faq/custom-nginx-maintenance-page-with-http503/
 #}
include:
  - mmonit

nginx:
  pkg.installed:
    - pkgs:
      - nginx-extras
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: nginx-superseeds-apache

/etc/nginx/sites-enabled/default:
  file.absent:
    - require:
      - pkg: nginx

nginx-superseeds-apache:
  pkg.purged:
    - pkgs:
      - apache2.2-bin
      - apache2.2-common
      - libapache2-mod-php5

/var/cache/nginx:
  file.directory:
    - user: www-data
    - group: www-data
    - makedirs: True
    - require:
      - pkg: nginx

nginx-ppa:
  pkgrepo.managed:
    - ppa: nginx/stable
    - require_in:
      - pkg: nginx


/etc/monit/conf.d/nginx.conf:
  file.managed:
    - source: salt://nginx/files/monit.conf.jinja
    - template: jinja
    - context:
        ip4_interfaces: {{ salt['grains.get']('ip4_interfaces:eth0') }}
    - require:
      - service: nginx
    - watch_in:
      - service: monit
