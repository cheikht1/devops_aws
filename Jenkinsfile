pipeline {
    agent any
    triggers {
        githubPush()
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/nazimgueye/fil_rouge.git'
            }
        }
        // stage ('Build Docker Images') {
        //     steps {
        //         bat 'docker-compose build'
        //     }
        // }
        // stage ('Run Tests') {
        //     steps {
        //         bat 'docker ps -a' // Remplacez ceci par vos tests réels si nécessaire
        //     }
        // }
        stage ('Run Docker Compose') {
            steps {
                bat 'docker-compose up -d --build'
            }
        }
    }
    post {
        success {
           // bat 'docker-compose down -v'
            slackSend channel: '#projetdevops', message: 'Build réussi'
        }
        failure {
            slackSend channel: '#projetdevops', message: 'Build echoue'
        }
    }
}
