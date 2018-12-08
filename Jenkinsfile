pipeline {
  agent any
  stages {
    stage('Build') {
      parallel {
        stage('Build') {
          steps {
            echo 'start build'
            sh 'mvn clean package'
          }
        }
        stage('record') {
          steps {
            fingerprint '*.war'
          }
        }
      }
    }
    stage('Deploy') {
      parallel {
        stage('Deploy') {
          when {
            expression {
              currentBuild.result == null || currentBuild.result == 'SUCCESS' // 判断是否发生测试失败
            }

          }
          steps {
            echo 'Deploying....'
            archive 'target/*.jar'
            sh 'sudo sh ./deploy.sh'
          }
        }
        stage('msg') {
          steps {
            echo 'start archive war'
            archiveArtifacts '*.war'
          }
        }
      }
    }
  }
}
