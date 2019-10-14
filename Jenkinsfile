node {
  def version = '0.0.2'
  stage('clean') {
    cleanWs()
  }
  stage('prebuild') {
    checkout scm
    withCredentials([file(credentialsId: 'jenkins-service-account', variable: 'jenkins')]) {
      sh """
         gcloud auth activate-service-account --key-file $jenkins && \
         gcloud config set compute/zone us-east1-b && \
         gcloud container clusters get-credentials test-cluster
         """
    } 
  }
  stage('build') {
    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
      def app = docker.build("anasabdullah/java-app:${version}", '.').push()
    }
  }
  stage('deploy') {
    sh """
       kubectl delete deployment.apps/java service/java-app && \
       kubectl apply -f kubernetes/java-deployment.yml && \
       kubectl apply -f kubernetes/java-service.yml
       """
  }
}
