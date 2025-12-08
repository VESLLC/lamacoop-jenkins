# LAMACOOP Jenkins Automation Toolkit

A lightweight set of Jenkins automation utilities designed to streamline
CI/CD processes, system preparation, configuration updates, and automated
test execution. This toolkit includes helper scripts and a Jenkinsfile that
tie together build, test, and deployment operations.

All scripts are designed to be minimal, portable, and easy to integrate into
existing pipelines.

## Features

- Automated environment preparation
- Dynamic configuration updates
- Integrated Jenkins pipeline
- Make-style wrapper
- LTP Test Integration

## Getting Started

### Prerequisites

- Linux environment (Debian/Ubuntu/RHEL recommended)
- Jenkins node or controller with shell execution capability
- Bash 4.x+
- sudo permissions (for preparation scripts)

## Usage

### Run environment preparation

Grabs the Linux CIP kernel

```sh
./prepare.sh
```

### Configure a target file

Enables ftrace, kprobes, etc.

```sh
./configTheFile.sh <source_file> <destination_file> <variable_values>
```

### Use the make wrapper

Builds the kernel with the new config file.

```sh
./make.sh <command>
```

### Execute LTP tests

Inside the `ltp-test` directory:

```sh
./run-ltp.sh
```

## Jenkins Pipeline

The `Jenkinsfile` includes stages such as:

- Checkout  
- Preparation  
- Build / Test  
- LTP test execution  
- Post-build cleanup & reporting  

You can drop this repository directly into a Jenkins job or
pipeline to enable the automation flow.

## License

GPL2
