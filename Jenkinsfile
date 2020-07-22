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
        stage("Build service artefact") {
            steps {
                echo '================== Building service artefact =================='
                sh 'mvn clean'
                sh 'mvn install'
            }
        }
        stage("DockerHub login") {
            steps {
                echo '================== DockerHub login =================='
                withCredentials([usernamePassword(credentialsId: 'dockerhub-dumavladislav', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    echo $USERNAME
                    echo $PASSWORD
                    sh """
                    docker login -u $USERNAME -p $PASSWORD
                    """
                }
            }
        }
        stage("Build image") {
            steps {
                sh 'docker build -t dumavladislav/dumskyhome:latest .'
            }
        }
        stage("Push image to docker registry") {
            steps{
                echo '================== DockerHub Push =================='
                sh "docker push dumavladislav/dumskyhome:latest"
            }
        }
    }
}