#!/bin/bash

# Function to create module structure with files
create_module_structure() {
    local module_num=$1
    local module_name=$2
    local base_path="docs/modules/${module_num}"
    
    # Create main module directory and subdirectories
    mkdir -p "${base_path}"/{exercises,labs}
    
    # Create index files
    touch "${base_path}/index.md"
    touch "${base_path}/exercises/index.md"
    
    # Create module content files based on module number
    case $module_num in
        "04-advanced-cli")
            touch "${base_path}/01-piping-redirection.md"
            touch "${base_path}/02-process-management.md"
            touch "${base_path}/03-job-control.md"
            touch "${base_path}/04-shell-customization.md"
            touch "${base_path}/exercises/pipeline-practices.md"
            touch "${base_path}/exercises/process-control.md"
            touch "${base_path}/labs/lab1-advanced-pipeline.md"
            touch "${base_path}/labs/lab2-process-management.md"
            ;;
            
        "05-system-admin")
            touch "${base_path}/01-user-management.md"
            touch "${base_path}/02-package-management.md"
            touch "${base_path}/03-service-management.md"
            touch "${base_path}/04-system-monitoring.md"
            touch "${base_path}/exercises/user-admin.md"
            touch "${base_path}/exercises/package-ops.md"
            touch "${base_path}/labs/lab1-user-management.md"
            touch "${base_path}/labs/lab2-system-services.md"
            ;;
            
        "06-networking")
            touch "${base_path}/01-network-basics.md"
            touch "${base_path}/02-network-config.md"
            touch "${base_path}/03-remote-access.md"
            touch "${base_path}/04-network-tools.md"
            touch "${base_path}/exercises/network-config.md"
            touch "${base_path}/exercises/remote-access.md"
            touch "${base_path}/labs/lab1-network-setup.md"
            touch "${base_path}/labs/lab2-remote-management.md"
            ;;
            
        "07-advanced-topics")
            touch "${base_path}/01-shell-scripting.md"
            touch "${base_path}/02-security-basics.md"
            touch "${base_path}/03-performance-tuning.md"
            touch "${base_path}/04-advanced-tools.md"
            touch "${base_path}/exercises/script-writing.md"
            touch "${base_path}/exercises/security-hardening.md"
            touch "${base_path}/labs/lab1-automation.md"
            touch "${base_path}/labs/lab2-security.md"
            ;;
    esac
    
    echo "Created structure for ${module_name}"
}

# Create new modules
create_module_structure "04-advanced-cli" "Advanced Command Line"
create_module_structure "05-system-admin" "System Administration"
create_module_structure "06-networking" "Networking"
create_module_structure "07-advanced-topics" "Advanced Topics"

# Set up empty .gitkeep files in empty directories
find docs -type d -empty -exec touch {}/.gitkeep \;

echo "All module structures created successfully!"

# Verify the structure
tree docs/modules/
