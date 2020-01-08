#!/usr/bin/env bash
############################################################
# Variables
############################################################
ACTION=$@

if [[ -z $ACTION ]];
then
  echo `date`" - Missing mandatory arguments: ACTION. "
  exit 1
fi

WORKSPACES=(
  test2-group1-dev
  test2-group2-dev
  test2-group3-dev
)

############################################################
# Functions
############################################################
die () {
  echo >&2 "$@"
  exit 1
}

run_command() {
  local COMMAND=$1
  [ -n "$COMMAND" ] || die "=== FAILED: Missing argument for run_command()"

  echo "=== Executing: $COMMAND"
  $COMMAND
  [ "$?" -eq 0 ] || die "=== FAILED: $COMMAND"
}

############################################################
# Main
############################################################
run_command "terraform init"

for workspace in "${WORKSPACES[@]}"
do
  echo "============================================================"
  echo "=== START ACTION[$ACTION] on WORKSPACE[$workspace] ==="

  run_command "terraform workspace select $workspace"
  run_command "terraform $ACTION"

  echo "=== END ACTION[$ACTION] on WORKSPACE[$workspace] ==="
  echo "============================================================"
done
