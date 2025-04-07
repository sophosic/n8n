FROM n8nio/n8n:latest

# Install git as root first
USER root
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Switch back to node user for npm configuration and global installs
USER node

# Configure npm to install global packages in the user's home directory
# The n8n image runs as a user with uid 1000 named 'node'
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$PATH:/home/node/.npm-global/bin

# Set environment variable to allow external modules in n8n
ENV NODE_FUNCTION_ALLOW_EXTERNAL=axios,openai,node-fetch,firebase-admin
ENV NODE_FUNCTION_ALLOW_BUILTIN=crypto,fs,path

# Install global packages as node user
# USER node # Already switched above
RUN npm install -g axios
RUN npm install -g openai
RUN npm install -g node-fetch
RUN npm install -g firebase-admin
RUN npm install -g cheerio
RUN npm install -g groq-sdk
RUN npm install -g github:agno-agi/agno


# Also install the packages locally where n8n can find them
WORKDIR /usr/local/lib/node_modules/n8n

USER root
RUN npm install firebase-admin

# Switch back to the node user to ensure container starts correctly
# The n8n image is designed to run as the 'node' user
USER node