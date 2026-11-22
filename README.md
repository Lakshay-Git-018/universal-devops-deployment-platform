# Universal DevOps Deployment Platform (UDDP)

A lightweight DevOps project that demonstrates Docker containerization, continuous integration, automated local deployment, and application health monitoring using a demo learning platform called **LearnHub**.

## 1. Project Overview

The Universal DevOps Deployment Platform (UDDP) is a company-style DevOps simulation project developed to demonstrate a repeatable application deployment and monitoring workflow.

The project uses LearnHub, a static learning website, as its demo application.

The main objective is to simplify application deployment, validate Docker image builds, and monitor application availability.

**Project Details**

| Item | Description |
|---|---|
| Project Name | Universal DevOps Deployment Platform |
| Project ID | UDDP-001 |
| Demo Application | LearnHub |
| Role | DevOps Intern (Simulation) |
| Deployment Environment | Local |
| Operating System | Ubuntu on WSL |
| Repository | GitHub |

## 2. Project Objectives

- Build and maintain a demo web application.
- Manage source code using Git and GitHub.
- Containerize the application using Docker.
- Build and validate Docker images through GitHub Actions.
- Automate local application deployment using Bash.
- Monitor Docker container status and website availability.
- Record monitoring results in log files.

## 3. Technologies Used

| Technology | Purpose |
|---|---|
| Ubuntu (WSL) | Linux development environment |
| Git | Version control |
| GitHub | Source code hosting |
| HTML and CSS | LearnHub website |
| Docker | Application containerization |
| Nginx | Web server |
| GitHub Actions | Continuous integration |
| Bash | Deployment and monitoring automation |
| curl | HTTP health checks |

## 4. Project Architecture

The project follows this workflow:

1. Application source code is maintained in the GitHub repository.
2. GitHub Actions runs when code is pushed to the main branch or a pull request targets it.
3. The CI workflow builds and validates the Docker image.
4. The local deployment script builds the image and starts the LearnHub container.
5. The monitoring script checks container status and website availability.
6. Monitoring results are saved in a local log file.

## 5. Repository Structure

```text
universal-devops-deployment-platform/
│
├── .github/
│   └── workflows/
│       └── docker-ci.yml
│
├── app/
│   └── index.html
│
├── config/
│
├── docker/
│   └── Dockerfile
│
├── docs/
│
├── scripts/
│   ├── deploy.sh
│   └── monitor.sh
│
├── logs/
│   └── monitoring.log       # Generated locally
│
├── .gitignore
└── README.md
```

## 6. Docker Containerization

The application is packaged using a Dockerfile based on the lightweight Nginx Alpine image.

The Dockerfile:

- Uses `nginx:alpine` as the base image.
- Copies the LearnHub application files into the Nginx web directory.
- Exposes port 80.
- Starts the Nginx web server.

Build the Docker image manually:

```bash
docker build -f docker/Dockerfile -t learnhub:1.0 .
```

## 7. Continuous Integration (CI)

The project uses GitHub Actions for Docker image build validation.

Workflow file:

```text
.github/workflows/docker-ci.yml
```

The workflow:

1. Checks out the repository source code.
2. Builds the Docker image.
3. Inspects the generated Docker image.
4. Reports successful image validation.

The workflow runs on pushes to the `main` branch and pull requests targeting `main`.

**Note:** This workflow implements continuous integration (CI). It does not automatically deploy to the local machine.

## 8. Automated Local Deployment

The project includes a Bash deployment script:

```text
scripts/deploy.sh
```

The script performs the following operations:

1. Builds the Docker image.
2. Removes the existing LearnHub container if present.
3. Creates and starts a new container.
4. Maps host port 8080 to container port 80.
5. Configures the container to restart unless stopped.
6. Checks application availability using curl.

### Deploy LearnHub

From the project root directory, run:

```bash
chmod +x scripts/deploy.sh
./scripts/deploy.sh
```

Expected success message:

```text
SUCCESS: LearnHub deployed successfully!
```

### Access the application

Open the following address in your browser:

```text
http://localhost:8080
```

## 9. Application Monitoring and Health Checks

The project includes a Bash monitoring script:

```text
scripts/monitor.sh
```

The script checks:

- Whether the LearnHub Docker container is running.
- Whether the website responds successfully over HTTP.
- The HTTP response code.
- The date and time of each monitoring check.

It also saves monitoring results to:

```text
logs/monitoring.log
```

### Run the monitoring script

```bash
chmod +x scripts/monitor.sh
./scripts/monitor.sh
```

### View monitoring logs

```bash
cat logs/monitoring.log
```

### Example healthy application output

```text
Container Status: RUNNING
Website Status: ONLINE
HTTP Response: 200
Monitoring results saved.
```

### Example failure output

```text
Container Status: NOT RUNNING
Website Status: OFFLINE
HTTP Response: 000
Monitoring results saved.
```

The log file is generated locally and excluded from Git using `.gitignore`.

## 10. Testing and Validation

The project has been tested through the following scenarios:

| Test | Expected Result | Actual Result |
|---|---|---|
| Docker image build | Successful | Passed |
| GitHub Actions CI | Successful build and validation | Passed |
| Automated deployment | Application deployed | Passed |
| Container status check | RUNNING | Passed |
| Website HTTP check | 200 OK | Passed |
| Container failure detection | NOT RUNNING | Passed |
| Website failure detection | OFFLINE | Passed |
| HTTP failure response | 000 | Passed |
| Application recovery | RUNNING / ONLINE | Passed |
| Monitoring log generation | Log entry saved | Passed |

## 11. Project Limitations

The current implementation is a local deployment prototype.

- Deployment is performed on the local Ubuntu environment.
- GitHub Actions validates Docker image builds but does not perform automatic deployment.
- Monitoring uses a Bash script rather than a dedicated monitoring platform.
- The project does not currently include cloud infrastructure or Kubernetes.
- Monitoring results are stored in local log files.

## 12. Future Scope

Possible future improvements, outside the current completed project scope, include:

- Cloud-based deployment.
- Automated deployment triggered by successful CI.
- Advanced monitoring and alerting.
- Environment-specific configuration.
- Container orchestration.

## 13. Author and Repository

**Project:** Universal DevOps Deployment Platform

**Demo Application:** LearnHub

**GitHub Repository:**

https://github.com/Lakshay-Git-018/universal-devops-deployment-platform

---

