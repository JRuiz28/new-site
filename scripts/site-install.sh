#!/usr/bin/env bash
# Generate a new ramdom uuid the first time you create a project.
# You could use the `uuidgen` bash command to get new one!!.
SITE_UUID="712ca2d3-56a4-42f0-ab9d-6af46fd3eec9"
chirripo drush cc drush
echo "Installing the site..."
chirripo drush si -- bloom --account-pass=admin --site-name="New site" -y
echo "Setting the site uuid..."
chirripo drush config:set -- system.site uuid "$SITE_UUID" -y
if [ -f ./config/sync/core.extension.yml ]; then chirripo drush cim -- -y; chirripo drush cim -- -y; fi

# Change CUSTOMTHEME by your own theme folder.
if [ -f ./themes/custom/CUSTOMTHEME/package.json ]; then
  cd ./themes/custom/CUSTOMTHEME
  if [ ! -d ./node_modules ]; then npm install; fi
  npm run build
fi

echo "Cleaning cache..."
chirripo drush cr
