#!/bin/bash

# Update Antivirus Database
freshclam

# Start ClamAV
COMMAND="clamd --foreground=true"
