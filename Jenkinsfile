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
                script {
                    // Git checkout using Personal Access Token (PAT)
                    git credentialsId: 'github-pat-credentials', url: 'https://github.com/Mamatha1206/ecommerce-project.git', branch: 'main'

                    // If using SSH authentication, comment the above line and uncomment the line below:
                    // git credentialsId: 'github-ssh-key', url: 'git@github.com:Mamatha1206/ecommerce-project.git', branch: 'main'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dir('backend') {
                        echo "Building Docker Image..."
                        sh "docker build -t ${REGISTRY}:${DOCKER_TAG} ."
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    echo "Logging into Docker Hub..."
                    withDockerRegistry(credentialsId: 'dockerhub-credentials', url: 'https://index.docker.io/v1/') {
                        echo "Pushing Docker Image to Docker Hub..."
                        sh "docker push ${REGISTRY}:${DOCKER_TAG}"
                    }
                }
            }
        }

        stage('Deploy to Local Docker') {
            steps {
                script {
                    echo "Stopping existing container if it exists..."
                    sh "docker stop ecommerce || true"
                    sh "docker rm ecommerce || true"

                    echo "Deploying new container..."
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

