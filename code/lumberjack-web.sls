include:
  - code.prereq
  - rsync.secret

# @salt-master-dest
rsync-lumberjack-web:
  cmd.run:
    - name: "rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/bots/repo/web/ /srv/webplatform/lumberjack-web/"
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform/lumberjack-web
  file.directory:
    - name: /srv/webplatform/lumberjack-web
    - user: www-data
    - group: www-data
    - makedirs: True
    - file_mode: 644
    - dir_mode: 755
    - require:
      - file: webplatform-sources
    - recurse:
      - user
      - group
      - mode

/srv/webplatform/lumberjack-web/config.php:
  file:
    - managed
    - source: salt://bots/files/lumberjack_config.php.jinja
    - template: jinja
    - user: www-data
    - group: www-data
    - require:
      - cmd: rsync-lumberjack-web

