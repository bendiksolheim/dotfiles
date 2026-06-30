function jdks --description 'List available, globally and locally set java versions'
    echo "Java versions"
    /usr/libexec/java_home -V 2>&1 | sed 1d | sed '$d' | cut -d, -f1
    echo "Global: "(_java_version (/usr/libexec/java_home))
    if test -n "$JAVA_HOME"
        echo "Local:  "(_java_version "$JAVA_HOME")
    end
end
