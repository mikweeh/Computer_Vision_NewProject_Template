FROM mikweeh/cv-baseimage-01:latest

# Switch to root to install additional packages
USER root

# Copy additional requirements
COPY requirements.txt ./

# Install additional Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Switch back to rosuser (from the base image)
USER rosuser

# Copy project source code
COPY ./src ./src
