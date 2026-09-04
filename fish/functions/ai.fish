function ai --description 'Buld and run AI containers'
    if not type -q container
        echo "Error: 'container' command not found. Install it first."
        return 1
    end
    
    if test (count $argv) -eq 0
        __print_usage
        return 1
    end

    set -l subcmd $argv[1]

    switch $subcmd
        case "build"
            set -l containerfile $argv[2]

            if test -z "$containerfile"
                echo "Usage: ai build <containerfile>"
                return 1
            end

            if not test -f "$containerfile"
                echo "Error. Containerfile not found at '$containerfile'"
                return 1
            end

            set -l build_context (dirname $containerfile)
            set -l image_name (path basename $containerfile)
            echo "Building image from $containerfile (context: $build_context)"
            container build\
                --tag "aicontainer-$image_name:local"\
                --file $containerfile $build_context

        case "run"
            set -l harness $argv[2]
            set -l folder $argv[3]

            if test -z "$folder"
                echo "Usage: ai run <harness> <folder>"
                return 1
            end

            if not test -d "$folder"
                echo "Error: folder not found at '$folder'"
                return 1
            end

            set -l abs_folder (realpath $folder)

            set -l extra_volumes
            switch $harness
                case "pi"
                    set -a extra_volumes --volume "$HOME/.pi/agent/auth.json:/home/pi/.pi/agent/auth.json"
                case "claude"
                    set -a extra_volumes --volume "$HOME/.claude:/home/claude/.claude"
            end

            echo "Running container with $abs_folder mounted at /workspace"
            container run\
                --rm\
                --interactive\
                --tty\
                --memory 2G\
                --volume "$abs_folder:/workspace"\
                --volume "$HOME/.claude.json:/home/claude/.claude.json"\
                $extra_volumes\
                --workdir /workspace\
                "aicontainer-$harness:local"
                #--volume "~/.pi/agent/auth.json:/home/pi/.pi/agent/auth.json"\

        case "list"
            __list_ai_images

        case help --help -h ""
            __print_usage
        case '*'
            echo "Unknown subcommand: $subcmd" >&2
            __print_usage
            return 1
    end
end

function __print_usage
    echo "Usage: ai <command> [arguments]

Commands:
build [containerfile]       Builds a new version of the containerfile
run [harness] [path]        Starts a new AI in the provided path
help                        Show this help text"
end

function __list_ai_images
    container image list -q\
        | string match "aicontainer-*"\
        | string replace -r "^aicontainer-(.*):.*\$" '$1'
end
