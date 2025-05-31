pipeline {
    agent any
    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/YASASHWI70/Restaurant-Webpage.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t restaurant-app .'
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    // Optional cleanup of previous container
                    sh 'docker rm -f restaurant-container || true'

                    // Run the new container
                    sh 'docker run -d -p 80:3000 --name restaurant-container restaurant-app'
                }
            }
        }
    }
}
