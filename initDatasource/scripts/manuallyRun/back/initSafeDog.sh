#!/bin/bash

setenforce 0

cd /workspace
tar -zxvf safedog_linux64.tar.gz -C /wsworkenv

cd /wsworkenv/safedog_an_linux64_2.8.16709
chmod +x *.py
./install.py

