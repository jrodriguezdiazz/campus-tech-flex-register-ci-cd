pipeline {
    agent any
    tools {
        terraform 'Terraform'
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        stage('Terraform Init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform Validate') {
            steps {
                script {
                    sh 'terraform validate'
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                script {
                    sh 'terraform plan'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                script {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

//         stage('Terraform Destroy') {
//             steps {
//                 script {
//                     sh 'terraform destroy -auto-approve'
//                 }
//             }
//         }

    }
    post {
        always {
            cleanWs()
        }
    }
}
