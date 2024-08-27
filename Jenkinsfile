pipeline {
    agent any
    stages {
        stage('Build Maven') {
            steps {
                git url: 'https://github.com/Gouravkumar717/cicdakshat/', branch: 'master'
                sh 'mvn clean install'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t gourav787/endtoendproject25may:v1 .'
                }
            }
        }
        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-pwd', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh "echo \$PASS | docker login -u \$USER --password-stdin"
                    sh 'docker push gourav787/endtoendproject25may:v1'
                }
            }
        }
        stage('Deploy to K8s') {
            when { branch 'master' }
            steps {
                script {
                    kubernetesDeploy(configs: 'deploymentservice.yaml', kubeconfigId: 'k8sconfigpwd')
                }
            }
        }
    }
}
