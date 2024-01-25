#!/bin/bash

# root user check
# if [[ $EUID -ne 0 ]]; then
#     echo "This script must be run as root"
#     # If the effective user ID is not 0 (root), the script will exit.
#     exit 1
# fi

deploy() {
    case $1 in
    1)
        echo "Deploying Development..."
        echo "Wait and watch!"
        # cd /root/project/dev/backend
        # Change the current directory to the backend project directory.

        echo "Pulling from main branch"
        git clone https://github.com/khot-aditya/trunk-deployment.git .
        # Pull the latest code from the development branch.

        echo "building docker image"
        docker build . -t development
        # Build a Docker image with the tag development.

        echo "stopping & removing container"
        docker stop development-container || true && docker rm development-container || true
        # Stop and remove the existing Docker container. If the container does not exist, the command will not fail because of the || true.

        echo "starting new container"
        docker run -p 80:3001 -d --name development-container development
        # Run a new Docker container from the image we just built.

        docker system prune -f
        # Remove unused data to free up space.

        echo "The application has been deployed successfully."
        docker logs -f development-container
        # Display the logs of the new container.
        break
        ;;

    2)
        echo "Deploying Staging..."
        # Add commands for deploying web app
        ;;

    3)
        echo "Deploying Production..."
        # Add commands for deploying web app
        ;;

    *)
        echo "Invalid option. Exiting."
        exit 1
        ;;
    esac
}

if [ -z "$1" ]; then
    # If no option is provided, show options and ask for input
    echo "Select deployment option:"
    echo "1. Development"
    echo "2. Staging"
    echo "3. Production"

    read -p "Enter the option number: " option
    deploy $option
else
    # If option is provided, run the corresponding case
    deploy $@
fi
