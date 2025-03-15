FROM n8nio/n8n:latest

# Install commonly used npm modules
# Note: All external and internal modules are now allowed through environment variables
RUN npm install -g youtube-transcript
