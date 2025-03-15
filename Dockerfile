FROM n8nio/n8n:latest

# Switch to root user to install packages
USER root

# Install commonly used npm modules and the patch utility
# Note: All external and internal modules are now allowed through environment variables
RUN apk add --no-cache patch && \
    npm install -g youtube-transcript

# Set environment variables to disable runtime restrictions
# Remove --disable-proto=throw as it breaks @oclif/core
ENV NODE_OPTIONS="--no-experimental-fetch"

# Create a direct replacement for the problematic function without using patch
RUN find /usr/local/lib/node_modules/n8n -name "depd" -type d -exec sh -c 'for dir; do \
        if [ -f "$dir/index.js" ]; then \
            echo "Fixing $dir/index.js"; \
            sed -i "s/wrapper = new Function('\''fn'\'', '\''return '\'' + wrapper)(fn)/wrapper = function() { var args = Array.prototype.slice.call(arguments); return fn.apply(this, args); }/g" "$dir/index.js"; \
        fi; \
    done' sh {} \;

# Switch back to the node user (which is the default in the n8n image)
USER node
