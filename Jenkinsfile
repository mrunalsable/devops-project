pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        DOCKERHUB_USERNAME    = credentials('dockerhub-username')
        K8S_SERVER            = '100.24.97.178'
        IMAGE_NAME            = "${DOCKERHUB_USERNAME}/flask-app"
        IMAGE_TAG             = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
                echo '📥 Checking out source code...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker image...'
                dir('app') {
                    sh """
                        docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                        docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest
                    """
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                echo '📤 Pushing image to DockerHub...'
                sh """
                    echo ${DOCKERHUB_CREDENTIALS_PSW} | \
                    docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin
                    docker push ${IMAGE_NAME}:${IMAGE_TAG}
                    docker push ${IMAGE_NAME}:latest
                    docker logout
                """
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo '☸️ Deploying to K3s...'
                sh """
                    sed -i 's|DOCKERHUB_USERNAME/flask-app:latest|${IMAGE_NAME}:${IMAGE_TAG}|g' \
                        kubernetes/deployment.yml
                    
                    ssh -i /var/lib/jenkins/.ssh/devops-project \
                        -o StrictHostKeyChecking=no \
                        ubuntu@${K8S_SERVER} \
                        'sudo k3s kubectl apply -f -' < kubernetes/deployment.yml

                    ssh -i /var/lib/jenkins/.ssh/devops-project \
                        -o StrictHostKeyChecking=no \
                        ubuntu@${K8S_SERVER} \
                        'sudo k3s kubectl apply -f -' < kubernetes/service.yml
                """
            }
        }

        stage('Verify Deployment') {
            steps {
                echo '✅ Verifying deployment...'
                sh """
                    ssh -i /var/lib/jenkins/.ssh/devops-project \
                        -o StrictHostKeyChecking=no \
                        ubuntu@${K8S_SERVER} \
                        'sudo k3s kubectl rollout status deployment/flask-app --timeout=120s'
                """
            }
        }
    }

    post {
        success {
            echo """
            ✅ Pipeline SUCCESS!
            🌐 App URL: http://${K8S_SERVER}:30080
            🐳 Image: ${IMAGE_NAME}:${IMAGE_TAG}
            """
        }
        failure {
            echo '❌ Pipeline FAILED! Check logs above.'
        }
        always {
            sh 'docker image prune -f || true'
        }
    }
}
