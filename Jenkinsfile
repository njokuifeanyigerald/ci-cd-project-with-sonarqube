pipeline{
    agent any
    stages{        stage("Git checkout"){
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
        stage("UNIT Testing"){
            steps{
                echo "====++++executing UNIT Testing++++===="
                sh 'mvn test'
            }
            post{
                always{
                    echo "====++++always++++===="
                }
                success{
                    echo "====++++UNIT Testing executed successfully++++===="
                }
                failure{
                    echo "====++++UNIT Testing execution failed++++===="
                }
        
            }
        }
        stage("Integration testing"){
            steps{
                echo "====++++executing Integration testing++++===="
                sh 'mvn verify -DskipUnitTests'
            }
            post{
                always{
                    echo "====++++always++++===="
                }
                success{
                    echo "====++++Integration testing executed successfully++++===="
                }
                failure{
                    echo "====++++Integration testing execution failed++++===="
                }
        
            }
        }
        stage("Maven Build"){
            steps{
                echo "====++++executing Maven Build++++===="
                sh 'mvn clean install '
            }
            post{
                always{
                    echo "====++++always++++===="
                }
                success{
                    echo "====++++Maven Build executed successfully++++===="
                }
                failure{
                    echo "====++++Maven Build execution failed++++===="
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