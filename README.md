2. Install the package and dependencies:
```bash
pip install -e .
```

3. Install test dependencies (optional):
```bash
pip install -e ".[test]"
```

### Docker Setup
1. Build the Docker image:
```bash
docker build -t sherparr .
```

2. Run the container:
```bash
docker run -d -p 8000:8000 sherparr
```

## Running the Application

### Local Development
Start the application using uvicorn:
```bash
uvicorn backend.main:app --reload
```

### Docker
The application will start automatically when running the container.

The API will be available at:
- Health endpoint: http://127.0.0.1:8000/health
- Hello endpoint: http://127.0.0.1:8000/hello

## API Documentation

FastAPI provides automatic API documentation:
- Swagger UI: http://127.0.0.1:8000/docs
- ReDoc: http://127.0.0.1:8000/redoc

## Running Tests

To run the tests:
```bash
pytest
```

## API Endpoints

- `GET /health` - Returns the health status of the API
  - Response: `{"status": "OK"}`

- `GET /hello` - Returns a hello message
  - Response: `{"message": "hello"}`

## Docker Commands

### Build for multiple architectures
```bash
docker buildx build --platform linux/amd64,linux/arm64 -t sherparr .
```

### Development Build
```bash
# Build with development features
docker build -t sherparr:dev .

# Run with hot reload
docker run -d -p 8000:8000 -v $(pwd)/backend:/app sherparr:dev
```

The Dockerfile features:
1. Multi-stage build to reduce final image size
2. Uses Python 3.9 slim base image for smaller size
3. Proper handling of dependencies installation
4. Support for both ARM and AMD64 architectures
5. Security best practices (non-root user, minimal base image)
6. Proper environment variable configuration
7. Clear separation of build and runtime stages

To use the Docker setup:
1. Build the image: `docker build -t sherparr .`
2. Run the container: `docker run -d -p 8000:8000 sherparr`
3. Access the API at http://localhost:8000

The application will be accessible on port 8000 both locally and in Docker.

## CI/CD

This project uses GitHub Actions for continuous integration and deployment:

- On every push and pull request:
  - Runs tests
  - Builds Docker image
  - Pushes to Docker Hub (only on main branch)

- On release:
  - Builds and tags Docker image with release version
  - Pushes to Docker Hub

### Required Secrets

The following secrets need to be set in your GitHub repository:

- `DOCKERHUB_USERNAME`: Your Docker Hub username
- `DOCKERHUB_TOKEN`: Your Docker Hub access token 