#!/bin/bash

TERRAGRUNT_SOURCE=${1:-"default-source"}
sed "s|\${TERRAGRUNT_SOURCE}|$TERRAGRUNT_SOURCE|" terragrunt.hcl.template > terragrunt.hcl

##terragrunt "$@"
