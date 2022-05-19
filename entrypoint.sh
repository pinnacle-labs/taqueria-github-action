#!/bin/bash
echo "$INPUT_TASK"
if [ -z "$INPUT_PROJECT_NAME" ] && [ -z "$INPUT_TASK" ]; then
    echo "No project name or task name provided"
    exit 1
fi

if [ -z "$INPUT_PROJECT_NAME" ]; then
    export PROJECT_DIR=$RUNNER_WORKSPACE/${GITHUB_REPOSITORY#*/}
    if [ "$INPUT_TASK" == "init" ]; then
        taq init
        npm init -y
    else
        taq $INPUT_TASK
    fi
else
    export PROJECT_DIR=$RUNNER_WORKSPACE/${GITHUB_REPOSITORY#*/}/$INPUT_PROJECT_NAME
    # When the taq command is init
    if [ "$INPUT_TASK" == "init" ]; then
        taq -p $INPUT_PROJECT_NAME init
        cd "$INPUT_PROJECT_NAME" || exit 1
        npm init -y
    else
        taq -p $INPUT_PROJECT_NAME $INPUT_TASK
    fi
fi
