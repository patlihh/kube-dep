#!/bin/bash --login

# Copyright 2017 The Kubernetes Authors.
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

#set -o errexit
#set -o nounset
#set -o pipefail


set -e

rm -rf kubecfg.crt
rm -rf kubecfg.key
rm -rf kubecfg.p12

grep 'client-certificate-data' ~/.kube/config | head -n 1 | awk '{print $2}' | base64 -d >> kubecfg.crt
grep 'client-key-data' ~/.kube/config | head -n 1 | awk '{print $2}' | base64 -d >> kubecfg.key
#openssl pkcs12 -export -clcerts -inkey kubecfg.key -in kubecfg.crt -out kubecfg.p12 -name "kubernetes-client"
openssl pkcs12 -export -clcerts -inkey kubecfg.key -in kubecfg.crt -password pass:uni -out kubecfg.p12 -name "kubernetes-client"

echo "Genereated kubecfg certificates under $(pwd): "
ls -ltra kubecfg*

echo "Please install the kubecfg.p12 certificate in your browser, password is uni,and then restart browser."



