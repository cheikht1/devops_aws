pipeline {
    agent any
    environment {
        DOCKER_COMPOSE_VERSION = '1.29.2'
        DOCKER_IMAGE1 = "apache_ct"
        DOCKER_TAG1 = "latest"
        DOCKER_IMAGE2 = "mysql_ct"
        DOCKER_TAG2 = "latest"
    }
    stages {
        stage('Build') {
            steps {
                script {
                    bat '"docker --version"' // Vérifier que Docker est accessible
                    // Lancement de Docker Compose
                    bat "docker build -t ${DOCKER_IMAGE2}:${DOCKER_TAG1} -f Db.Dockerfile ."
                    bat "docker build -t ${DOCKER_IMAGE1}:${DOCKER_TAG2} -f Web.Dockerfile ."
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    // Mettez ici vos commandes pour pousser
                    bat "docker tag ${DOCKER_IMAGE1}:${DOCKER_TAG1} cheikht/${DOCKER_IMAGE1}:${DOCKER_TAG1}"
                    bat "docker push cheikht/${DOCKER_IMAGE1}:${DOCKER_TAG1}"
                    bat "docker tag ${DOCKER_IMAGE2}:${DOCKER_TAG2} cheikht/${DOCKER_IMAGE2}:${DOCKER_TAG2}"
                    bat "docker push cheikht/${DOCKER_IMAGE2}:${DOCKER_TAG2}"
                }
            }
        }
        stage('Deploy') {
            steps {
                withCredentials([file(credentialsId: 'kube_conf', variable: 'KUBECONFIG')]) {
                    script {
                        // Déployer sur Kubernetes
                        bat "kubectl apply -f dbDeploy.yml --kube_conf=${KUBECONFIG} --validate=false"
                        bat "kubectl apply -f webDeploy.yml --kube_conf=${KUBECONFIG} --validate=false"
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
            slackSend channel: '#projetdevops', message: 'Build échoué'
        }
    }
}
