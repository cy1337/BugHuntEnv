# Disclaimer
This repo has been built and only tested on _my_ M1 Max for this class. USE AT YOUR OWN RISK.

# A Basic Guide to Bug Hunting with Ghidra

This repo contains details on the environment needed to run some of the classroom examples.

In addition to installing Ghidra with the instructions from [the installation guide](https://htmlpreview.github.io/?https://github.com/NationalSecurityAgency/ghidra/blob/stable/GhidraDocs/InstallationGuide.html) you will need a Linux shell available for participating in hands on labs.

## Windows
A suitable Linux envionment can be installed via Windows Subsystem for Linux with:
```
wsl --install -d Ubuntu-20.04
```
Clone this repo from within that environment and run `setup.sh`:
```
git clone https://github.com/cy1337/BugHuntEnv.git
cd BugHuntEnv
./setup.sh
```

## macOS
A Docker container has been published to Dockerhub `cy1337demos/bughuntenv` or can be built with the Dockerfile in this repo. 

**Easy Option**: Use Docker Compose (recommended):
```bash
git clone https://github.com/cy1337/BugHuntEnv.git
cd BugHuntEnv
docker-compose up -d
docker-compose exec bughunt-env bash
```

See [DOCKER_USAGE.md](DOCKER_USAGE.md) for detailed Docker instructions.

**✅ Apple Silicon (M1/M2) Supported**: The Docker Compose setup now works on Apple Silicon Macs with proper x86_64 emulation and library configuration.

## Linux
The `setup.sh` in this repo can be used to install the appropriate tools and libraries on an existing Ubuntu Linux system. Feel free to configure a different distro as long as you can ultimately run `CommandServer` from this repo.

# Verification

Run `CommandServer` to verify that the environment works. You are done if it gives a message that it is listening for connections. Please contact me if it complains about missing or mismatched libraries.
```
$ ./CommandServer
Server is listening on port 8080
Waiting for a new connection...
^C
```
