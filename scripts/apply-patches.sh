#!/bin/bash

# Create patches directory if it doesn't exist
mkdir -p patches

# Create patch for depd package
cat > patches/depd-fix.patch << 'EOT'
--- node_modules/depd/index.js.orig	2023-03-21 12:00:00.000000000 +0000
+++ node_modules/depd/index.js	2023-03-21 12:00:01.000000000 +0000
@@ -422,7 +422,14 @@
 function wrapfunction (fn) {
   var wrapper = createwrapper(fn.name)

-  wrapper = new Function('fn', 'return ' + wrapper)(fn)
+  // Replace the new Function call with a safer alternative
+  // Original: wrapper = new Function('fn', 'return ' + wrapper)(fn)
+
+  // Safe wrapper function that preserves the original functionality without using new Function
+  wrapper = function() {
+    var args = Array.prototype.slice.call(arguments);
+    return fn.apply(this, args);
+  };

   return wrapper
 }
EOT

# Find the depd module and apply the patch
find /usr/local/lib/node_modules/n8n -name "depd" -type d | while read dir; do
  if [ -f "$dir/index.js" ]; then
    echo "Applying patch to $dir/index.js"
    cp "$dir/index.js" "$dir/index.js.orig"
    patch -p0 "$dir/index.js" < patches/depd-fix.patch
  fi
done

echo "Patches applied successfully"
