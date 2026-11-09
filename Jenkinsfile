pipeline {
    agent{
        label 'terraform-slave'
    }
    parameters{
        choice(
            name:'ACTION'
            choices: 'validate\ninit\nplan\napply\ndestroy'
        )
    }
    stages{
        //initialize the terraform
    stage ('init') {
        steps{
        echo "intialize the terraform providers"
        //terraform init
    }
    }
    stage ('plan'){
        steps{
        echo"Planning the terraform resources"
        //terraform plan
    }
    }
    stage ('apply'){
        steps{
        echo"Applying the terraform resources"
        //terraform apply
    }
    }
    stage ('destroy'){
        steps{
        echo "Destroying the terrform resouces"
        //terraform destroy
        }
    }
}
}