#!/bin/bash

protonvpn connect $@
echo ""
nextdns restart
