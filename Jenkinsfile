pipeline {
    agent(
        label 'terraform-slave'
    )
    stage ('init') {
        step{
        echo "intialize the terraform providers"
        //terraform init
    }
    }
    stage('plan'){
        step{
        echo"Planning the terraform resources"
        //terraform plan
    }
    }
    stage('apply'){
        step{
        echo"Applying the terraform resources"
        //terraform apply
    }
    }
    stage('destroy'){
        step{
        echo "Destroying the terrform resouces"
        //terraform destroy
        }
    }
}