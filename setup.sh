#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: $0 [apply|destroy] [dev|global|all]"
    echo "  apply   - Apply Terraform configurations in ascending order (001, 002, etc.)"
    echo "  destroy - Destroy Terraform configurations in descending order"
    echo "  dev     - Target only dev environment"
    echo "  global  - Target only global resources"
    echo "  all     - Target both dev and global (default)"
    exit 1
}

# Check if at least one argument is provided
if [ $# -lt 1 ]; then
    usage
fi

ACTION=$1
TARGET=${2:-all}

# Validate action
if [ "$ACTION" != "apply" ] && [ "$ACTION" != "destroy" ]; then
    echo "Error: Action must be either 'apply' or 'destroy'"
    usage
fi

# Function to process directories in the specified order
process_directories() {
    local env_path=$1
    local dirs=()
    
    # Find all numbered directories (00X format)
    for dir in $(find "$env_path" -maxdepth 2 -type d -name "[0-9][0-9][0-9]*" | sort); do
        dirs+=("$dir")
    done
    
    # If destroy, reverse the order
    if [ "$ACTION" == "destroy" ]; then
        dirs=($(printf '%s\n' "${dirs[@]}" | tac))
    fi
    
    # Process each directory
    for dir in "${dirs[@]}"; do
        echo "===================================================="
        echo "Processing: $dir"
        echo "===================================================="
        
        cd "$dir"
        
        # Initialize Terraform
        terraform init
        
        # Apply or destroy based on action
        if [ "$ACTION" == "apply" ]; then
            terraform apply -auto-approve
        else
            terraform destroy -auto-approve
        fi
        
        # Check if the command was successful
        if [ $? -ne 0 ]; then
            echo "Error in directory: $dir"
            exit 1
        fi
        
        cd - > /dev/null
    done
}

# Process the specified target(s)
if [ "$TARGET" == "dev" ] || [ "$TARGET" == "all" ]; then
    echo "Processing dev environment..."
    process_directories "dev"
fi

if [ "$TARGET" == "global" ] || [ "$TARGET" == "all" ]; then
    echo "Processing global resources..."
    process_directories "global"
fi

echo "Operation completed successfully!"
