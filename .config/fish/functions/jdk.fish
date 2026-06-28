function jdk --description 'List current java version, or set it with jdk <version>'
    set -l java_version $argv[1]
    set -l silent false
    set -q argv[2]; and set silent $argv[2]

    if test -z "$java_version"
        java -version
    else
        # Big Sur never changes version if JAVA_HOME is set. Unset it first.
        set -e JAVA_HOME
        set -gx JAVA_HOME (/usr/libexec/java_home -v"$java_version")
        if test "$silent" = false
            java -version
        end
    end
end
