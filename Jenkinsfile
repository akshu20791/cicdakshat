pipeline {
    agent any
    stages{
        stage('Build Maven'){
            steps{
                git url:'https://github.com/shruti2222K/cicdakshat/', branch: "master"
               sh 'mvn clean install'
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t shruti2110/oct302025project:v1 .'
                }
            }
        }
         stage('Docker login') {
                 steps {
                      withCredentials([string(credentialsId: 'docker-hub-pass', variable: 'PASS')]) {
    sh 'echo $PASS | docker login -u shruti2110 --password-stdin'
}

        }
    }

                stage('Deploy to Kubernetes') {
    steps {
        sh '''
          kubectl apply -f deploymentservice.yaml
          kubectl get pods -n default
        '''
    }
}

           
         
     
       
  }
}
