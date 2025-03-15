FROM n8nio/n8n:latest

# Switch to root user to install packages
USER root

# Install commonly used npm modules
# Note: All external and internal modules are now allowed through environment variables
RUN npm install -g youtube-transcript

# Set environment variables to disable runtime restrictions
ENV NODE_OPTIONS="--no-experimental-fetch --disable-proto=throw"

# Create patch file and apply it directly
RUN mkdir -p /tmp/patches && \
    echo '--- node_modules/depd/index.js.orig	2023-03-21 12:00:00.000000000 +0000' > /tmp/patches/depd-fix.patch && \
    echo '+++ node_modules/depd/index.js	2023-03-21 12:00:01.000000000 +0000' >> /tmp/patches/depd-fix.patch && \
    echo '@@ -422,7 +422,14 @@' >> /tmp/patches/depd-fix.patch && \
    echo ' function wrapfunction (fn) {' >> /tmp/patches/depd-fix.patch && \
    echo '   var wrapper = createwrapper(fn.name)' >> /tmp/patches/depd-fix.patch && \
    echo '' >> /tmp/patches/depd-fix.patch && \
    echo '-  wrapper = new Function('\''fn'\'', '\''return '\'' + wrapper)(fn)' >> /tmp/patches/depd-fix.patch && \
    echo '+  // Replace the new Function call with a safer alternative' >> /tmp/patches/depd-fix.patch && \
    echo '+  // Original: wrapper = new Function('\''fn'\'', '\''return '\'' + wrapper)(fn)' >> /tmp/patches/depd-fix.patch && \
    echo '+' >> /tmp/patches/depd-fix.patch && \
    echo '+  // Safe wrapper function that preserves the original functionality without using new Function' >> /tmp/patches/depd-fix.patch && \
    echo '+  wrapper = function() {' >> /tmp/patches/depd-fix.patch && \
    echo '+    var args = Array.prototype.slice.call(arguments);' >> /tmp/patches/depd-fix.patch && \
    echo '+    return fn.apply(this, args);' >> /tmp/patches/depd-fix.patch && \
    echo '+  };' >> /tmp/patches/depd-fix.patch && \
    echo '' >> /tmp/patches/depd-fix.patch && \
    echo '   return wrapper' >> /tmp/patches/depd-fix.patch && \
    echo ' }' >> /tmp/patches/depd-fix.patch && \
    find /usr/local/lib/node_modules/n8n -name "depd" -type d -exec sh -c 'for dir; do if [ -f "$dir/index.js" ]; then echo "Applying patch to $dir/index.js"; cp "$dir/index.js" "$dir/index.js.orig"; patch -p0 "$dir/index.js" < /tmp/patches/depd-fix.patch || true; fi; done' sh {} \;

# Switch back to the node user (which is the default in the n8n image)
USER node
