# Aliases for getting around on a deployed production/staging Rails server.  

if [ -z "${PROJECT_NAME}" ]; then
	echo "You must define PROJECT_NAME in ~/.bash_profile for this to work."
fi

# TODO add support and autodetection for /data root, maybe the /u root, and allowing user to override the root
PROJECT_ROOT="/var/www/apps/${PROJECT_NAME}"
PROJECT_CURRENT="${PROJECT_ROOT}/current"
PROJECT_SHARED="${PROJECT_ROOT}/shared"

if [ -d "$PROJECT_CURRENT" ]; then
  alias current="cd ${PROJECT_CURRENT}"
  alias shared="cd ${PROJECT_SHARED}"
  alias logs="cd ${PROJECT_SHARED}/log"
  alias sc="cd ${PROJECT_CURRENT} && script/console"
else
  echo "$PROJECT_CURRENT doesn't exist - not creating handy deploy box aliases."
fi
