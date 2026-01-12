# Samples Directory

This directory is mounted into the Docker container at `/home/user/samples` and is intended for:

- Binary files you want to analyze
- Firmware images for reverse engineering
- Sample programs for testing AFL++ fuzzing
- Any other files you want to examine with the bug hunting tools

## Usage

Place your binary files here and they'll be accessible inside the container for analysis with:
- Ghidra (external tool)
- GDB
- AFL++
- Frida
- Other reverse engineering tools installed in the environment

The files in this directory will persist between container restarts. 