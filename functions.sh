#/bin/sh -u

# =============================================================================
# Copyright 20@5 ThreatConnect, Inc.
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

#
# format response upper
#
function format_response_upper() {
  echo "$@" | tr -d '\n' | tr '[a-z]' '[A-Z]'
}

#
# format_json
#
function format_json() {
  echo -e $@ | sed 's/"/\\"/g'
}

#
# format_response
#
function format_response() {
  echo "$@" | tr -d '\n'
}

#
# complete
#
function complete {
  echo -en "\b\b\b- $(tput setaf 2)Complete$(tput sgr0)\n"
}

#
# failed
#
function failed {
  echo -en "\b\b\b- $(tput setaf 1)Failed$(tput sgr0)\n"
}

#
# bold
#
function bold() {
  echo "[$(tput bold)${1}$(tput sgr0)]"
}

#
# default
#
function default() {
  echo "[$(tput bold)$(tput setaf 5)${@}$(tput sgr0)]"
}
