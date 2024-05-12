pipeline {
    agent any
    environment {
        DOCKER_COMPOSE_VERSION = '1.29.2'
        PATH = "/usr/local/bin:$PATH" // Assurez-vous que cela inclut le chemin vers Docker
        DOCKER_IMAGE1 = "apache_ct"
        DOCKER_TAG1 = "latest"
        DOCKER_IMAGE2 = "mysql_ct"
        DOCKER_TAG2 = "latest"
    }
    stages {
        stage('Build') {
            steps {
                script {
                    sh 'docker --version' // Vérifier que Docker est accessible
                    // Lancement de Docker Compose
                    sh 'docker build -t ${DOCKER_IMAGE2}:${DOCKER_TAG1} -f Db.Dockerfile .'
                    sh 'docker build -t ${DOCKER_IMAGE1}:${DOCKER_TAG2} -f Web.Dockerfile .'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    // Mettez ici vos commandes pour pousser
                    sh 'docker tag ${DOCKER_IMAGE1}:${DOCKER_TAG1} cheikht/${DOCKER_IMAGE1}:${DOCKER_TAG1}'
                    sh 'docker push cheikht/${DOCKER_IMAGE1}:${DOCKER_TAG1}'
                    sh 'docker tag ${DOCKER_IMAGE2}:${DOCKER_TAG2} cheikht/${DOCKER_IMAGE2}:${DOCKER_TAG2}'
                    sh 'docker push cheikht/${DOCKER_IMAGE2}:${DOCKER_TAG2}'
                }
            }
        }
        stage('Deploy') {
            steps {
                withCredentials([file(credentialsId: 'kube_conf', variable: 'KUBECONFIG')]) {
                    script {
                        // Déployer sur Kubernetes
                        sh 'kubectl apply -f components.yaml --kube_conf=${KUBECONFIG} --validate=false '
                        sh 'kubectl apply -f db-deployment.yml --kube_conf=${KUBECONFIG} --validate=false'
                        sh 'kubectl apply -f web-deployment.yml --kube_conf=${KUBECONFIG} --validate=false'
                    }
                }
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