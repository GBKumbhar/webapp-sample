pipeline{
    agent{
        label "ec2-node"
    }
    stages{
        stage("sonarQube"){
            steps{
                echo "========executing Static Code Analysis========"
                script{
                    sh 'echo Hello Sonar'
                }
            }
            post{
                always{
                    echo "========always========"
                }
                success{
                    echo "========A executed successfully========"
                }
                failure{
                    echo "========A execution failed========"
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
                script{
                    sh "mvn clean install "

                }

            }
        }
        stage("Docker"){
            steps{
                echo "====++++Creating Docker Image++++===="
                script{
                    sh 'docker build -t my-image .'
                    sh 'docker images'
                }
            }
            
        }
        stage("deploy To Tomcat"){
            steps{

                echo "====++++deploy to tomcat A++++===="
            }
        }

    }
    post{
        always{
            echo "========always========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}