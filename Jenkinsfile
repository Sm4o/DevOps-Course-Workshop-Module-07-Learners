pipeline {
    agent none
    stages {
        stage('Build and test C#') {
            agent {
                docker { image 'mcr.microsoft.com/dotnet/core/sdk:3.1' }
            }
            environment {
                DOTNET_CLI_HOME = "/tmp/DOTNET_CLI_HOME"
            }
            steps {
                checkout scm
                sh 'dotnet restore && dotnet build && dotnet test'
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
}