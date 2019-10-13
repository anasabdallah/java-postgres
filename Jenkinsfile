node {
   def version = '0.0.1'
   stage('prebuild') {
     ws {
       withCredentials([file(credentialsId: 'jenkins-service-account	', variable: 'jenkins_key')]) {
         sh 'use $jenkins_key'
       }
     }
     // checkout scm
   }
   // stage('build') {
     // docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
       // def app = docker.build("anasabdullah/java-app:${version}", '.').push()
     // }
   // }
}
