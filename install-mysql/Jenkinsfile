pipeline {
    agent any
    environment {
        EC2_IP ="12.110.0.10" 
    }
    stages{
        stage ('install mysql'){
            steps{
                sshagent(credentials : ['ec2-ssh-key']){
                    sh """
                    ssh -o StrictHostKeyChecking=no ec2-user@${EC2_IP} << EOF
                    sudo yum update -y
                    sudo yum install mysql-server -y
                    sudo systemctl start mysqld
                    sudo systemctl enable mysqld
                    sudo systemctl status mysqld
                EOF
                """
                }
            }
        }
    }
}