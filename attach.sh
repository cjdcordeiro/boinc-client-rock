#!/bin/bash -ex

sleep 3
boinccmd --get_host_info

set +x
boinccmd --acct_mgr attach $ACCOUNT_MANAGER_URL $USERNAME $PASSWORD --set_run_mode always
set -x

boinccmd --acct_mgr info | grep http
