# Use the catthehacker/ubuntu:act-latest image as the base image
FROM catthehacker/ubuntu:act-latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages (you can modify this list as needed)
RUN apt-get update && apt-get install -y 

# Create the .ssh directory
RUN mkdir -p /root/.ssh

# Copy SSH keys into the container
COPY .ssh/id_rsa /root/.ssh/id_rsa
COPY .ssh/id_rsa.pub /root/.ssh/id_rsa.pub

RUN eval $(ssh-agent -s)

# Set correct permissions for SSH keys
RUN chmod 600 /root/.ssh/id_rsa && \
    chmod 644 /root/.ssh/id_rsa.pub

RUN git config --global url."git@github.com:".insteadOf "https://github.com/"
    
# Add GitHub to known hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

# Copy all other files from the host to the container
COPY . /workspace

# Set the working directory
WORKDIR /workspace

# Expose port 8080
EXPOSE 8080

# Default command (can be overridden by act)
CMD [ "bash" ]
