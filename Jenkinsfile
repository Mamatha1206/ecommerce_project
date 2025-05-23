pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'ecommerce_project'
        DOCKER_TAG = "${BUILD_NUMBER}"
        REGISTRY = 'mamatha0124/my-ecommerce'
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    git credentialsId: 'github-pat-credentials', url: 'https://github.com/Mamatha1206/ecommerce_project.git', branch: 'main'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "echo 'Current Workspace: ' ${WORKSPACE}"
                    sh "ls -l ${WORKSPACE}"  // Debugging: Check files
                    sh "docker build -t ${REGISTRY}:${DOCKER_TAG} -f ${WORKSPACE}/Dockerfile ${WORKSPACE}" 
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'DOCKER_CREDENTIALS_ID', url: 'https://index.docker.io/v1/') {
                        sh "docker push ${REGISTRY}:${DOCKER_TAG}"
                    }
                }
            }
        }

        stage('Deploy to Local Docker') {
            steps {
                script {
                    sh "docker stop ecommerce || true"
                    sh "docker rm ecommerce || true"
                    sh "docker run -d -p 5000:5000 --name ecommerce ${REGISTRY}:${DOCKER_TAG}"
                }
            }
        }
    }

    post {
        success {
            echo '✅ Deployment Successful!'
        }
        failure {
            echo '❌ Deployment Failed!'
        }
    }
}

