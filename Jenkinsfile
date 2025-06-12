pipeline {
    agent any

    environment {
        AWS_REGION         = 'ap-south-1'
        AWS_ACCOUNT_ID     = '343218198881'
        ECR_REPOSITORY     = 'testwebsite'
        EC2_SSH_USER       = 'ubuntu'
        EC2_HOST           = 'ec2-13-204-21-240.ap-south-1.compute.amazonaws.com'
        SSH_CREDENTIALS_ID = 'ec2-ssh-key'
    }

    stages {
        stage('Run test_restaurant') {
            steps {
                build job: 'test_restaurant', wait: true
            }
        }

        stage('Run test_restaurant_back') {
            steps {
                build job: 'test_restaurant_back', wait: true
            }
        }

        stage('Run test_res2 (frontend)') {
            steps {
                build job: 'test_res2', wait: true
            }
        }

        stage('Run res_back2 (backend)') {
            steps {
                build job: 'res_back2', wait: true
            }
        }

        stage('Connect Frontend and Backend Containers') {
            agent { label 'linux' }
            steps {
                sshagent(credentials: [env.SSH_CREDENTIALS_ID]) {
                    script {
                        def connectScript = '''
                            set -e

                            # Create user-defined network if not exists
                            if ! docker network ls --format '{{.Name}}' | grep -w restaurant-net > /dev/null; then
                                docker network create restaurant-net
                            fi

                            # Connect frontend container to network if not already connected
                            if ! docker network inspect restaurant-net | grep -q restaurant_frontend; then
                                docker network connect restaurant-net restaurant_frontend || true
                            fi

                            # Connect backend container to network if not already connected
                            if ! docker network inspect restaurant-net | grep -q restaurant-backend; then
                                docker network connect restaurant-net restaurant-backend || true
                            fi

                            echo "Frontend and backend containers connected on network restaurant-net"
                        '''

                        sh "ssh -o StrictHostKeyChecking=no ${env.EC2_SSH_USER}@${env.EC2_HOST} '${connectScript}'"
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Master pipeline succeeded: All pipelines ran and containers connected!"
        }
        failure {
            echo "Master pipeline failed: Check downstream jobs and container network connection."
        }
    }
}
