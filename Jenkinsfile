pipeline {
    agent any
    environment {
        DOCKER_COMPOSE_VERSION = '1.29.2'
        DOCKER_IMAGE1 = "apache_ct"
        DOCKER_TAG1 = "latest"
        DOCKER_IMAGE2 = "mysql_ct"
        DOCKER_TAG2 = "latest"
        KUBECONFIG = '/home/cheikh/.kube/config'
    }
    stages {
        stage('Terraform') {
            steps {
                script {
                    // Lancement de Terraform
                    dir('Terraform') {
                        // Se déplacer dans le dossier Terraform
                        sh 'terraform --version'
                        sh 'terraform init'
                        sh 'terraform plan -var="kubeconfig_path=$KUBECONFIG"'
                        sh 'terraform apply --auto-approve -var="kubeconfig_path=$KUBECONFIG"'
                        // sh 'terraform destroy --auto-approve -var="kubeconfig_path=$KUBECONFIG"'
                    }
                }
            }
        }
        stage('Install Python dependencies and Deploy with Ansible') {
    steps {
        script {
            // Installation des dépendances Python et déploiement avec Ansible
            sh '''
            sudo apt-get install -y python3-venv
            cd Ansible
            python3 -m venv venv
            . venv/bin/activate
            pip install --user kubernetes ansible
            ansible-playbook playbook.yml
            '''
        }
    }
}

    }
    post {
        success {
            // Envoi d'une notification Slack en cas de succès
            slackSend channel: '#projetdevops', message: 'Build réussi'
        }
        failure {
            // Envoi d'une notification Slack en cas d'échec
            slackSend channel: '#projetdevops', message: 'Build échoué'
        }
    }
}



































// pipeline {
//     agent any
//     environment {
//         DOCKER_COMPOSE_VERSION = '1.29.2'
//         DOCKER_IMAGE1 = "apache_ct"
//         DOCKER_TAG1 = "latest"
//         DOCKER_IMAGE2 = "mysql_ct"
//         DOCKER_TAG2 = "latest"
//     }
//     stages {
//         // stage('Cree les fichiers Image Docker') {
//         //     steps {
//         //         script {
//         //             bat "docker --version" // Vérifier que Docker est accessible
//         //             // Lancement de Docker Compose
//         //             bat "docker build -t ${DOCKER_IMAGE2}:${DOCKER_TAG1} -f Db.Dockerfile ."
//         //             bat "docker build -t ${DOCKER_IMAGE1}:${DOCKER_TAG2} -f Web.Dockerfile ."
//         //         }
//         //     }
//         // }
//         // stage('publier les images Docker') {
//         //     steps {
//         //         script {
//         //             bat "docker login -u cheikht -p m6rZ.uGUKpTXWkq"
//         //             // Mettez ici vos commandes pour pousser
//         //             bat "docker tag ${DOCKER_IMAGE1}:${DOCKER_TAG1} cheikht/${DOCKER_IMAGE1}:${DOCKER_TAG1}"
//         //             bat "docker push cheikht/${DOCKER_IMAGE1}:${DOCKER_TAG1}"
//         //             bat "docker tag ${DOCKER_IMAGE2}:${DOCKER_TAG2} cheikht/${DOCKER_IMAGE2}:${DOCKER_TAG2}"
//         //             bat "docker push cheikht/${DOCKER_IMAGE2}:${DOCKER_TAG2}"
//         //         }
//         //     }
//         // }
// //         stage('Deployer sur Kubernetes') {
// //         steps {
// //         withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
// //             script {
// //                 // Déployer sur Kubernetes
// //                 bat "kubectl apply -f db_web_deploy_serv.yml --kubeconfig=%KUBECONFIG% --validate=false"
// //             }
// //         }
// //     }
// // }
//       stage('Terraform') {
//             steps {
//                 dir('terraform') {
//                     script {
//                         // Lancement de Terraform
//                         bat 'terraform --version'
//                         // bat 'terraform init'
//                         bat 'terraform plan'
//                         bat 'terraform apply --auto-approve'
//                         // bat 'terraform destroy --auto-approve'
//                     }
//                 }
//             }
//         }

//     }
//     post {
//         success {
//            // bat 'docker-compose down -v'
//             slackSend channel: '#projetdevops', message: 'Build réussi'
//         }
//         failure {
//             slackSend channel: '#projetdevops', message: 'Build échoué'
//         }
//     }
// }
