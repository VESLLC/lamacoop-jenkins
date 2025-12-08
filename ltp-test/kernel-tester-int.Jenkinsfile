/*  LTP Test Pipeline

    Jenkinsfile with test pipeline for LAMACOOP. Compiles/builds buildroot fs
    and LTP to run on the kernel built in previous Jenkins job. 
 */

pipeline {
    agent any

    environment {
        QEMU = '/usr/bin/qemu-system-x86_64'
    }

    stages {
        stage('Prepare') {
            steps {
                copyArtifacts fingerprintArtifacts: true, projectName: 'kernel-builder-int', selector: lastSuccessful(), target: 'artifacts'

                sh '''
                    git clone --depth 1 https://github.com/linux-test-project/ltp.git
                    git clone --depth 1 https://gitlab.com/buildroot.org/buildroot.git
                    unzip artifacts/linux.zip -d .
                    cd linux-cip-image
                    ls
                    sha256sum bzImage
                    sha256sum --check checksum
                    cd ..

                    touch ltp.img
                    truncate -s 5g ltp.img
                '''
            }
            
        }

        /*  We replace the default config for buildroot using a premade file
            During the initial buildroot pull, different hashes are downloaded for
            kerel headers. We manually append the Linux 6.14.8 header hash so
            the build doesn't fail on Jenkins. 
         */
        stage('Configure') {
            steps {
                sh '''
                    ls
                    cd ltp
                    make autotools
                    ./configure
                    
                    cd ../buildroot
                    cp ../ltp-test/.config .
                    make savedefconfig
                    echo "sha256  62b12ecd3075a357eb320935657de84e01552803717dad383fa7cc3aa4aa2905  linux-6.14.8.tar.xz" >> ./linux/linux.hash
                    echo "sha512  ed5f2f4c6ed2c796fcf2c93707159e9dbd3ddb1ba063d549804dd68cdabbb6d550985ae1c8465ae9a336cfe29274a6eb0f42e21924360574ebd8e5d5c7c9a801  gcc-13.3.0.tar.xz" >> ./package/gcc/gcc.hash
                    
                    mkdir overlay
                    cp ../ltp-test/init ./overlay
                    chmod +x ./overlay/init
                '''
            }
            
        }

        stage('Build-buildroot') {
            steps {
                sh '''
                    WD=$(pwd)

                    cd buildroot
                    make -j$(nproc) 
                    cd output/images
                    cp rootfs.cpio.gz $WD
                '''
            }
        }

        stage('Build-LTP') {
            steps {
                sh '''
                    WD=$(pwd)

                    cd ltp
                    make -j$(nproc)
                    make DESTDIR=$WD/ltp install -j$(nproc)

                    mke2fs -d ./opt/ltp $WD/ltp.img -t ext4
                '''
            }
            
        }

        stage('Test') { 
            steps {
                    sh '''
                        ${QEMU} -kernel ./linux-cip-image/bzImage -nographic -append "root=/dev/hda console=ttyS0" -initrd rootfs.cpio.gz -m 4096 --drive file=./ltp.img,format=raw,media=disk --no-reboot
                    '''
            }
            
        }
    }

    post {
        success {
            sh '''
                ls
                7z x ltp.img results output -o./ltp_results
                ls
                tar -cvf ltp_results.tar ltp_results
                gzip ltp_results.tar
            '''
            archiveArtifacts(artifacts: 'ltp_results.tar.gz')
        }
        cleanup {
            cleanWs(deleteDirs: true,
                    disableDeferredWipeout: true)
        }
    }

}
