pipeline{
    agent any
    stages{
        stage("Email message"){
            steps{
                echo "====++++executing Email message++++===="
                emailext body: 'exploring the created pipeline', subject: 'CI/CD', to: 'brainboyrichmond@gmail.com'
            }
            post{
                always{
                    echo "====++++always++++===="
                }
                success{
                    echo "====++++Email message executed successfully++++===="
                }
                failure{
                    echo "====++++Email message execution failed++++===="
                }
        
            }
        }
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