pipeline {
  agent any
  stages {
      stage('Checkout SCM') {
        steps{
          checkout scm
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
      stage('Input Version Image') {
        steps{
          script{
            sh "sed -i 's/tujuan/${BRANCH_NAME}/g' deploy-apps.yaml"
            sh "sed -i 's/versi/${BUILD_NUMBER}/g' deploy-apps.yaml"
          }
        }
      }
      stage('Deploy To DEV') {
        when {
          branch 'dev'
        }
        steps{
          withKubeConfig([credentialsId: 'kubeconfig-cluster-ict']) {
            sh "kubectl apply -f deploy-apps.yaml -n dev"
          }
        }
      }
      stage('Deploy To PROD') {
        when {
          branch 'main'
        }
        steps{
          withKubeConfig([credentialsId: 'kubeconfig-cluster-ict']) {
            sh "kubectl apply -f deploy-apps.yaml -n prod"
          }
        }
      } 
  }
}
