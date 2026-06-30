filename="$ZED_FILE"
extension="${filename##*.}"

case "$extension" in
    "js" | "jsx" | "ts" | "tsx")
      node;;

    "kt" | "kts")
      kotlin;;

    "java")
      jshell;;
esac
