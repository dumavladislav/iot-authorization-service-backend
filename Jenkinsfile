#!groovy
// Check netbook properties
properties([disableConcurrentBuilds()])

pipeline {
    agent {
        label 'master'
        }
    options {
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
        timestamps()
    }
    stages {
        stage("Build image") {
            steps {
                sh 'docker build .'
            }
        }
    }
}