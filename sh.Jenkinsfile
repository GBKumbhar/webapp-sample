pipeline{
    agent{
        label "ec2-node"
    }
    environment{
        tag = getDockerTag() 
    }
    stages{
        stage("Clone"){
            steps{
                echo "========executing Static Code Analysis========"
                deleteDir()
                sh "git clone https://github.com/GBKumbhar/webapp-sample.git"
            }
        }
        stage("sonarQube"){
            steps{
                echo "========executing Static Code Analysis========"
              
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
                    sh " mvn clean install"    
                }
                }
        }
        stage("create Docker Image"){
            script{
                sh 'docker build -t 00010009/webapp1:${tag} .'
         	    sh 'docker tag my-image 00010009/webapp1:${tag}'
         	    sh 'docker images'\
         	
         	    withCredentials([string(credentialsId: 'dockpwd', variable: 'dockpwd')]) {
         		    sh 'docker login -u 00010009 -p $dockpwd '
         		    sh 'docker push 00010009/webapp1:${tag}'
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

def getDockerTag(){
    def tag = sh script: 'git rev-parse HEAD', returnStdout: true ;
    return tag;
    
}
