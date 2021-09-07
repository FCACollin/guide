pipeline {
  agent any
  stages {
    stage('copy') {
      steps {
        writeFile(file: 'README.md', text: 'test')
      }
    }

  }
}