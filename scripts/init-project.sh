#!/bin/bash
set -e

echo "Initializing new CV project..."

# Check if .env exists, if not create from template
if [ ! -f .env ]; then
    echo "Creating .env file from template..."
    cp .env.template .env
    echo "Please edit .env file with your project-specific values"
fi

# Initialize git if not already done
if [ ! -d .git ]; then
    echo "Initializing git repository..."
    git init
    git add .
    git commit -m "Initial project setup from template"
fi

echo "Project initialization complete!"
echo "Next steps:"
echo "1. Edit .env file with your project settings"
echo "2. Add your dependencies to requirements.txt"
echo "3. Run: docker-compose up --build"
