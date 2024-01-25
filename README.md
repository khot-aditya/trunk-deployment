# Trunk Based Workflow

Trunk-based development is a version control management practice where developers merge small, frequent updates to a core “trunk” or main branch. Since it streamlines merging and integration phases, it helps achieve CI/CD and increases software delivery and organizational performance.

## Usage Commands

- Run deploy.sh command to show available options

  ```bash
  deploy.sh
  ```

- Select options for deployment

  ```bash
  Select deployment option:
  1. Development
  2. Staging
  3. Production
  Enter the option number:
  ```

- Once it is selected the docker will create new image
  for selected environment and run docker container on specified port.

# Todo

- Add option for instant rollback
- Add option to rollback to particular hash

# Source

- https://www.atlassian.com/continuous-delivery/continuous-integration/trunk-based-development
