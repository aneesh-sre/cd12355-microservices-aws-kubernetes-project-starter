# Use Ubuntu base image
FROM ubuntu:22.04

# Set working directory
WORKDIR /app

# Install Python 3.11, pip, and required system dependencies for building psycopg2

RUN apt-get update && \
    apt-get install -y \
        python3 \
        python3-pip \
        python3-setuptools \
        python3-wheel \
        build-essential \
        python3-dev \
        libpq-dev \
        make && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip3 install --upgrade pip setuptools wheel && \
    pip3 install -r requirements.txt

# Copy the application code
COPY . .

# Set environment variables (you can override them at runtime)
ENV DB_USERNAME=myuser \
    DB_PASSWORD=changeme \
    DB_HOST=127.0.0.1 \
    DB_PORT=5433 \
    DB_NAME=mydatabase

# Expose app port
EXPOSE 5153

# Run the application
CMD ["python3", "app.py"]
