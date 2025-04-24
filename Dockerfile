FROM n8nio/n8n:latest

# Install Python dependencies for Agno
RUN apt-get update && \
    apt-get install -y python3-pip &&

# Configure npm to install global packages in the user's home directory
# The n8n image runs as a user with uid 1000 named 'node'
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$PATH:/home/node/.npm-global/bin


# Switch to the node user before installing packages
USER node
RUN npm install -g axios
RUN npm install -g openai
RUN npm install -g node-fetch
RUN npm install -g firebase-admin



# Also install the packages locally where n8n can find them
WORKDIR /usr/local/lib/node_modules/n8n
USER root
RUN npm install firebase-admin

# Switch back to the node user to ensure container starts correctly
# The n8n image is designed to run as the 'node' user
USER node