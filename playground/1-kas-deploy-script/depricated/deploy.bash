#!/bin/bash

# Load environment variables from .env file
CURR_DIR="$(realpath $(dirname ${BASH_SOURCE[0]}))"

sudo systemctl stop method_crm_server.service
sudo systemctl stop method_crm_server_tunnel.service

$CURR_DIR/copy_service.bash $CURR_DIR/services/method_crm_server.service
$CURR_DIR/copy_service.bash $CURR_DIR/services/method_crm_server_tunnel.service

sudo systemctl daemon-reload

sudo systemctl start method_crm_server.service
sudo systemctl start method_crm_server_tunnel.service

sudo systemctl enable method_crm_server.service
sudo systemctl enable method_crm_server_tunnel.service

echo "Done"