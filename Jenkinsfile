pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'my-ecommerce-backend'
        DOCKER_TAG = "${BUILD_NUMBER}"
        REGISTRY = 'mamatha0124/my-ecommerce'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git (url : 'https://github.com/Mamatha1206/ecommerce-project.git', branch:'main')
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Navigate to the backend directory
                    dir('backend') {
                        // Build the Docker image with the dynamic tag
                        sh "docker build -t ${REGISTRY}:${DOCKER_TAG} ."
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub using Jenkins credentials
                    withDockerRegistry(credentialsId: 'dockerhub-credentials', url: 'https://index.docker.io/v1/') {
                        // Push the image to Docker Hub
                        sh "docker push ${REGISTRY}:${DOCKER_TAG}"
                    }
                }
            }
        }

        stage('Deploy to Local Docker') {
            steps {
                script {
                    // Stop and remove the old container if it exists
                    sh "docker stop ecommerce || true"
                    sh "docker rm ecommerce || true"
                    
                    // Run a new container with the newly built image
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
