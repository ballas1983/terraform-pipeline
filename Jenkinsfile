pipeline {
    agent {
        label 'terraform-slave'
    }

    parameters {
        choice(
            name: 'ACTION',
            choices: ['validate', 'init', 'plan', 'apply', 'destroy'],
            description: 'Select Terraform action'
        )
    }

    environment {
        GOOGLE_APPLICATION_CREDENTIALS = "${WORKSPACE}/sa-key.json"
    }

    stages {

        // Authenticate with GCP
        stage('Setup GCE Auth') {
            steps {
                withCredentials([
                    file(credentialsId: 'GCP-SA-Key', variable: 'SA_KEY')
                ]) {
                    sh '''
                        cp "$SA_KEY" "$GOOGLE_APPLICATION_CREDENTIALS"
                    '''
                }
            }
        }

        // Terraform initialization
        stage('Terraform Init') {
            when {
                expression {
                    params.ACTION == 'init'
                }
            }
            steps {
                echo "Initializing Terraform providers"
                sh 'terraform init'
            }
        }

        // Terraform validation
        stage('Terraform Validate') {
            when {
                expression {
                    params.ACTION == 'validate'
                }
            }
            steps {
                echo "Validating Terraform configuration"
                sh 'terraform init -backend=false'
                sh 'terraform validate'
            }
        }

        // Terraform plan
        stage('Terraform Plan') {
            when {
                expression {
                    params.ACTION == 'plan'
                }
            }
            steps {
                echo "Planning Terraform resources"
                sh 'terraform init'
                sh 'terraform plan'
            }
        }

        // Terraform apply
        stage('Terraform Apply') {
            when {
                expression {
                    params.ACTION == 'apply'
                }
            }
            steps {
                echo "Applying Terraform resources"
                sh 'terraform init'
                sh 'terraform apply -auto-approve'
            }
        }

        // Terraform destroy
        stage('Terraform Destroy') {
            when {
                expression {
                    params.ACTION == 'destroy'
                }
            }
            steps {
                echo "Destroying Terraform resources"
                sh 'terraform init'
                sh 'terraform destroy -auto-approve'
            }
        }
    }

    post {
        always {
            echo "Cleaning the workspace"
            cleanWs()
        }
    }
}