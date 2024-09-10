#!/bin/bash

# Copyright 1999-2024 Alibaba Group Holding Ltd.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -x

#===========================================================================================
# Configuration
#===========================================================================================

export NACOS_START_MODE=cluster
export SERVER="/opt/nacos/console/target/nacos-server"
export BASE_DIR="/home/nacos"
export CUSTOM_SEARCH_LOCATIONS="file:${BASE_DIR}/conf/"

APP_OPT="${APP_OPT} -Dnacos.home=${BASE_DIR}"
APP_OPT="${APP_OPT} -Dnacos.member.list=${MEMBER_LIST}"
APP_OPT="${APP_OPT} --logging.config=${BASE_DIR}/conf/nacos-logback.xml"
APP_OPT="${APP_OPT} --spring.config.additional-location=${CUSTOM_SEARCH_LOCATIONS}"

if [[ "${NACOS_START_MODE}" == "standalone" ]]; then
  APP_OPT="${APP_OPT} -Dnacos.standalone=true"
fi

if [[ ! -z "${NACOS_AUTH_ENABLE}" ]]; then
  APP_OPT="${APP_OPT} -Dnacos.core.auth.enabled=${NACOS_AUTH_ENABLE}"
fi

if [[ "${PREFER_HOST_MODE}" == "hostname" ]]; then
  APP_OPT="${APP_OPT} -Dnacos.preferHostnameOverIp=true"
fi

# Start the application
echo "Nacos native is now starting with ${NACOS_START_MODE} mode"
echo ${SERVER} ${APP_OPT}
