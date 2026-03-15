#!/usr/bin/env bash
set -euo pipefail

readonly tag="${GITHUB_REF##*/}"
readonly version="${tag#v}"

curl \
    --show-error --fail -i \
    "${GITHUB_API_URL}/repos/Kapeli/Dash-User-Contributions/pulls" \
    -XPOST \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: token ${CI_USER_ACCESS_TOKEN}" \
    -H "Content-Type: application/json" \
    -d "
        {
            \"title\": \"Terraform $version\",
            \"head\": \"${CI_USER_USERNAME}:terraform-$tag\",
            \"base\": \"master\",
            \"body\": \"This is an automated PR. Please report issues to https://github.com/${CI_USER_USERNAME}/dash-docset-terraform.\"
        }
    "
