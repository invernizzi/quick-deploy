#!/bin/bash

HEADER='#!/bin/bash

TARGET_DIR="."

##############################################################################
# Installer header.

function say {
  # write in green, so it is noticeable
  tput setaf 2
  echo $@
  tput sgr0
}
# Update apt cache, if it has not been updated in a while
if [ "$[$(date +%s) - $(stat -c %Z /var/lib/apt/periodic/update-success-stamp)]" -ge $((24*60*60)) ]; then
  say "Apt cache is outdated. Updating - I will need sudo."
  sudo apt-get update
fi
# Install all necessary libraries
say "Installing dependencies. I will need sudo."
sudo apt-get install -y sharutils
say "Uncompressing payload."
# Decompressing
match=$(grep --text --line-number "^DATA:$" $0 | cut -d ':' -f 1)
payload_start=$((match + 1))
tail -n +$payload_start $0 | uudecode | tar xzf - -C ${TARGET_DIR}
say "Running installer."
##############################################################################
# Installer.

'

SOURCE_DIR=${1-'.'}
INSTALLER_PATH=${2-'install.sh'}
shopt -s extglob
shopt -s dotglob
echo "I'm creating an installer ($INSTALLER_PATH) for the files in directory $SOURCE_DIR"
(
    pushd ${SOURCE_DIR} > /dev/null;
    echo "$HEADER";
    cat install.sh.in;
    echo 'exit 0';
    echo "DATA:";
    tar czf - !(install.sh.in) | uuencode -
) > ${INSTALLER_PATH}
chmod +x ${INSTALLER_PATH}
echo "Done."

