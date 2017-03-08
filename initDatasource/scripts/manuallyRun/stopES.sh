#!/bin/bash
kill -9 $(ps -elf | grep elasticsearch | grep -v grep | awk '{print $4}')

