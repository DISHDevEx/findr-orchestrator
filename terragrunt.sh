#!/bin/bash

# Ensure the script receives the module path and Terragrunt command
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <module-path> <terragrunt-command> [additional-args]"
    exit 1
fi

MODULE_PATH=$1
shift
TERRAGRUNT_COMMAND=$1
shift

# Path to the template and the new terragrunt.hcl file
TEMPLATE_PATH="./terragrunt.hcl.template"
OUTPUT_PATH="./${MODULE_PATH}/terragrunt.hcl"

# Verify that the template file exists in the root directory
if [ ! -f "$TEMPLATE_PATH" ]; then
    echo "Template file not found: $TEMPLATE_PATH"
    exit 1
fi

# Replace the placeholder in the template with the actual source
# Modify this line to match your source URL pattern
sed "s|\${TERRAGRUNT_SOURCE}|$TERRAGRUNT_SOURCE|" "$TEMPLATE_PATH" > "$OUTPUT_PATH"

# Navigate to the module directory and run the Terragrunt command
cd "$MODULE_PATH"
terragrunt $TERRAGRUNT_COMMAND "$@"
cd - # Return to the original directory