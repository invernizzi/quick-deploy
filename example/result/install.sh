#!/bin/bash

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
match=$(grep --text --line-number "^DATA:$" $0 | cut -d : -f 1)
payload_start=$((match + 1))
tail -n +$payload_start $0 | uudecode | tar xzf - -C ${TARGET_DIR}
say "Running installer."
##############################################################################
# Installer.


sudo apt-get -y install htop

echo "I'm a demo installer running"
exit 0
DATA:
begin 664 -
M'XL(`+=5UE4``^W2L0K",!#&\<P^Q3FY22.7^`KZ&!DB1-(HM4KITQOITJ'@
M5$3X_Y8/[FXXCHM#:.\Y[ONA-VMI*N_UD_;HFGE.U!I[<-ZI>JNU;E6=-]*L
MMM',\]&'3L2D\HI=2>.8EN>^]?_4*>9\V\IYU\JUGD)"D3B]A%Q2_8O-KQ<$
8`````````````````"QZ`SN5.S(`*```
`
end
