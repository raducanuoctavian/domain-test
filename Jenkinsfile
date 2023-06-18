pipeline {
    agent {
      label 'builder'
    }
    options {
      skipDefaultCheckout()
      buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '5')
    }
    
    stages {
        stage('Checkout') {
            steps {
                cleanWs()
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/tayfun94/domain-test.git']])
            }
        }
        
        stage('Docker Build') {
            steps {
                sh 'docker build -t spring:latest .'
            }
        }
        
        stage('Publish Artifacts') {
            steps {
                script {
                    try {
                        sh 'docker rm -f springApp'
                    }
                    catch(Exception e) {
                        echo 'n-am gasit aplicatia pornita boss, pacat...'
                    }                    
                    sh 'docker run -d --name spingApp -p 9080:8080 -v /home/tayfy/spring_logs:/deploy/logs spring:latest'
                }
            }
        }
    }
    
    post {
        success {
            echo 'succes boss'
        }
        
        failure {
            echo 'nasol, mai incearca!'
        }
    }
}
