    pipeline {
        agent{
            node{
                label "built-in"
            }
        }
        options { 
            buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
        }
        parameters {
            string(name: 'BRANCH_NAME',defaultValue:'main',description:'Enter the branch name to be deployed')
        }
        environment{
            git_url = "https://github.com/Prateekbhatt789/Java_Maven_app.git"
            Image_name = "prateekbhatt789/wpm-webapp"
        }
        stages {
            stage('Clone'){
                steps{
                    echo "Cloning Branch: ${params.BRANCH_NAME}"
                    git url: "${git_url}", branch: "${params.BRANCH_NAME}"
                }
            }
            // stage('Build'){
            //     steps{
            //         sh "mvn clean package -DskipTests"
            //     }
            // }
            stage('Docker Image Build'){
                steps{
                    script{
                        def versionTag = "${env.Image_name}:${env.BUILD_NUMBER}"
                        sh "docker build -t ${versionTag} ."
                    }
                }
            }
            stage('Push to dockerhub'){
                steps{
                    withCredentials ([usernamePassword(
                        credentialsId: 'dockerhub-cred',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable:'DOCKER_PASS')]){
                            script {
                                    def versionTag = "${Image_name}:${env.BUILD_NUMBER}"
                                    def latestTag = "${Image_name}:latest"

                                sh """
                                    docker tag ${versionTag} ${latestTag}
                                    echo "${DOCKER_PASS}" | docker login -u "${DOCKER_USER}" --password-stdin
                                    docker push ${versionTag}
                                    docker push ${latestTag}
                                    echo "Image Pushed: ${versionTag}"

                                    # Cleanup local images
                                    docker rmi ${versionTag} ${latestTag} || true
                                """
                        }
                    }
                                        }   
        }
    }
    post{
        success{
            echo "Build and Docker push completed Successfully"
        }
        failure{
            echo "Build failed!"
        }
    }

}
