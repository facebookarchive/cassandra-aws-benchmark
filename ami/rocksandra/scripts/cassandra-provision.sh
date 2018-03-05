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

# Install packages
sudo cp -r /home/ec2-user/resources/ /root/

sudo yum install -y epel-release
sudo yum update -y
sudo yum install -y wget
sudo yum remove -y java-1.7.0-openjdk
sudo yum install -y java-1.8.0-openjdk-devel
sudo yum install -y ntp
sudo yum install -y jna
sudo yum install -y jemalloc
sudo yum install -y sysstat
sudo yum install -y dstat
sudo yum install -y htop
sudo yum install -y xfsprogs
sudo yum install -y xfsdump


# Tune OS
## Remove constraint on processes
sudo rm -f /etc/security/limits.d/*-nproc.conf
## Copy our limits.conf
sudo cp ~/resources/limits.conf /etc/security/limits.conf
## Copy our sysctl.conf
sudo cp  ~/resources/sysctl.conf /etc/sysctl.conf
## Disable huge pages which can cause a CPU spike.
sudo cp ~/resources/initd-disable-transparent-hugepages /etc/init.d/disable-transparent-hugepages
sudo chmod 755 /etc/init.d/disable-transparent-hugepages

# Install Cassandra
sudo rpm -ivh ~/resources/rocksandra.rpm

# Cassandra configs
sudo cp ~/resources/etc/cassandra/default.conf/cassandra.yaml /etc/cassandra/default.conf/cassandra.yaml
sudo chmod 644 /etc/cassandra/default.conf/cassandra.yaml

sudo cp ~/resources/etc/cassandra/default.conf/jvm.options /etc/cassandra/default.conf/jvm.options
sudo chmod 644 /etc/cassandra/default.conf/jvm.options

sudo cp ~/resources/etc/cassandra/default.conf/logback.xml /etc/cassandra/default.conf/logback.xml
sudo chmod 644 /etc/cassandra/default.conf/logback.xml

