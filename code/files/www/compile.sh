#!/bin/bash

# Managed by Salt stack. Do NOT EDIT directly!

#
# Compile the static site for publication
#

if [ ! -d "/srv/code/www/repo/.git" ]; then
  echo "This script cannot be run" 
  exit 1
fi

cd /srv/code/www/repo

if [ ! -d "../archives/" ]; then
  mkdir ../archives/
fi

compass compile -e production --force
node_modules/docpad/bin/docpad generate --env=production
node_modules/gulp/bin/gulp.js minify --env=production
tar cfj ../archives/package-$(date '+%Y%m%d%H%M').tar.bz2 out/
