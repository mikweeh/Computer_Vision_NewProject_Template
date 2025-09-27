# Docker CV Development Environment Template

A professional Docker-based template for computer vision development projects using Python 3.11 and CUDA 12.4. This template provides a standardized development environment with GPU support, X11 forwarding, and pre-configured development tools.

## Features

- **Base Image**: `mikweeh/cv-baseimage-01:latest` with Python 3.11 and CUDA 12.4
- **GPU Support**: NVIDIA GPU access with proper drivers
- **GUI Applications**: X11 forwarding for OpenCV and other GUI tools
- **Development Tools**: Pre-configured debugging and development environment
- **Volume Mounting**: Live code editing with host-container synchronization
- **Standardized Structure**: Consistent project layout for all CV projects

## Prerequisites

- Docker Desktop with Docker Compose
- NVIDIA GPU drivers (for GPU support)
- NVIDIA Container Toolkit
- X11 server (for GUI applications)
  - Linux: Built-in
  - Windows: VcXsrv or similar
  - macOS: XQuartz

## Quick Start

### 1. Create New Project from Template

**Using GitHub Web Interface:**
1. Click "Use this template" button
2. Create your new repository
3. Clone locally: `git clone https://github.com/your-username/your-project.git`

**Using GitHub CLI:**

```
gh repo create my-cv-project --public --clone --template mikweeh/docker-cv-template
cd my-cv-project
```


### 2. Initialize Project

Run the initialization script to set up your project:

```
chmod +x scripts/init-project.sh
./scripts/init-project.sh
```

### 3. Configure Environment

Edit the `.env` file with your project-specific settings:

```
PROJECT_NAME=my-cv-project
CONTAINER_DISPLAY=:1
DATASET=/path/to/your/dataset
# Optionals:
DEBUG_PORT=5678
UID=1000
GID=1000
```

### 4. Add Dependencies

Update `requirements.txt` with your project dependencies:

```
tensorflow==2.13.0
```

but take into account that the base image already has a lot of packages installed
(ultralytics, open-cv, pillow...). Check [mikweeh/py311_cu124_dockerized_development_environment](https://github.com/mikweeh/py311_cu124_dockerized_development_environment) to see the full
list of packages installed.


### 5. Build and Run

**Build and start the development environment**

```
docker-compose up -d
```

Also you can force rebuild with
```
docker compose up --build -d
docker-compose up -d
```

Or even force build without using cache
```
docker compose build --no-cache
docker-compose up -d
```

**Access the running container**

```
docker-compose exec dev_service bash
```

But I recommend you use VSCode or Cursor with DevContainers and select the
option "_Attach to running contaienr_"

**Finish session**

```
docker compose down
```

The container will be removed, but all your changes will remain in the folders
and scripts of the project outside the container. Here is where you can use
git to version control.

## Project Structure

```
your-project/
├── Dockerfile          # Container configuration
├── docker-compose.yml  # Service orchestration
├── .env                # Environment variables
├── requirements.txt    # Python dependencies
├── scripts/
│ └── init-project.sh   # Project initialization
├── src/                # Source code directory
├── dataset             # Dataset files (automatically mapped via .env)
├── .gitignore          # Git ignore rules
└── README.md           # This file
```

## Development Workflow

### Starting Development

1. Start the container: `docker-compose up -d`
2. Access container shell: `docker-compose exec dev_service bash` or "_Attach to running container_"
3. Navigate to project main folder: `cd /home/rosuser/repo`
4. Start coding in the `src/` directory

### Debugging

The container exposes port 5678 for remote debugging. Configure your IDE to connect to `localhost:5678` for remote debugging support.

### Data Management

Mount your datasets using the `DATASET` environment variable. The container will mount this path to `/home/rosuser/repo/dataset`.

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `PROJECT_NAME` | Container name prefix | `MySuperProject` |
| `CONTAINER_DISPLAY` | X11 display for GUI | `:1` |
| `DEBUG_PORT` | Remote debugging port | `5678` |
| `DATASET` | Path to dataset directory | `/path/to/dataset` |
| `UID` | User ID | `1000` |
| `GID` | Group ID | `1000` |

## GPU Support

This template includes NVIDIA GPU support. Ensure you have:

1. NVIDIA drivers installed on host (with cuda >= 12.4)
2. NVIDIA Container Toolkit configured