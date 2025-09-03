pipeline {
    agent any

    environment {
        TF_VAR_region = 'ap-southeast-1'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sharathchandra-sai/POC-15.git'
            }
        }

        stage('Terraform Init & Apply') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'Aws-creds', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    dir('terraform') {
                        sh '''
                            export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                            export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                            terraform init
                            terraform apply -auto-approve
                        '''
                    }
                }
            }
        }

        
        stage('Build Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    dir('app') {
                        sh '''
                            echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                            docker build -t sharathkodati/sharathproject-1 .
                            docker push sharathkodati/sharathproject-1
                        '''
                    }
                }
            }
        }


        stage('Deploy to Kubernetes') {
            steps {
                dir('k8s') {
                    sh 'kubectl apply -f deployment.yaml'
                    sh 'kubectl apply -f service.yaml'
                }
            }
        }
    }
}
