pipeline {
    agent{
        label 'terraform-slave'
    }
    parameters {
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
        GOOGLE_APPLICATION_CREDENTIALS = "${WORKSPACE}/sa-key.json"
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
        sh "terraform init"
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
        sh "terraform plan"
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
        sh "terraform apply --auto-approve"
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
        sh "terraform destroy --auto-approve "
        }
    }

   
    }

 post {
    always {
         echo "*****************do clean the workspace *****************"
        cleanWs()
    }
 }




