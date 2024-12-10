pipeline {
    agent any

    stages {
        stage('Build Maven') {
            steps {
                git url: 'https://github.com/ranjitha-narayana/cicdakshat/', branch: 'master'
                sh 'mvn clean install'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t kuberanjitha/endtoendproject25may:v1 .'
                }
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-pwd', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    script {
                        // Use 'sh' to login to Docker
                        sh "echo \$PASS | docker login -u \$USER --password-stdin"
                    }
                    // Push the Docker image after a successful login
                    sh 'docker push kuberanjitha/endtoendproject25may:v1'
                }
            }
        }

        stage('Deploy to k8s') {
            when {
                expression { env.GIT_BRANCH == 'master' }
            }
            steps {
                script {
                    kubernetesDeploy(configs: 'deploymentservice.yaml', kubeconfigId: 'k8sconfigpwd')
                }
            }
        }
    }
}
