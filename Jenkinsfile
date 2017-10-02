pipeline {
  agent any
  stages {
    stage('Self-Update composer') {
      steps {
        echo 'Run composer self-update'
        sh 'composer self-update'
        sh 'composer global update hirak/prestissimo'
      }
    }
    stage('Install') {
      steps {
        echo 'Run composer install'
        sh 'composer install'
      }
    }
    stage('Test') {
      steps {
        echo 'Run All Test'
        sh 'composer test'
      }
    }
  }
  post {
    always {
      junit allowEmptyResults: true, testResults: 'test-results.xml'
    }
  }
}
