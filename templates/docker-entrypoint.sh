#!/bin/bash
# Copyright 2015 The Kubernetes Authors.
# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

tries=5

/usr/sbin/nginx -g "daemon on;"
set +e
while [[ $tries -gt 0 ]]; do
    wget -q -O /dev/null http://localhost
    if [[ $? -ne 0 ]]; then
        sleep 1
        tries=$((tries-1))
    else
        break
    fi
done
set -e

/usr/local/bin/nginx-prometheus-exporter

exec "$@"
