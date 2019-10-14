node {
   def version = '0.0.1'
   stage('prebuild') {
     withCredentials([file(credentialsId: 'jenkins-service-account', variable: 'jenkins')]) {
         sh "cp \$jenkins ./jenkins.json"
         sh """
             gcloud auth activate-service-account --key-file jenkins.json && \
             gcloud container clusters get-credentials test-cluster && \
             kubectl get pods
            """
}

     // checkout scm
   }
   // stage('build') {
     // docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
       // def app = docker.build("anasabdullah/java-app:${version}", '.').push()
     // }
   // }
}
