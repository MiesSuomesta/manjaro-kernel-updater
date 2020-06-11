#!/bin/sh

sudo cp refresh-network.{service,target} /usr/lib/systemd/system/
sudo cp *.sh /usr/local/bin/

sudo systemctl enable refresh-network 
sudo systemctl enable refresh-network.target 
sudo systemctl enable refresh-network.service
sudo systemctl restart refresh-network 

echo systemd installation done
