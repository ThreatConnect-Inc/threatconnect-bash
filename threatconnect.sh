#/bin/sh -u

# =============================================================================
# Copyright 2015 ThreatConnect, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# =============================================================================

# Version - 0.1

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/config.sh
source $DIR/functions.sh

# function payload {
#     read -p "Add Payload ($(default y)/n): " rerun
#     rerun=${rerun:-Y}
#     rerun=$(format_response_upper $rerun)
        
#     if [[ $rerun == "Y" ]]; then
#       payload
#     fi
# }

# Defaults
API_METHOD_DEFAULT="GET"
API_URI_DEFAULT="/v2/owners"
# API_URI_DEFAULT="/v2/indicators/addresses"
CONTENT_TYPE="application/json"

read -p "API URI: $(default ${API_URI_DEFAULT}): " API_URI
API_URI=${API_URI:-${API_URI_DEFAULT}}
API_URI=$(format_response $API_URI)

read -p "HTTP Method ($(default ${API_METHOD_DEFAULT})|POST|PUT|DELETE): " API_METHOD
API_METHOD=${API_METHOD:-${API_METHOD_DEFAULT}}
API_METHOD=$(format_response $API_METHOD)

read -p "Owner $(default ${DEFAULT_OWNER}): " OWNER
OWNER=${OWNEr:-${DEFAULT_OWNER}}
OWNER=$(format_response $OWNER)

if [ $API_METHOD == "POST" ] || [ $API_METHOD == "PUT" ];
then
    read -p "Body: " BODY
    BODY=$(format_json $BODY)
fi

API_PAYLOAD="?owner=${OWNER}"

# GET URL and PATH
API_URL=${API_HOST}${API_URI}${API_PAYLOAD}
API_PATH="/$(echo ${API_URL} | grep / | cut -d/ -f4-)"

# Generate HMAC Auth
TIMESTAMP=`date +%s`
signature="${API_PATH}:${API_METHOD}:${TIMESTAMP}"
hmac_signature=$(echo -n ${signature} | openssl dgst -binary -sha256 -hmac ${API_SECRET} | base64)
authorization="TC ${API_ID}:${hmac_signature}"

# DEBUG
# echo "METHOD: ${API_METHOD}"
# echo "API_PATH: ${API_PATH}"
# echo "TIMESTAMP: ${TIMESTAMP}"
# echo "signature: ${signature}"
# echo "hmac_signature: ${hmac_signature}"
# echo "authorization: ${authorization}"
# echo "API URL: ${API_URL}"
# echo "BODY: ${BODY}"

if [ $API_METHOD == "GET" ];
then
    curl_cmd="curl -s -i -H \"Timestamp: ${TIMESTAMP}\" -H \"Authorization: ${authorization}\" -X ${API_METHOD} ${API_URL}"
else
    curl_cmd="curl -s -i -H \"Timestamp: ${TIMESTAMP}\" -H \"Authorization: ${authorization}\" -H \"Content-Type: ${CONTENT_TYPE}\" -d \"${BODY}\" -X ${API_METHOD} ${API_URL}"
fi

#
# run curl command
#
eval $curl_cmd
# echo $curl_cmd