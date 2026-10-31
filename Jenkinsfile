def commit_id
pipeline {
    agent any

    stages {
        stage('Preparation') {
            steps {
                checkout scm
                sh "git rev-parse --short HEAD > .git/commit-id"
                script {
                    commit_id = readFile('.git/commit-id').trim()
                }
            }
        }
        stage('Image Build') {
            steps {
                echo 'Building docker image....'
                sh 'scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -r -i $(minikube ssh-key) ./*  docker@$(minikube ip):~/'
                sh "minikube image build -t queue:${commit_id} ."
                echo 'image build complete'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying to Kubernetes'
                sh "sed -i -r 's|richardchesterwood/k8s-fleetman-queue:release2|queue:${commit_id}|' ./manifests/workloads.yaml"
                sh 'kubectl apply -f ./manifests/'
                sh 'kubectl get all'
                echo 'deployment complete'
            }
        }
    }
}
