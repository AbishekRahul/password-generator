pipeline {
    agent{
        dockerfile true
    }
    stages{
        stage('Initialize') {
            def dockerHome = tool 'docker'
            env.PATH = "${dockerHome}/bin:${env.PATH}"
            }
        stage('Build') {
            steps {
                withAWS(credentials: '934ebe76-23c0-45ac-b05b-5eef4f88b7e1', region: 'ap-south-1') {
                    echo "First step - Building Docker image"
                    sh 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 351683513509.dkr.ecr.ap-south-1.amazonaws.com'
                    sh 'docker build --tag pass-gen .'
                    echo 'Built the image'  
                    }
                }
            }
        stage('Push Image') {
            steps { 
                    sh 'docker tag pass-gen:latest 351683513509.dkr.ecr.ap-south-1.amazonaws.com/pass-gen:latest'
                    sh 'docker push 351683513509.dkr.ecr.ap-south-1.amazonaws.com/pass-gen:latest'
                }
           }
        }
    }