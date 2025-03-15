FROM n8nio/n8n:latest

# Switch to root user to install packages
USER root

# Install commonly used npm modules
# Note: All external and internal modules are now allowed through environment variables
RUN npm install -g youtube-transcript

# Set environment variables to disable runtime restrictions
ENV NODE_OPTIONS="--no-experimental-fetch --disable-proto=throw"

# Copy and run the patch script
COPY scripts/apply-patches.sh /tmp/apply-patches.sh
RUN chmod +x /tmp/apply-patches.sh && /tmp/apply-patches.sh

# Switch back to the node user (which is the default in the n8n image)
USER node
