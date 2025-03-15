pipeline {
    agent any
    stages{
        stage('Build Maven'){
            steps{
                git url:'https://github.com/Vishwabharathy333/cicdvishwa/', branch: "master"
                sh 'mvn clean install'
            }
        }
        stage('Build Docker Image'){
            steps{
                script{
                    sh 'docker build -t vishwabharathy/endtoendproject25may:v1 .'
                }
            }
        }
        stage('Docker Login & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-pwd', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    // Ensure DNS works before login
                    sh 'echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf'
                    sh 'echo "nameserver 1.1.1.1" | sudo tee -a /etc/resolv.conf'
                    
                    // Docker login with error handling
                    sh "echo $PASS | docker login -u $USER --password-stdin || exit 1"
                    
                    // Tag and Push Image
                    sh 'docker tag vishwabharathy/endtoendproject25may:v1 vishwabharathy/endtoendproject25may:v1'
                    sh 'docker push vishwabharathy/endtoendproject25may:v1'
                }
            }
        }
        
        stage('Deploy to k8s'){
            when { expression { env.BRANCH_NAME == 'master' } }  // Fix GIT_BRANCH issue
            steps{
                script{
                     kubernetesDeploy (configs: 'deploymentservice.yaml', kubeconfigId: 'k8sconfigpwd')
                }
            }
        }
    }
}
