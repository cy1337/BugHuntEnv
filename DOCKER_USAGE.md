# Docker Usage Guide

This guide explains how to use the Bug Hunt Environment with Docker Compose.

## Quick Start

1. **Build and start the environment:**
   ```bash
   docker-compose up -d
   ```

2. **Access the interactive shell:**
   ```bash
   docker-compose exec bughunt-env bash
   ```

3. **Run the CommandServer:**
   ```bash
   # Inside the container
   ./CommandServer
   ```

4. **Stop the environment:**
   ```bash
   docker-compose down
   ```

## Available Commands

- `docker-compose up -d` - Build and start the container in detached mode
- `docker-compose exec bughunt-env bash` - Open an interactive shell
- `docker-compose logs bughunt-env` - View container logs
- `docker-compose down` - Stop and remove the container
- `docker-compose down -v` - Stop and remove the container + volumes

## Directory Structure Inside Container

- `/home/user/workspace` - Your project files (mounted from current directory)
- `/home/user/samples` - Sample binaries and firmware (mounted from ./samples)
- `/home/user/data` - Persistent storage for your work
- `/home/user/USB` - Default working directory from Dockerfile

## Pre-installed Tools

The environment includes:
- **AFL++** - Fuzzing framework
- **GDB** - GNU Debugger
- **Frida** - Dynamic instrumentation toolkit
- **OpenSSL 1.1.1f** - For crypto analysis
- **Python 3** with `lief` and `frida-tools`
- **Build tools** - GCC, Clang, CMake, etc.

## Port Access

The CommandServer runs on port 8080, which is exposed to your host machine:
- Container: `localhost:8080`
- Host: `localhost:8080`

## Tips

1. **Persistent Data**: Use `/home/user/data` for files you want to keep between container restarts
2. **Sample Files**: Place binaries to analyze in the `./samples` directory
3. **Multiple Sessions**: You can run `docker-compose exec bughunt-env bash` multiple times for multiple shells
4. **File Editing**: Use vim or emacs inside the container, or edit files on your host (they're mounted)

## Apple Silicon (M1/M2) Mac Support

✅ **Apple Silicon now supported!** The docker-compose setup includes platform specification and library fixes for M1/M2 Macs.

The setup should work out of the box, but if you encounter issues:

1. **Ensure you're using the latest docker-compose**:
   ```bash
   docker compose down
   docker compose up -d --build
   ```

2. **If Docker Desktop has issues, try Colima** (alternative Docker runtime):
   ```bash
   # Install Colima
   brew install colima
   
   # Stop Docker Desktop if running
   # Start Colima with x86_64 emulation
   colima start --arch x86_64
   
   # Then run docker-compose as normal
   docker compose up -d
   ```

3. **Last resort: Linux VM**:
   - UTM with Ubuntu 20.04/22.04
   - VMware Fusion
   - Parallels Desktop

## Troubleshooting

- **Apple Silicon issues**: See "Apple Silicon (M1/M2) Mac Support" above  
- **Library errors**: The Dockerfile now includes OpenSSL 1.1.1f library path configuration
- **"libcrypto.so.1.1 not found"**: This should be fixed automatically in newer builds
- If the build fails, try: `docker compose build --no-cache`
- If you need to reset everything: `docker compose down -v && docker compose up -d`
- Check container status: `docker compose ps`
- View logs: `docker compose logs -f bughunt-env` 