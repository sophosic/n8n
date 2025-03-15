FROM n8nio/n8n:latest

# Switch to root user to install packages
USER root

# Install commonly used npm modules
# Note: All external and internal modules are now allowed through environment variables
RUN npm install -g youtube-transcript

# Switch back to the node user (which is the default in the n8n image)
USER node
