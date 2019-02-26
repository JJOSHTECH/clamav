#!/bin/bash

# Update Antivirus Database
freshclam

# Start ClamAV
clamd --foreground=true
