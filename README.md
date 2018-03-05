# cassandra-aws-benchmark
Scripts and templates for cassandra benchmark environment provision

## Requirements
* aws cli: `pip install awscli --upgrade --user` and `aws configure`

## Create benchmark environment

create cloudformation stack:

```shell
aws cloudformation create-stack --stack-name MY_STACK_NAME \
    --disable-rollback \
    --template-body file://cloudformation.yaml \
    --parameters \
    ParameterKey=CassandraAMI,ParameterValue=MY_CASSANDRA_AMI_ID \
    ParameterKey=KeyName,ParameterValue=MY_SSH_KEY_NAME \
    ParameterKey=VPCSubnetId,ParameterValue=MY_VPC_SUBNET_ID \
    ParameterKey=InstanceProfile,ParameterValue=NAME_OF_INSTANCE_PROFILE_WITH_EC2_AND_AUOSCALEGROUP_READONLY_ACCESS \
    --capabilities CAPABILITY_IAM
```

update cloudformation stack:

```shell
aws cloudformation udpate-stack --stack-name MY_STACK_NAME \
    --template-body file://cloudformation.yaml \
    --parameters \
    ParameterKey=CassandraAMI,ParameterValue=MY_CASSANDRA_AMI_ID \
    ParameterKey=KeyName,ParameterValue=MY_SSH_KEY_NAME \
    ParameterKey=VPCSubnetId,ParameterValue=MY_VPC_SUBNET_ID \
    ParameterKey=InstanceProfile,ParameterValue=NAME_OF_INSTANCE_PROFILE_WITH_EC2_AND_AUOSCALEGROUP_READONLY_ACCESS \
    --capabilities CAPABILITY_IAM
```

## Lastest Prebuilt Cassandra AMI
* cassandra 3.0.15: ami-09cc7371 (us-west-2)
* rocksandra: ami-b770cdcf (us-west-2)


## Build Cassandra AMI Myself
prerequists:  packer: `brew install packer`

cassandra3x
```
$> cd ami/cassandra3x
$> wget -O resources/cassandra.rpm https://www.apache.org/dist/cassandra/redhat/30x/cassandra-3.0.15-1.noarch.rpm 
$> packer build -var "image_version=$(date +%s)" packer.json
```

ndbench
```
$> cd ami/bencher
$> packer build -var "image_version=$(date +%s)" packer.json
```

## License
Cassandra AWS Benchmark is Apache 2.0 licensed, as found in the LICENSE file.

