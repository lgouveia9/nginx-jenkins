pipeline {
    agent any

    stages {
        stage('Checkout Source') {
           steps{
            git url:'https://github.com/lgouveia9/nginx-jenkins.git', branch:'master'
           }
        }

        stage('Build Image') {
           steps {
               script {
                   dockerapp = docker.build("lgouveia/jenkins-nginx:latest",
                     '-f /home/nginx-jenkins/Dockerfile .')
               }
           }
        }

        stage('Deploy') {
            steps {
                script {
                    // Realiza o deploy usando docker stack deploy
                    sh 'docker stack deploy -c docker-compose.yml jenkins-nginx'
                }
            }
        }
    }
}

