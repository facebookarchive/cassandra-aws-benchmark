#!/bin/bash
#
# Copyright 2018-present, Facebook, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
set -e -x

sudo yum install -y epel-release
sudo yum update -y

sudo yum remove -y java-1.7.0-openjdk
sudo yum install -y java-1.8.0-openjdk-devel
sudo yum install -y tomcat8
sudo yum install -y ntp
sudo yum install -y git-core


# build and install ndbench

## setup log dir
sudo mkdir /var/log/ndbench
sudo chown tomcat:tomcat /var/log/ndbench


## checkout code
cd ~
git clone https://github.com/wpc/ndbench.git
cd ndbench

## config logging with fix size rotations otherwise ndbench log will fill up disks fairly quick
cp ~/resources/ndbench/log4j.properties ndbench-web/src/main/resources/
cp ~/resources/ndbench/Log4jInit.java ndbench-web/src/main/java/com/netflix/ndbench/defaultimpl/Log4jInit.java
cp ~/resources/ndbench/web.xml ndbench-web/src/main/webapp/WEB-INF/web.xml


## build and deploy to tomcat8
./gradlew clean build
sudo cp ./ndbench-web/build/libs/ndbench-web-0.4.0-SNAPSHOT.war /var/lib/tomcat8/webapps/ROOT.war

