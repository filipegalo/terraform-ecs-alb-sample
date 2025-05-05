# terraform-ecs-alb-sample

This repository contains the infrastructure code for deploying a Flask application on AWS ECS with an Application Load Balancer (ALB). The infrastructure is managed using Terraform and is organized in a modular way to support both development and production environments.

![Image of the architecture](https://github.com/filipegalo/terraform-ecs-alb-sample/blob/main/AWS_Diagram.png?raw=true)

## Repository Structure

```
.
├── application/          # Flask application code (see application/README.md)
├── dev/                 # Development environment infrastructure
├── global/              # Global/shared infrastructure resources
├── setup.sh            # Infrastructure deployment script
└── AWS_Diagram.png     # Architecture diagram
```

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform (latest version)
- Docker
- Python 3.12+ (for local development)

## Infrastructure Setup

The infrastructure is organized into numbered directories (e.g., 001, 002) within the `dev` and `global` folders. This numbering system ensures resources are created in the correct order.

### Deployment Script

The `setup.sh` script provides a convenient way to manage the infrastructure:

```bash
# Apply all infrastructure (dev and global)
./setup.sh apply all

# Apply only development environment
./setup.sh apply dev

# Apply only global resources
./setup.sh apply global

# Destroy all infrastructure
./setup.sh destroy all
```

The script automatically:

- Processes directories in ascending order for `apply` and descending order for `destroy`
- Initializes Terraform in each directory
- Applies or destroys the infrastructure with auto-approval

## Application

For detailed information about the Flask application, including local development setup, API endpoints, and deployment instructions, please refer to [application/README.md](application/README.md).

## Architecture

The infrastructure includes:

- VPC with public and private subnets
- ECS Cluster with Fargate tasks
- Application Load Balancer
- RDS PostgreSQL database
- Security groups and IAM roles
- CloudWatch logging

Refer to `AWS_Diagram.png` for a visual representation of the architecture.

## Security Considerations

- All sensitive data should be managed through AWS Secrets Manager
- IAM roles follow the principle of least privilege
- Network security is enforced through security groups and NACLs
- Database access is restricted to the ECS tasks

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the WTFPL License. See the [LICENSE](LICENSE) file for details.
