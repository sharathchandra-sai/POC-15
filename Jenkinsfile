pipeline {
    agent any

    environment {
        TF_VAR_region = 'ap-southeast-1'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/sharathchandra-sai/POC-15.git'
            }
        }

        stage('Terraform Init & Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('app') {
                    sh 'docker build -t sharathkodati/sharathproject-1 .'
                    sh 'docker push sharathkodati/sharathproject-1'
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
