<html>
<body>
<h2>Hello World!</h2>
  <h3>Is a test page!</h3>
  <div>
  
  BRANCH_NAME
For a multibranch project, this will be set to the name of the branch being built, for example in case you wish to deploy to production from master but not from feature branches; if corresponding to some kind of change request, the name is generally arbitrary (refer to CHANGE_ID and CHANGE_TARGET).
CHANGE_ID
For a multibranch project corresponding to some kind of change request, this will be set to the change ID, such as a pull request number, if supported; else unset.
CHANGE_URL
For a multibranch project corresponding to some kind of change request, this will be set to the change URL, if supported; else unset.
CHANGE_TITLE
For a multibranch project corresponding to some kind of change request, this will be set to the title of the change, if supported; else unset.
CHANGE_AUTHOR
For a multibranch project corresponding to some kind of change request, this will be set to the username of the author of the proposed change, if supported; else unset.
CHANGE_AUTHOR_DISPLAY_NAME
For a multibranch project corresponding to some kind of change request, this will be set to the human name of the author, if supported; else unset.
CHANGE_AUTHOR_EMAIL
For a multibranch project corresponding to some kind of change request, this will be set to the email address of the author, if supported; else unset.
CHANGE_TARGET
For a multibranch project corresponding to some kind of change request, this will be set to the target or base branch to which the change could be merged, if supported; else unset.
  
    pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                archiveArtifacts artifacts: '*', fingerprint: true 
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                /* 测试失败时，`make check` 返回非 0 值
                *  尽管如此，使用 `true` 使 Pipeline 继续
                */
                //sh 'make check || true' 
                //junit '**/target/*.xml'
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
                sh 'tar -czf target.tar.gz *'
            }
        }
    }
}
    
    
  </div>
</body>
</html>
