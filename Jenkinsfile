pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'registry.hub.docker.com/lgouveia' // Substitua pelo seu registro Docker
        DOCKER_STACK_NAME = 'nginx-jenkins'
        IMAGE_NAME = 'lgouveia/jenkins-nginx:latest'
        GIT_REPO_URL = 'https://github.com/lgouveia9/nginx-jenkins.git' // Substitua pela URL do seu repositório Git
        GIT_CREDENTIAL_ID = 'github' // Substitua pelo ID de suas credenciais Git configuradas no Jenkins
        DOCKERFILE_PATH = '/home/nginx-jenkins/Dockerfile'
    }

    stages {
        stage('Checkout') {
            steps {
                // Realiza o checkout do repositório Git
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: GIT_REPO_URL, credentialsId: GIT_CREDENTIAL_ID]]])
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Constrói a imagem Docker
                    def dockerCli = tool 'docker'
                    sh "${dockerCli} build -t ${DOCKER_REGISTRY}/${IMAGE_NAME} -f ${DOCKERFILE_PATH} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Faz login no registro Docker
                    def dockerCli = tool 'docker'
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "${dockerCli} login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD} ${DOCKER_REGISTRY}"
                    }

                    // Envia a imagem para o registro Docker
                    sh "${dockerCli} push ${DOCKER_REGISTRY}/${IMAGE_NAME}"
                }
            }
        }

        stage('Deploy to Docker Swarm') {
            steps {
                script {
                    // Realiza o deploy do stack Docker
                    def dockerCli = tool 'docker'
                    sh "${dockerCli} stack deploy -c docker-compose.yml ${DOCKER_STACK_NAME}"
                }
            }
        }
    }

    post {
        always {
            // Logout do registro Docker após o push da imagem (opcional)
            script {
                def dockerCli = tool 'docker'
                sh "${dockerCli} logout ${DOCKER_REGISTRY}"
            }
        }
    }
}
