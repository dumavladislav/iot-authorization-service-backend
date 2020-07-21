#!groovy
// Check netbook properties
properties([disableConcurrentBuilds()])

pipeline {
    agent {
        label 'master'
        }
    triggers { pollSCM('*****')}
    options {
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
        timestamps()
    }
    stages {
        stage("Build service artefact") {
            steps {
                echo '================= Building service artefact ================='
                sh 'mvn clean'
                sh 'mvn install'
            }
        }
        stage("Build image") {
            steps {
                sh 'docker build .'
            }
        }
    }
}