# Command to add guest user with no password.
# A user doesnt have sudo rights by default (isnt added in sudoers)so don't worry.
sudo useradd -d /tmp/guest -p $(openssl passwd "") guest

# We need 2 scripts, one to setup the user and another to remove the guest directory after logout.

# Script 1 - To create the guest folder again, since we're deleting it after every logout.

echo "#!/bin/sh" >> guest.tmp
echo "guestuser=\"guest\"" >> guest.tmp
echo "if [[ \"\$USER\" = \"\$guestuser\" ]]; then" >> guest.tmp
echo -e "\tmkdir /tmp/\"\$guestuser\"" >> guest.tmp
echo -e "\tcp /etc/skel.* /tmp/\"\$guestuser\"" >> guest.tmp
echo -e "\tchown -R \"\$guestuser\":\"\$guestuser\" /tmp/\"\$guestuser\"" >> guest.tmp
echo "fi" >> guest.tmp
echo "exit 0" >> guest.tmp

sudo cp guest.tmp /etc/gdm3/PostLogin/Default
rm guest.tmp

# Script 2 - To remove guest directory.

echo "#!/bin/sh" >> guest.tmp
echo "guestuser=\"guest\"" >> guest.tmp
echo "if [[ \"\$USER\" = \"\$guestuser\" ]]; then" >> guest.tmp
echo -e "\trm -rf /tmp/\"\$guestuser\"" >> guest.tmp
echo "fi" >> guest.tmp
echo "exit 0" >> guest.tmp

sudo rm /etc/gdm3/PostSession/Default
sudo cp guest.tmp /etc/gdm3/PostSession/Default
rm guest.tmp

# Give permissions to execute
sudo chmod 755 /etc/gdm3/PostLogin/Default
sudo chmod 755 /etc/gdm3/PostSession/Default
