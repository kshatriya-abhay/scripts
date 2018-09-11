echo "Mini script to start/restart proxy"
echo "Stopping squid"
sudo service squid stop
echo "Restarting NetworkManager"
sudo service NetworkManager restart
echo "Starting Squid"
sudo service squid start
echo "Done. Proxy has been started."
echo "List of allowed IPs:"
echo "$(cat /etc/squid/squid.conf | grep acl\ allowed_ips\ src | cut -d' ' -f4-)"
