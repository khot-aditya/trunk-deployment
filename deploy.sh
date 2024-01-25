#!/bin/bash

# Function to deploy the application
deploy() {
    local environment=""
    local container_name=""
    local port=""

    case $1 in
    1)
        environment="development"
        container_name="development-container"
        port="3000"
        ;;
    2)
        environment="staging"
        container_name="staging-container"
        port="3001"
        ;;
    3)
        environment="production"
        container_name="production-container"
        port="3002"
        ;;
    *)
        echo "Invalid option. Exiting."
        exit 1
        ;;
    esac

    echo "Deploying $environment..."
    echo "Wait and watch!"

    # Pull the latest code from the main branch.
    echo "Pulling from main branch"
    git pull origin main

    echo "Building docker image"
    docker build . -t $environment
    # Build a Docker image with the corresponding tag.

    echo "Stopping & removing existing container"
    docker stop $container_name || true && docker rm $container_name || true
    # Stop and remove the existing Docker container. If the container does not exist, the command will not fail because of the || true.

    echo "Starting new container"
    docker run -p $port:80 -d --name $container_name $environment
    # Run a new Docker container from the image we just built.

    docker system prune -f
    # Remove unused data to free up space.

    echo "The application has been deployed successfully."
    docker logs -f $container_name
}

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script should be run as root"
    exit 1
fi

if [ -z "$1" ]; then
    # If no option is provided, show options and ask for input
    echo "Select deployment option:"
    echo "1. Development"
    echo "2. Staging"
    echo "3. Production"

    read -p "Enter the option number: " option
    deploy $option
else
    # If an option is provided, run the corresponding case
    deploy $1
fi
