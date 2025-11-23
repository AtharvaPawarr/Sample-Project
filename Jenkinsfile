pipeline {
  agent any // runs on same node where Jenkins is installed
  tools {
    jdk 'jdk17'
    maven 'Maven3'
  }
  stages {
    stage('Checkout') {
      steps { git(url: 'https://github.com/AtharvaPawarr/Sample-Project.git', branch: 'main') }
    }
    stage('Build') {
      steps { sh 'mvn -B -DskipTests clean package' }
    }
    stage('Tests') {
      steps { sh 'mvn -B test' }
      post { always { junit 'target/surefire-reports/*.xml' } }
    }
    stage('Docker Build & Run') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh '''
            docker build -t sample-app:${BUILD_NUMBER} .
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker run --rm -d --name sample-app-${BUILD_NUMBER} -p 8080:8080 sample-app:${BUILD_NUMBER}
          '''
        }
      }
    }
  }
  post {
    always { cleanWs() }
  }
}
