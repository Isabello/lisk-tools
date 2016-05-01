#!/bin/bash

#Basic script for checking blockheight against master peer nodes

echo "Localhost"
curl http://localhost:7000/api/loader/status/sync
echo ""
echo "Peer 1"
curl http://13.91.61.2:7000/api/loader/status/sync
echo ""
echo "Peer 2"
curl http://13.82.31.30:7000/api/loader/status/sync
echo ""
echo "Peer 3"
curl http://52.165.40.188:7000/api/loader/status/sync
echo ""
echo "Peer 4"
curl http://40.68.34.176:7000/api/loader/status/sync
echo ""
echo "Peer 5"
curl http://13.69.159.242:7000/api/loader/status/sync
echo ""
