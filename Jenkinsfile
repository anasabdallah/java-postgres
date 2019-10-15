node {
  def version = '0.0.2'
  stage('clean') {
    cleanWs()
  }
  stage('prebuild') {
    sh "git clone https://github.com/anasabdallah/java-postgres.git && mv java-postgres/* ./ && rm -rf java-postgresgit"
    withCredentials([file(credentialsId: 'jenkins-service-account', variable: 'jenkins')]) {
      sh """
         gcloud auth activate-service-account --key-file $jenkins && \
         gcloud config set project java-app-255411 && \
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
