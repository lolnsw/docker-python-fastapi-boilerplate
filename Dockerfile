# Use multi-stage build for smaller final image
FROM lscr.io/linuxserver/rsnapshot:latest as builder

# Set working directory
WORKDIR /app

# Install Python and required build tools
RUN apk add --no-cache python3 py3-pip python3-dev build-base

# Copy only requirements first to leverage Docker cache
COPY backend/pyproject.toml .

# Install build dependencies and create virtual environment
RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --no-cache-dir pip -U && \
    /opt/venv/bin/pip install --no-cache-dir .

# Final stage
FROM lscr.io/linuxserver/rsnapshot:latest

# Set working directory
WORKDIR /app

# Install Python
RUN apk add --no-cache python3

# Copy virtual environment from builder
COPY --from=builder /opt/venv /opt/venv

# Copy application code
COPY backend .

# Make sure we use the virtualenv
ENV PATH="/opt/venv/bin:$PATH"

# Set Python path
ENV PYTHONPATH=/app

# Expose the port the app runs on
EXPOSE 8000

# Command to run the application
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"] 