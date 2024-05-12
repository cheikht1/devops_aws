pipeline {
    agent any
    // triggers {
    //     githubPush()
    // }
    stages {
        // stage('Checkout') {
        //     steps {
        //         git 'https://github.com/nazimgueye/fil_rouge.git'
        //     }
        // }
        // stage ('Build Docker Images') {
        //     steps {
        //         bat 'docker-compose up -d'
        //     }
        // }
        // stage ('Run Tests') {
        //     steps {
        //         bat 'docker ps -a' // Remplacez ceci par vos tests réels si nécessaire
        //     }
        // }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Récupérer le fichier kubeconfig depuis les credentials de Jenkins
                    def kubeconfig = credentials('kube_config')

                    // Assurez-vous que le fichier kubeconfig existe
                    if (!fileExists(kubeconfig)) {
                        error "Le fichier kubeconfig n'existe pas à l'emplacement spécifié."
                    }

                    // Appliquer les ressources Kubernetes depuis le dossier 'kubernetes' en utilisant le fichier kubeconfig
                    dir('kubernetes') {
                        // Utilisez la commande kubectl apply avec l'option --kubeconfig pour spécifier le fichier kubeconfig
                        sh "kubectl apply -f . --kubeconfig=${kubeconfig}"
                    }
                }
            }
        }
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
