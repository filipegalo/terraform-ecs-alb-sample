# Flask ECS ALB Application

A Flask application with PostgreSQL database integration, designed to run on AWS ECS with ALB.

## Features

- RESTful API endpoints for product management
- PostgreSQL database integration
- Flask-Migrate for database migrations
- Docker containerization
- AWS ECS and ALB deployment ready

## Prerequisites

- Python 3.12+
- Docker
- PostgreSQL
- AWS CLI (for cloud deployment)

## Local Development Setup

1. Create and activate a virtual environment:

```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

2. Install dependencies:

```bash
pip install -r requirements.txt
```

3. Set up environment variables:

```bash
# Edit .flaskenv with your configuration
```

4. Run PostgreSQL locally:

```bash
docker run -d --name postgres-test \
  -p 5434:5432 \
  -e POSTGRES_USER=db_user \
  -e POSTGRES_PASSWORD=yourpassword \
  -e POSTGRES_DB=mydb \
  postgres:17
```

5. Initialize the database:

```bash
flask db upgrade
```

6. Run the application:

```bash
flask run
```

## Environment Variables

Required environment variables:

```
DB_HOST=localhost
DB_PORT=5434
DB_NAME=mydb
DB_USER=db_user
DB_PASSWORD=yourpassword
ENVIRONMENT=dev
ENVIRONMENT_TYPE=dev
```

## API Endpoints

- `GET /api/products` - List all products

## Docker Deployment

1. Build the Docker image:

```bash
docker build -t dummy_app:latest -f Dockerfile .
```

2. Run the container:

```bash
docker run -d \
  -p 8000:8000 \
  -e DB_HOST=host.docker.internal \
  -e DB_PORT=5434 \
  -e DB_NAME=mydb \
  -e DB_USER=db_user \
  -e DB_PASSWORD=yourpassword \
  dummy_app
```

## Database Migrations

- Create a new migration:

```bash
flask db migrate -m "description of changes"
```

- Apply migrations:

```bash
flask db upgrade
```

- Rollback migrations:

```bash
flask db downgrade
```

## ECR Image Push

```bash
docker tag dummy_app:latest 123456789012.dkr.ecr.eu-central-1.amazonaws.com/dummy_app:latest
docker push 123456789012.dkr.ecr.eu-central-1.amazonaws.com/dummy_app:latest
```
