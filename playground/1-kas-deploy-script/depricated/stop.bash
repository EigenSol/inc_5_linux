#!/bin/bash

sudo systemctl stop method_crm_server.service
sudo systemctl disable method_crm_server.service

# sudo systemctl stop method_crm_server.service
# sudo systemctl disable method_crm_server.service

echo "Done"