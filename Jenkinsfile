#!groovy
// Check netbook properties
properties([disableConcurrentBuilds()])

pipeline {
    agent {
        label 'master'
        }
    triggers { pollSCM('* * * * *') }
    options {
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
        timestamps()
    }
    stages {
        stage("Copy to netbook") {
            steps {
                echo '================== Copy to netbook =================='
                sh "ssh -p 23 root@dumskyhome.keenetic.name 'mkdir ~/iot-authorization-service-backend > mvn clean'"
                sh "scp -r * root@192.168.1.53:~/iot-authorization-service-backend"
            }
        }
        stage("Build service artefact") {
            steps {
                echo '================== Building service artefact =================='
                sh "ssh -p 23 root@dumskyhome.keenetic.name 'cd ~/iot-authorization-service-backend > mvn clean'"
                sh "ssh -p 23 root@dumskyhome.keenetic.name 'cd ~/iot-authorization-service-backend > mvn install'"
            }
        }
        stage("DockerHub login") {
            steps {
                echo '================== DockerHub login =================='
                withCredentials([usernamePassword(credentialsId: 'dockerhub-vladislavduma', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh """
                    ssh -p 23 root@dumskyhome.keenetic.name 'docker login -u $USERNAME -p $PASSWORD'
                    """
                }
            }
        }
        stage("Build image") {
            steps {
                sh "ssh -p 23 root@dumskyhome.keenetic.name 'cd ~/iot-authorization-service-backend > docker build -t vladislavduma/iot-authorization-service-backend:latest .'"
            }
        }
        stage("Push image to docker registry") {
            steps{
                echo '================== DockerHub Push =================='
                sh "ssh -p 23 root@dumskyhome.keenetic.name 'docker push vladislavduma/iot-authorization-service-backend:latest'"
            }
        }
        stage("Run image on Backend server") {
            steps{
                echo '================== Running on Backend =================='
                sh "ssh -p 23 root@dumskyhome.keenetic.name 'docker run vladislavduma/iot-authorization-service-backend:latest --restart unless-stopped -it'"
            }
        }
    }
}