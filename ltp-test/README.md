# LAMACOOP-32 Jenkins LTP Testing
In order to verify the integrity of our kernel, we run the Linux Test Project (LTP) to verify the kernel's integrity.

## Differences Between Base Testing and Jenkins
Several changes were made to how the testing environment was built to be compatible with Jenkins.
### Buildroot
Because the Jenkins agent cannot use the `make menuconfig` command to define our configuration for buildroot, we use a pre-built `.config`
file following the process outlined in the LTP Confluence guide. Jenkins builds this configuration in this environment with `make savedefconfig`. 

Our `.config` file is configured to build off the Linux 6.14.8 headers, which may conflict with the most up-to-date headers provided
by buildroot. To offset this, we append the hash for these headers to the `linux.hash` file created when pulling the git repo. 

Additionally, Jenkins can't directly interact with the QEMU VM we create to run and test the kernel. To combat this, the init script we use
to setup the VM can be used to automatically run the LTP with the parameters we give it. 

**If you want to change the test suite running on the LTP**, you will need to change the parameters passed to LTP in the init file. 

### QEMU Virtualization
As mentioned previously, we run QEMU with an init script specfically designed to create the virutal environment with our kernel,
run the LTP on it, and immediately shut down. This is to ensure Jenkins can successfully go through the automated testing
process without stalling on the QEMU VM or cause other issues with the Jenkins service. 

## Testing This Build
If you're looking to specifically test this version of our testing environment, you can follow the Confluence guide up until you create your buildroot instance.
Rather than using `make menuconfig`, use the `.config` file included with this repo and use the `make savedefconfig` command to configure buildroot. 
Additionally, you will need to add the following lines to your `init` file:
```bash
cd /mnt
./runltp [-f TESTSUITE]
poweroff -f
```
The first two commands navigate us into the LTP directory and run the LTP. The optional -f flag can specify which test suite we want the LTP to run. 
Without this flag, the LTP will run the full suite of tests, which will take approximately 4 hours on our Jenkins agent. It is preferred to either
run one of the premade test suites (e.g. syscalls) or create our own. 

You can find a list of premade test suites included in the `runtest` directory. If you desire to run multiple test suites, you can pass a list of test suites separated by commas to `runltp`

```bash
$ ./runltp -f syscalls,tracing -g output.html
```

To view the results, you can either mount the ltp.img file created earlier in the build stages, or manually unpack the `output` and `results` directories using 7zip:
```bash
$ 7z x ltp.img results output -o"ltp_results"
```

