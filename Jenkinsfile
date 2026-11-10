// pipeline {
//     agent {
//         label 'terraform-slave'
//     }

//     parameters {
//         choice(
//             name: 'ACTION',
//             choices: ['validate', 'init', 'plan', 'apply', 'destroy'],
//             description: 'Select Terraform action'
//         )
//     }

//     environment {
//         GOOGLE_APPLICATION_CREDENTIALS = "${WORKSPACE}/sa-key.json"
//     }

//     stages {

//         // Authenticate with GCP
//         stage('Setup GCE Auth') {
//             steps {
//                 withCredentials([
//                     file(credentialsId: 'GCP-SA-Key', variable: 'SA_KEY')
//                 ]) {
//                     sh '''
//                         cp "$SA_KEY" "$GOOGLE_APPLICATION_CREDENTIALS"
//                     '''
//                 }
//             }
//         }

//         // Terraform initialization
//         stage('Terraform Init') {
//             when {
//                 expression {
//                     params.ACTION == 'init'
//                 }
//             }
//             steps {
//                 echo "Initializing Terraform providers"
//                 sh 'terraform init'
//             }
//         }

//         // Terraform validation
//         stage('Terraform Validate') {
//             when {
//                 expression {
//                     params.ACTION == 'validate'
//                 }
//             }
//             steps {
//                 echo "Validating Terraform configuration"
//                 sh 'terraform init -backend=false'
//                 sh 'terraform validate'
//             }
//         }

//         // Terraform plan
//         stage('Terraform Plan') {
//             when {
//                 expression {
//                     params.ACTION == 'plan'
//                 }
//             }
//             steps {
//                 echo "Planning Terraform resources"
//                 sh 'terraform init'
//                 sh 'terraform plan'
//             }
//         }

//         // Terraform apply
//         stage('Terraform Apply') {
//             when {
//                 expression {
//                     params.ACTION == 'apply'
//                 }
//             }
//             steps {
//                 echo "Applying Terraform resources"
//                 sh 'terraform init'
//                 sh 'terraform apply -auto-approve'
//             }
//         }

//         // Terraform destroy
//         stage('Terraform Destroy') {
//             when {
//                 expression {
//                     params.ACTION == 'destroy'
//                 }
//             }
//             steps {
//                 echo "Destroying Terraform resources"
//                 sh 'terraform init'
//                 sh 'terraform destroy -auto-approve'
//             }
//         }
//     }

//     post {
//         always {
//             echo "Cleaning the workspace"
//             cleanWs()
//         }
//     }
// }

pipeline {
    agent{
        label 'terraform-slave'
    }
    parameters {
         choice(
            name: 'ACTION',
            choices: ['dev', 'test', 'prod', 'stage'],
            description: 'Choose any one Environment to deploy:'
        ) 
        
        choice(
            name: 'ACTION',
            choices: ['validate', 'init', 'plan', 'apply', 'destroy'],
            description: 'Terraform action'
        )
    }
    
    // parameters{
    //     choice(
    //         name:'ACTION'
    //         choices: 'validate\ninit\nplan\napply\ndestroy'
    //     )
    // }
    environment {
        GCS_BUCKET = "seraphic-shell-511217-r6-kn-bucket"
        
        GOOGLE_APPLICATION_CREDENTIALS = "${WORKSPACE}/sa-key.json"
        TFVARS_FILES = "${params.ENVIRONMENT}.tfvars"
    }
    stages{
        stage ('Setup GCE Auth') {
            steps{
                withCredentials([file(credentialsId: 'GCP-SA-Key', variable: 'SA_KEY')]) {
                 // some block
                 sh '''
                     cp $SA_KEY $GOOGLE_APPLICATION_CREDENTIALS
                 '''
                }
            }
        }
        

       // initialize the terraform
    stage ('init') {
        steps{
        echo "intialize the terraform providers"
        //sh "terraform init"
        //sh "terraform init --backend-config="bucket=${env.GCS_BUCKET}" --backend-config="prefix=${params.ENVIRONMENT}" "
        sh """
        terraform init --backend-config="bucket=${env.GCS_BUCKET}" --backend-config="prefix=${params.ENVIRONMENT}" 
        """
    }
    }

    //terraform plan
    stage ('plan'){
        when {
            expression {
                params.ACTION =='plan'
            }
        }
        steps{
        echo"Planning the terraform resources"
        sh "terraform plan -var-file=${env.TFVARS_FILES}"
    }
    }
    //terraform apply
    stage ('apply'){
        when {
            expression {
                params.ACTION =='apply'
            }
        }
        steps{
        echo"Applying the terraform resources"
        sh "terraform apply  -var-file=${env.TFVARS_FILES} --auto-approve"
    }
    }
    //terraform destroy
    stage ('destroy'){
        when {
            expression {
                params.ACTION =='destroy'
            }
        }
        steps{
        echo "Destroying the terrform resouces"
        sh "terraform destroy  -var-file=${env.TFVARS_FILES} --auto-approve"
        }
    }

   
    }

 post {
    always {
         echo "*****************do clean the workspace *****************"
        cleanWs()
    }
 }
}