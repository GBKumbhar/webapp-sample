pipeline{
    agent{
        label "ozd1578w"
    }
    stages{
    stage("Clone"){
            steps{
                echo "========executing Static Code Analysis========"
                deleteDir()
                bat "git clone https://github.com/GBKumbhar/webapp-sample.git"
            }
        }
        stage("sonarQube"){
            steps{
                echo "========executing Static Code Analysis========"
                 dir('webapp-sample'){
                    withEnv(['JAVA_HOME=D:/casdev/Softwares/jdk-11.0.15.1']) {
                        withSonarQubeEnv(credentialsId: 'sonar-token', installationName: 'my_sonar_server') {
                            bat "mvn -X clean sonar:sonar"
                        }
                    }
                }
              
            }
        }
        stage{"Running Unit Tests"}{
            steps{
                echo "========executing Junit Tests========"
            }            
        }
        stage("Build"){
            steps{
                echo "========Build Project========"
                dir('webapp-sample'){
                    bat " mvn clean install"    
                }
                }
            }
        
        stage("deploy To Tomcat"){
            steps{
                echo "====++++deploy to tomcat A++++===="
                deploy adapters: [tomcat9(credentialsId: '4abb4eed-5dda-4e2d-a518-5ba8f6366801', path: '', url: 'http://ozd1578w:8084/')], contextPath: 'my_webapps', war: '**/*.war'
            }
        }
        stage("deploy To nexus"){
            steps{
                echo "====++++deploy to nexus A++++===="
                dir('webapp-sample'){
                    step([$class: 'NexusArtifactUploader', artifacts: [[artifactId: 'webapp-sample', classifier: '', file: 'target/webapp-sample-0.0.1-SNAPSHOT.war', type: 'war']], credentialsId: 'my-nexus', groupId: 'com.conti.webapp', nexusUrl: 'ozd1578w:8082', nexusVersion: 'nexus3', protocol: 'http', repository: 'maven-snapshots', version: '0.0.1-SNAPSHOT'])
                }
            }
        }
    }
}
