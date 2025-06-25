# Use Amazon Linux 2023 base image (hosted on AWS ECR, no pull limits)
FROM public.ecr.aws/amazonlinux/amazonlinux:2023

# Set working directory
WORKDIR /app

# Install Python and system dependencies
RUN dnf -y update && \
    dnf -y install \
      python3 \
      python3-pip \
      python3-setuptools \
      python3-wheel \
      gcc \
      postgresql-devel \
      python3-devel \
      make && \
    dnf clean all

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Copy the application code
COPY . .

# Set environment variables (can be overridden by Kubernetes ConfigMap/Secret)
ENV DB_USERNAME=myuser \
    DB_PASSWORD=changeme \
    DB_HOST=127.0.0.1 \
    DB_PORT=5432 \
    DB_NAME=mydatabase

# Expose app port
EXPOSE 5153

# Run the application
CMD ["python3", "appp.py"]
