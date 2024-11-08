#!/bin/bash
set -eu

k8s_status() {
  
  K8S_STATUS=$(kubectl config current-context | cut -d "/" -f 2 | cut -d "-" -f 2,6,7)

  echo "#[bg=green] ♟️ [$K8S_STATUS] "
}

k8s_status "$1"
