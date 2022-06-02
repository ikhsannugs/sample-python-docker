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
            sh "docker build -f Dockerfile -t ikhsannugs/python-azure:${BRANCH_NAME}-${BUILD_NUMBER} ."
            sh "docker push ikhsannugs/python-azure:${BRANCH_NAME}-${BUILD_NUMBER}"
            sh "docker image rm ikhsannugs/python-azure:${BRANCH_NAME}-${BUILD_NUMBER}"
          }
        }
      }
      stage('Deploy') {
        steps{
          script{
            sh "sed -i 's/tujuan/${BRANCH_NAME}/g' deploy-apps.yaml"
            sh "sed -i 's/versi/${BUILD_NUMBER}/g' deploy-apps.yaml"
            sh "kubectl apply -f deploy-nodejs-backend.yaml"
          }
        }
      } 
  }
}
