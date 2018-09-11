echo "Stopping squid proxy"
sudo service squid stop
echo "Restarting NetworkManager"
sudo service NetworkManager restart
echo "Done. Proxy stopped"
