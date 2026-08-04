#!/bin/bash
set -euo pipefail

echo "=========================================="
echo " Installing Jenkins on Amazon Linux"
echo "=========================================="

# Verify root privileges
if [[ $EUID -ne 0 ]]; then
    echo "Please run this script as root or using sudo."
    exit 1
fi

# Update packages
echo "Updating system packages..."
yum update -y

# Install Java 17
echo "Installing Amazon Corretto Java 17..."
yum install -y java-17-amazon-corretto

# Verify Java installation
java -version

# Add Jenkins repository
echo "Adding Jenkins repository..."
wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Install Jenkins
echo "Installing Jenkins..."
yum install -y jenkins

# Enable and start Jenkins service
echo "Starting Jenkins service..."
systemctl enable --now jenkins

# Check Jenkins service status
if systemctl is-active --quiet jenkins; then
    echo "Jenkins is running successfully."
else
    echo "Jenkins failed to start."
    systemctl status jenkins --no-pager
    exit 1
fi

# Display Java version
echo
echo "Installed Java Version:"
java -version

# Display Jenkins version
echo
echo "Installed Jenkins Version:"
jenkins --version || rpm -q jenkins

# Display initial admin password
echo
echo "Initial Jenkins Admin Password:"
cat /var/lib/jenkins/secrets/initialAdminPassword

# Display server access information
echo
echo "=========================================="
echo " Jenkins Installation Completed"
echo "=========================================="
echo "Access Jenkins using:"
echo "http://<EC2-PUBLIC-IP>:8080"
echo "Port: 8080"
echo "Service Status: $(systemctl is-active jenkins)"