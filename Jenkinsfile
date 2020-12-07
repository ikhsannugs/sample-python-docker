pipeline {
  agent any
  stages {
      stage('Checkout SCM') {
        steps{
          checkout scm
        }
      }
      stage('Unit Test') {
        steps{
          script{
            sh "python Tests/unit_tests/test_views.py"
          }
        }
      }
      stage('Build & Push') {
        steps{
          script{
            sh "docker build -f Dockerfile -t ikhsannugs/python-azure:${BUILD_NUMBER} ."
            sh "docker push ikhsannugs/python-azure:${BUILD_NUMBER}"
            sh "docker image rm ikhsannugs/python-azure:${BUILD_NUMBER}"
          }
        }
      }
      stage('Deploy') {
        steps{
          sshagent(credentials : ['vm']) {
            sh 'ssh -o StrictHostKeyChecking=no ikhsan@34.101.177.2 "docker rm -f python-azure; docker container run -d -p 5555:5555 --name python-azure ikhsannugs/python-azure:${BUILD_NUMBER}"'
          }
        }
      } 
  }
  post {
    always {
      cleanWs deleteDirs: true
    }
  }
}
