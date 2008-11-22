# Setup for Amazon Web Services
export EC2_HOME=$HOME/.ec2
export PATH=$PATH:$EC2_HOME/bin
export EC2_PRIVATE_KEY=`ls $HOME/.ec2/pk-*.pem`
export EC2_CERT=`ls $HOME/.ec2/cert-*.pem`
# AWS command line tools require Java
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/