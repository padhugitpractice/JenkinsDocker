pipeline{
	agent  any
stages{
    stage('GIT'){
		steps{
        git 'https://github.com/padhugitpractice/JenkinsDocker.git'
		}
    }
    stage('Maven'){
	steps{
        sh 'mvn clean package'
		}
    }
    stage('Nexus'){
	steps{
        nexusArtifactUploader artifacts: [[artifactId: 'vprofile-v1', classifier: '', file: 'target/vprofile-v1.war', type: 'war']], credentialsId: '0377a70b-d184-4f2e-b68c-2d343dd79cd0', groupId: 'vprofile-v1', nexusUrl: '13.232.47.60:8081/nexus', nexusVersion: 'nexus2', protocol: 'http', repository: 'today', version: '$BUILD_ID'
		}
	}
    stage('Tomcat'){
		steps{
        deploy adapters: [tomcat8(credentialsId: 'aa749fd3-0f65-4e21-8706-0db6b7cf1a8c', path: '', url: 'http://13.233.108.54:8080')], contextPath: null, war: '**/*.war'
		}
	}
    stage('Docker Image'){
	steps{
        sh "docker build -t padhudockerpractice/today ."
		}
	}
    stage('Docker Hub'){
	steps{
        withCredentials([string(credentialsId: 'Docker', variable: 'Docker')]) {
        sh "docker login -u padhudockerpractice -p${Docker}"
    }
        sh "docker push padhudockerpractice/today"
		}
	}
    stage('Ansible With k8s'){
	steps{
        sshPublisher(publishers: [sshPublisherDesc(configName: 'Ansible', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'ansible-playbook /home/ubuntu/playbooks/nginx.yml', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '/home/ubuntu', remoteDirectorySDF: false, removePrefix: '/home/ubuntu/playbooks', sourceFiles: '/home/ubuntu/playbooks/nginx.yml')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
		}
	}
	}
}
