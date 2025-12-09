// lamacoop-jenkins - Jenkins pipeline scripts for assisting docgen automation
// Copyright (C) 2025 VES LLC
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along
// with this program; if not, write to the Free Software Foundation, Inc.,
// 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
//
// For inquiries, please contact by email:
//   info@ves.solutions
//
// Or if you prefer, by paper mail:
//   VES LLC
//   6180 Guardian Gtwy, Ste 102
//   Aberdeen Proving Ground, MD 21005

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
