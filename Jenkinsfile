pipeline {
  agent {
    docker {
      image 'hello-world'
    }

  }
  stages {
    stage('ayup') {
      steps {
        sh 'docker run hello-world'
      }
    }

  }
}