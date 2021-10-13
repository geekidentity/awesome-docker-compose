#!/usr/bin/env bash
# 解决ES 报错 "max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]"
sudo sysctl -w vm.max_map_count=262144