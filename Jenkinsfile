pipeline {
    agent none
    environment {
        DOTNET_CLI_HOME = "/tmp/DOTNET_CLI_HOME"
    }
    stages {
        stage('Build and test C#') {
            agent {
                docker { image 'mcr.microsoft.com/dotnet/core/sdk:3.1' }
            }
            steps {
                checkout scm
                sh 'dotnet restore'
                sh 'dotnet build'
                sh 'dotnet test'
            }
        }
        stage('Build and test TS') {
            agent { 
                docker { image 'node:14-alpine' }
            }
            steps {
                checkout scm
                
                dir("DotnetTemplate.Web") {
                    sh 'npm i && npm run build && npm t && npm run lint'
                }                
            }
        }
    }
    post {
        success {
            slackSend (color: '#00FF00', message: "Jenkins pipeline successful")
        }
        failure {
            slackSend (color: '#FF0000', message: "Jenkins pipeline failed")
        }
        aborted {
            slackSend (color: '#0000FF', message: "Jenkins pipeline aborted")
        }
    }
}