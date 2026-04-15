#!/bin/bash

nextdns stop
echo ""
protonvpn connect $@
echo ""
nextdns start
