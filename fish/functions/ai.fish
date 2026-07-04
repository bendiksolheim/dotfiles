function ai --description 'Buld and run AI containers'
    if test (count $argv) -eq 0
        echo "Usage: ai <build|run> <path>"
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
            echo "Building image from $containerfile (context: $build_context)"
            container build\
                --tag pi:local\
                --file $containerfile $build_context

        case "run"
            set -l folder $argv[2]

            if test -z "$folder"
                echo "Usage: ai run <folder>"
                return 1
            end

            if not test -d "$folder"
                echo "Error: folder not found at '$folder'"
                return 1
            end

            set -l abs_folder (realpath $folder)
            echo "Running container with $abs_folder mounted at /workspace"
            container run\
                --rm\
                --interactive\
                --tty\
                --volume "~/.pi/agent/auth.json:/home/pi/.pi/agent/auth.json"\
                --volume "$abs_folder:/workspace"\
                --workdir /workspace\
                --publish "38095:38095"\
                pi:local

        case '*'
            echo "Unknown subcommand: $subcmd"
            echo "Usage: ai <build|run> <path>"
            return 1
    end
end
