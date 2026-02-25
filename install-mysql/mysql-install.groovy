pipeline {
    agent {
        label 'my-defined-label'
    }
    parameters {
        string(name: 'PERSON', defaultValue: 'Mr Shashi', description: 'This is your first jenkins job ?')

        text(name: 'BIOGRAPHY', defaultValue: '', description: 'Enter some information about the person')

        booleanParam(name: 'TOGGLE', defaultValue: true, description: 'Toggle this value')

        choice(name: 'CHOICE', choices: ['One', 'Two', 'Three'], description: 'Pick something')

        password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password')
    }
    options {
                // Timeout counter starts BEFORE agent is allocated
                timeout(time:  10, unit: 'SECONDS')
            }
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
                sleep(5)
                }
            }
            steps{
                echo "Hello ${params.PERSON}"

                echo "Biography: ${params.BIOGRAPHY}"

                echo "Toggle: ${params.TOGGLE}"

                echo "Choice: ${params.CHOICE}"

                echo "Password: ${params.PASSWORD}"
            }
            }
        }
    }
