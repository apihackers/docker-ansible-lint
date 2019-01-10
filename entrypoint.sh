#!/bin/ash -e

if [[ ! -z "${CI_JOB_ID}" ]]; then
    ansible-lint "$@"
else
    # We are in a CI pipeline
    # Just spawn a shell for compatibility
    /bin/ash
fi
