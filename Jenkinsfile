pipeline {
    agent k8s
    stages{
        stage'Build'{
            steps{
                sh 'echo this is build'
            }
        }
        stage'Test'{
            steps{
                sh 'echo this is test'
            }
        }
        stage'pushToDockerImage'{
            steps{
                sh """ docker push 'dockerusername" "password" "url"
            }
        }
        stage'DeployToK8s'{
            steps{
               sh ' deploy to k8s from the docker hub image'
            }
        }
    }
}