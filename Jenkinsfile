pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
            // Run the maven build
              if (isUnix()) {
                echo "start build"
                sh "mvn clean package"
              } else {
                echo 'not suppost.'
              }
            }
        }
        stage('Deploy') {
             when {
              expression {
                currentBuild.result == null || currentBuild.result == 'SUCCESS' // 判断是否发生测试失败
              }
            }
            steps {
                echo 'Deploying....'
                archive 'target/*.jar'
                sh 'sudo /data/jenkins/deploy.sh'
            }
        }
    }
}
