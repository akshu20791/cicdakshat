pipeline {
    agent any
    stages{
        stage('Build Maven'){
            steps{
                git url:'https://github.com/akshu20791/DevOpsClassCodes/', branch: "master"
               sh 'mvn clean install'
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t akshu20791/endtoendproject .'
                }
            }
        }
          stage('Docker login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-pwd', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                    sh 'docker push akshu20791/endtoendproject:latest'
                }
            }
        }
        stage('Deploy to k8s'){
            steps{
                script{
                     kubernetesDeploy (configs: $workspace/deploymentservice.yaml ,kubeconfigId: 'k8sconfigpwd')
                   
                }
            }
        }
    }
}
