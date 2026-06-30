function _java_version
    set -l version_path $argv[1]
    if test -f "$version_path/release"
        grep "JAVA_VERSION=" "$version_path/release" | string replace -ra 'JAVA_VERSION=|"' ''
    else
        echo "$version_path"
    end
end
