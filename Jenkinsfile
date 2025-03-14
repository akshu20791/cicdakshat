pipeline {
    agent any
    stages{
        stage('Build Maven'){
            steps{
                git url:'https://github.com/semwalhimanshu90/devopsproject/', branch: "master"
               sh 'mvn clean install'
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t semwalhimanshu/endtoendproject25may:v1 .'
                }
            }
        }
          stage('Docker login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-pwd', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                    sh 'docker push semwalhimanshu/endtoendproject25may:v1'
                }
            }
        }
        
        
        stage('Deploy to k8s'){
            when{ expression {env.GIT_BRANCH == 'master'}}
            steps{
                script{
                     kubernetesDeploy (configs: 'deploymentservice.yaml' ,kubeconfigId: 'k8sconfigpwd')
                   
                }
            }
        }
    }
}
