include:
  - php.composer

php-basic-deps:
  pkg.installed:
    - pkgs:
      - php5-common
      - php5-intl
      - libpcre3-dev
      - php5-dev
      - php5-cli
      - php5-redis
      - php-wikidiff2

php5-memcached:
  pkg.installed:
    - require:
      - pkg: php-basic-deps

php-pear:
  pkg.installed:
    - require:
      - pkg: php-basic-deps

# ref: http://pear.php.net/manual/en/guide.users.commandline.installing.php
igbinary:
  pecl.installed:
    - version: 1.2.1
    - require:
      - pkg: php-pear
  file.managed:
    - name: /etc/php5/mods-available/igbinary.ini
    - source: salt://php/files/igbinary.ini
  cmd.run:
    - name: php5enmod igbinary
    - unless: test -f /etc/php5/apache2/conf.d/20-igbinary.ini

apcu:
  pecl.installed:
    - version: 4.0.4
    - require:
      - pkg: php-pear
  file.managed:
    - name: /etc/php5/mods-available/apcu.ini
    - source: salt://php/files/apc.ini
    - user: root
    - group: root
    - mode: 644
    - require:
      - pecl: igbinary
  cmd.run:
    - name: php5enmod apcu
    - unless: test -f /etc/php5/apache2/conf.d/20-apcu.ini

/etc/php5/mods-available/memcached.ini:
  file.managed:
    - source: salt://php/files/memcached.ini
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - require:
      - pkg: php5-memcached
