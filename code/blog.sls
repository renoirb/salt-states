## deployment of the blog has been disabled

## Include the common settings for the docs repo
#include:
#  - rsync.secret
#  - code.prereq
#
#rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@deployment.webplatform.org::code/blog/ /srv/webplatform/blog/:
#  cmd.run:
#    - user: root
#    - group: root
#    - require:
#      - file: /etc/codesync.secret
#      - file: /srv/webplatform