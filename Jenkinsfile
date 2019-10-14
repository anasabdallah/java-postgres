pipeline {
  agent any
  def version = '0.0.1'
  currentBuild.result = 'FAILURE'
  stage('clean') {
    steps {
      cleanWs()
    }
  }
  stage('prebuild') {
    steps {
      script {
        checkout scm
        withCredentials([file(credentialsId: 'jenkins-service-account', variable: 'jenkins')]) {
          sh """
            gcloud auth activate-service-account --key-file $jenkins && \
            gcloud config set compute/zone us-east1-b && \
            gcloud container clusters get-credentials test-cluster
          """
        }
      } 
    }
  }
  stage('build') {
    steps {
      docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
        def app = docker.build("anasabdullah/java-app:${version}", '.').push()
      }
    }
  }
  stage('deploy') {
    steps {
      sh """
        kubectl delete deployment.apps/java && \
        kubectl apply -f kubernetes/java-deployment.yml
      """
      sh "echo 'service deployed'"
      currentBuild.result = 'SUCCESS'
    }
  }
}
