// NOTE This is a fairly simple script, it retrieves a particular version of the cip kernel, 6.1, makes a default config, and modifies the .config file to enable ftrace. 
// NOTE Once this is complete compilation is completed with the yes command which simply passes "" to every prompt as we want the default values.
// NOTE This has become for demonstrative purposes, while the code is fully functional, the build machines do not have Bison in the path, which is not something which needs to change at this time
pipeline {
    agent any

    stages {
        stage('Prepare') {
            steps {

                sh '''
                    chmod u+x prepare.sh configTheFile.sh make.sh
                    ./prepare.sh
                    '''

            }    
        }

        stage('Configure Build')
        {
            steps {
                script
                    {
                        sh ''' 
                            ./configTheFile.sh
                            '''
                    }
            }
        }
        stage('Build') {
	    // NOTE These instructions can specifically be run through a container, by specifying the container to run them, look at https://www.jenkins.io/doc/book/pipeline/syntax/ for more details
            steps {
                sh '''
                    ./make.sh
		           '''
            }
        }
    }
    post {
        success {
            sh '''
                  mkdir linux-cip-image
                  cd linux-cip-image
                  cp ../linux-cip/arch/x86/boot/bzImage .
                  sha256sum ./bzImage > checksum
                  cd ..
                  zip -r linux.zip linux-cip-image
                '''
            archiveArtifacts(artifacts: 'linux.zip')
        }
    }
}
