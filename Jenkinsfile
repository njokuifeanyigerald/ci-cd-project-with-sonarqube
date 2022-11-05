pipeline{
    agent{
        label "node"
    }
    stages{
        stage("Git checkout"){
            steps{
                echo "====++++executing checkout++++===="
                git 'https://github.com/njokuifeanyigerald/ci-cd-project-with-sonarqube.git'
            }
            post{
                always{
                    echo "====++++always++++===="
                }
                success{
                    echo "====++++succesfully checked out git repo++++===="
                }
                failure{
                    echo "====++++checkout execution failed++++===="
                }
        
            }
        }
    }
    post{
        always{
            echo "========always========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}