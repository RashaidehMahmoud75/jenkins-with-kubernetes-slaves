# Set variables from variables.sh script
source ./scripts/variables.sh

# Delete the cluster
${GOPATH}/bin/kops delete cluster ${DOMAIN_NAME} --yes

# Delete the persistent volume for Jenkins
export JENKINS_KUBERNETES_VOLUME=$(aws ec2 describe-volumes --region ${AWS_REGION} --filters Name=tag-key,Values="Name" Name=tag-value,Values="jenkins-kubernetes-volume" --output text --query 'Volumes[*].VolumeId')
aws ec2 delete-volume --region ${AWS_REGION} --volume-id $JENKINS_KUBERNETES_VOLUME

# Delete the S3 bucket
aws s3api delete-bucket --region ${AWS_REGION} --bucket ${DOMAIN_NAME}