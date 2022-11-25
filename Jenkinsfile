pipeline{
    agent any
    stages{        stage("Git checkout"){
            steps{
                echo "====++++executing checkout++++===="
                git 'https://github.com/njokuifeanyigerald/ci-cd-project-with-sonarqube.git'
            }
            post{
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
                success{
                    echo "====++++Maven Build executed successfully++++===="
                }
                failure{
                    echo "====++++Maven Build execution failed++++===="
                }
        
            }
        }
        stage("Static Code Analysis"){
            steps{
                echo "====++++executing Static Code Analysis++++===="
                script{
                    withSonarQubeEnv(credentialsId: 'sonarQubeToken') {
                        // some block
                        sh 'mvn clean package sonar:sonar'
                    }
                }  
            }
            post{
                success{
                    echo "====++++Static Code Analysis executed successfully++++===="
                }
                failure{
                    echo "====++++Static Code Analysis execution failed++++===="
                }
        
            }
        }
        stage("Quality Gate"){
            steps{
                echo "====++++executing Quality Gate++++===="
                script{
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonarQubeToken'
                }
            }
            post{
                
                success{
                    echo "====++++Quality Gate executed successfully++++===="
                }
                failure{
                    echo "====++++Quality Gate execution failed++++===="
                }
        
            }
        }
        stage("upload war files to nexus"){
            steps{
                echo "====++++executing upload war files to nexus++++===="
                script{
                    // to automatically read the pom.xml file inorder to get the version
                    def readPomVersion = readMavenPom file: 'pom.xml'

                    // if it ends with snapshot
                    def nexusRepo = readPomVersion.version.endsWith("SNAPSHOT") ? "demoapp-snapshot" : "demoapp"
                    
                    nexusArtifactUploader artifacts: [
                        [
                            artifactId: 'springboot',
                            classifier: '', file: 'target/Uber.jar', type: 'jar'
                        ]
                    ],
                    credentialsId: 'Nexus-auth', groupId: 'com.example',
                    nexusUrl: '127.0.0.1:8081', nexusVersion: 'nexus3', 
                    protocol: 'http', repository: nexusRepo, version: "${readPomVersion.version}"
                }

            }
            post{
                success{
                    echo "====++++upload war files to nexus executed successfully++++===="
                }
                failure{
                    echo "====++++upload war files to nexus execution failed++++===="
                }
        
            }
        }

        stage("Docker Image Build"){
            steps{
                echo "====++++executing Docker Image Build++++===="
                script {
                    sh "docker image build -t $JOB_NAME:v1.$BUILD_ID ."
                    sh "docker image tag $JOB_NAME:v1.$BUILD_ID bopgeek/$JOB_NAME:v1.$BUILD_ID"
                    sh "docker image tag $JOB_NAME:v1.$BUILD_ID bopgeek/$JOB_NAME:v1.latest"
                }
            }
            post{
                success{
                    echo "====++++Docker Image Build executed successfully++++===="
                }
                failure{
                    echo "====++++Docker Image Build execution failed++++===="
                }
        
            }
        } 

        stage("push image to dockerHub"){
            steps{
                echo "====++++executing push image to dockerHub++++===="
                script{
                    withCredentials([string(credentialsId: 'DockerHub', variable: 'dockerhub_cred')]) {
                        // some block
                        sh 'docker login -u bopgeek -p ${dockerhub_cred}'
                        sh 'docker build push bopgeek/$JOB_NAME:v1.$BUILD_ID'
                        sh 'docker build push bopgeek/$JOB_NAME:v1.latest'
                    }
                }
            }
            post{
                
                success{
                    echo "====++++push image to dockerHub executed successfully++++===="
                }
                failure{
                    echo "====++++push image to dockerHub execution failed++++===="
                }
        
            }
        }  
            
        
    }
    post{
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}