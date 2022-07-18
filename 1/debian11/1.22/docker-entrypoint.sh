#!/bin/bash
# Copyright 2015 The Kubernetes Authors.
# Copyright 2019 Google LLC
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

if [[ "${ENABLE_STUB_STATUS}" == "true" ]]; then
  declare -r stub_config="/etc/nginx/conf.d/stub.conf"

  mv -f /etc/nginx/stub.conf.template "${stub_config}"
  if [[ "${ENABLE_STUB_ALL_HOSTS}" == "true" ]]; then
    sed -i 's/127.0.0.1/0.0.0.0/g' "${stub_config}"
    sed -i '/deny all;/d' "${stub_config}"
  fi
fi

exec /usr/sbin/nginx -g "daemon off;"
