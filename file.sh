#!/bin/bash

set -euo pipefail
trap 'echo "Error on line $LINENO. Exit code: $?"' ERR

# Set the base directory
BASE_DIR="docs"
MKDOCS_YML="mkdocs.yml"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging functions
log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }

# Check if mkdocs.yml exists
if [[ ! -f "$MKDOCS_YML" ]]; then
    log_error "mkdocs.yml not found in current directory!"
    exit 1
fi

# Function to validate directory/file name
validate_path() {
    if [[ "$1" =~ [^a-zA-Z0-9/./_/-] ]]; then
        log_error "Invalid path: $1"
        return 1
    fi
    return 0
}

# Function to create directory if it doesn't exist
create_dir() {
    validate_path "$1" || exit 1
    if [[ ! -d "$1" ]]; then
        mkdir -p "$1"
        log_info "Created directory: $1"
    fi
}

# Function to create file if it doesn't exist
create_file() {
    local file_path="$1"
    local title="$2"
    
    validate_path "$file_path" || exit 1
    
    if [[ ! -f "$file_path" ]]; then
        mkdir -p "$(dirname "$file_path")"
        echo "# $title" > "$file_path"
        echo "" >> "$file_path"
        echo "Content coming soon..." >> "$file_path"
        log_info "Created file: $file_path"
    fi
}

# Function to remove directory if it exists
remove_dir() {
    if [[ -d "$1" ]]; then
        rm -rf "$1"
        log_info "Removed directory: $1"
    fi
}

# Function to validate against mkdocs.yml
validate_against_nav() {
    local nav_file="$MKDOCS_YML"
    local missing_files=()
    
    log_info "Validating files against mkdocs.yml..."
    
    # Extract all .md files from mkdocs.yml
    while IFS= read -r line; do
        if [[ $line =~ .*:.*/.*\.md ]]; then
            file_path=$(echo "$line" | sed 's/.*: *//' | tr -d "'\"")
            if [[ ! -f "$file_path" ]]; then
                missing_files+=("$file_path")
            fi
        fi
    done < "$nav_file"
    
    if [[ ${#missing_files[@]} -gt 0 ]]; then
        log_warn "Missing files referenced in mkdocs.yml:"
        printf '%s\n' "${missing_files[@]}"
        return 1
    else
        log_info "All files referenced in mkdocs.yml exist"
        return 0
    fi
}

# Clean up unnecessary directories
log_info "Cleaning up unnecessary directories..."
remove_dir "$BASE_DIR/modules/00"
remove_dir "$BASE_DIR/modules/01-command-line-basics/{exercises,labs}"
remove_dir "$BASE_DIR/modules/02-file-system/{exercises,labs}"
remove_dir "$BASE_DIR/modules/03-text-processing/{exercises,labs}"
remove_dir "$BASE_DIR/modules/04-advanced-cli/{exercises,labs}"
remove_dir "$BASE_DIR/modules/05-system-admin/{exercises,labs}"
remove_dir "$BASE_DIR/modules/06-networking/{exercises,labs}"
remove_dir "$BASE_DIR/modules/07-advanced-topics/{exercises,labs}"

# Create base directory structure
log_info "Creating base directory structure..."
create_dir "$BASE_DIR/assets/images"
create_dir "$BASE_DIR/assets/diagrams"
create_dir "$BASE_DIR/assets/files"
create_dir "$BASE_DIR/overview"

# Function to set up a module
setup_module() {
    local module_num="$1"
    local module_name="$2"
    local module_path="$BASE_DIR/modules/$module_num"
    
    log_info "Setting up module: $module_name"
    
    create_dir "$module_path"
    create_file "$module_path/index.md" "$module_name"
    create_dir "$module_path/exercises"
    create_dir "$module_path/labs"
}

# Set up all modules
# Module 1: Command Line Basics
setup_module "01-command-line-basics" "Command Line Basics"
create_file "$BASE_DIR/modules/01-command-line-basics/01-introduction.md" "Introduction to Command Line"
create_file "$BASE_DIR/modules/01-command-line-basics/02-terminal.md" "Terminal Basics"
create_file "$BASE_DIR/modules/01-command-line-basics/03-shell-basics.md" "Shell Basics"
create_file "$BASE_DIR/modules/01-command-line-basics/04-navigation.md" "Navigation"
create_file "$BASE_DIR/modules/01-command-line-basics/exercises/index.md" "Command Line Exercises"
create_file "$BASE_DIR/modules/01-command-line-basics/exercises/basic-commands.md" "Basic Commands"
create_file "$BASE_DIR/modules/01-command-line-basics/exercises/shell-navigation.md" "Shell Navigation"
create_file "$BASE_DIR/modules/01-command-line-basics/labs/lab1-shell-basics.md" "Shell Basics Lab"
create_file "$BASE_DIR/modules/01-command-line-basics/labs/lab2-navigation.md" "Navigation Lab"

# Module 2: File System Navigation
setup_module "02-file-system" "File System Navigation"
create_file "$BASE_DIR/modules/02-file-system/01-filesystem-hierarchy.md" "File System Hierarchy"
create_file "$BASE_DIR/modules/02-file-system/02-file-types.md" "File Types"
create_file "$BASE_DIR/modules/02-file-system/03-file-operations.md" "File Operations"
create_file "$BASE_DIR/modules/02-file-system/04-permissions.md" "Permissions"
create_file "$BASE_DIR/modules/02-file-system/exercises/index.md" "File System Exercises"
create_file "$BASE_DIR/modules/02-file-system/exercises/file-management.md" "File Management"
create_file "$BASE_DIR/modules/02-file-system/exercises/permission-control.md" "Permission Control"
create_file "$BASE_DIR/modules/02-file-system/exercises/links-inodes.md" "Links and Inodes"
create_file "$BASE_DIR/modules/02-file-system/labs/lab1-file-operations.md" "File Operations Lab"
create_file "$BASE_DIR/modules/02-file-system/labs/lab2-permissions.md" "Permissions Lab"
create_file "$BASE_DIR/modules/02-file-system/labs/lab3-system-navigation.md" "System Navigation Lab"

# Module 3: Text Processing
setup_module "03-text-processing" "Text Processing"
create_file "$BASE_DIR/modules/03-text-processing/01-editors.md" "Text Editors"
create_file "$BASE_DIR/modules/03-text-processing/02-basic-operations.md" "Basic Operations"
create_file "$BASE_DIR/modules/03-text-processing/03-filters.md" "Filters"
create_file "$BASE_DIR/modules/03-text-processing/04-regex.md" "Regular Expressions"
create_file "$BASE_DIR/modules/03-text-processing/exercises/index.md" "Text Processing Exercises"
create_file "$BASE_DIR/modules/03-text-processing/exercises/vim-basics.md" "Vim Basics"
create_file "$BASE_DIR/modules/03-text-processing/exercises/text-manipulation.md" "Text Manipulation"
create_file "$BASE_DIR/modules/03-text-processing/exercises/regex-practice.md" "Regex Practice"
create_file "$BASE_DIR/modules/03-text-processing/labs/lab1-editor-mastery.md" "Editor Mastery Lab"
create_file "$BASE_DIR/modules/03-text-processing/labs/lab2-text-processing.md" "Text Processing Lab"
create_file "$BASE_DIR/modules/03-text-processing/labs/lab3-advanced-patterns.md" "Advanced Patterns Lab"

# Module 4: Advanced Command Line
setup_module "04-advanced-cli" "Advanced Command Line"
create_file "$BASE_DIR/modules/04-advanced-cli/01-piping-redirection.md" "Piping and Redirection"
create_file "$BASE_DIR/modules/04-advanced-cli/02-process-management.md" "Process Management"
create_file "$BASE_DIR/modules/04-advanced-cli/03-job-control.md" "Job Control"
create_file "$BASE_DIR/modules/04-advanced-cli/04-shell-customization.md" "Shell Customization"
create_file "$BASE_DIR/modules/04-advanced-cli/exercises/index.md" "Advanced CLI Exercises"
create_file "$BASE_DIR/modules/04-advanced-cli/exercises/pipeline-building.md" "Pipeline Building"
create_file "$BASE_DIR/modules/04-advanced-cli/exercises/process-control.md" "Process Control"
create_file "$BASE_DIR/modules/04-advanced-cli/exercises/shell-config.md" "Shell Configuration"
create_file "$BASE_DIR/modules/04-advanced-cli/labs/lab1-advanced-pipeline.md" "Advanced Pipeline Lab"
create_file "$BASE_DIR/modules/04-advanced-cli/labs/lab2-process-management.md" "Process Management Lab"
create_file "$BASE_DIR/modules/04-advanced-cli/labs/lab3-shell-customization.md" "Shell Customization Lab"

# Module 5: System Administration
setup_module "05-system-admin" "System Administration"
create_file "$BASE_DIR/modules/05-system-admin/01-user-management.md" "User Management"
create_file "$BASE_DIR/modules/05-system-admin/02-package-management.md" "Package Management"
create_file "$BASE_DIR/modules/05-system-admin/03-service-management.md" "Service Management"
create_file "$BASE_DIR/modules/05-system-admin/04-system-monitoring.md" "System Monitoring"
create_file "$BASE_DIR/modules/05-system-admin/exercises/index.md" "System Administration Exercises"
create_file "$BASE_DIR/modules/05-system-admin/exercises/user-admin.md" "User Administration"
create_file "$BASE_DIR/modules/05-system-admin/exercises/package-ops.md" "Package Operations"
create_file "$BASE_DIR/modules/05-system-admin/exercises/service-control.md" "Service Control"
create_file "$BASE_DIR/modules/05-system-admin/labs/lab1-user-management.md" "User Management Lab"
create_file "$BASE_DIR/modules/05-system-admin/labs/lab2-system-services.md" "System Services Lab"
create_file "$BASE_DIR/modules/05-system-admin/labs/lab3-system-maintenance.md" "System Maintenance Lab"

# Module 6: Networking
setup_module "06-networking" "Networking"
create_file "$BASE_DIR/modules/06-networking/01-network-basics.md" "Network Basics"
create_file "$BASE_DIR/modules/06-networking/02-network-config.md" "Network Configuration"
create_file "$BASE_DIR/modules/06-networking/03-remote-access.md" "Remote Access"
create_file "$BASE_DIR/modules/06-networking/04-network-tools.md" "Network Tools"
create_file "$BASE_DIR/modules/06-networking/exercises/index.md" "Networking Exercises"
create_file "$BASE_DIR/modules/06-networking/exercises/network-config.md" "Network Configuration"
create_file "$BASE_DIR/modules/06-networking/exercises/remote-access.md" "Remote Access"
create_file "$BASE_DIR/modules/06-networking/exercises/troubleshooting.md" "Troubleshooting"
create_file "$BASE_DIR/modules/06-networking/labs/lab1-network-setup.md" "Network Setup Lab"
create_file "$BASE_DIR/modules/06-networking/labs/lab2-remote-management.md" "Remote Management Lab"
create_file "$BASE_DIR/modules/06-networking/labs/lab3-network-analysis.md" "Network Analysis Lab"

# Module 7: Advanced Topics
setup_module "07-advanced-topics" "Advanced Topics"
create_file "$BASE_DIR/modules/07-advanced-topics/01-shell-scripting.md" "Shell Scripting"
create_file "$BASE_DIR/modules/07-advanced-topics/02-security-basics.md" "Security Basics"
create_file "$BASE_DIR/modules/07-advanced-topics/03-performance-tuning.md" "Performance Tuning"
create_file "$BASE_DIR/modules/07-advanced-topics/04-advanced-tools.md" "Advanced Tools"
create_file "$BASE_DIR/modules/07-advanced-topics/exercises/index.md" "Advanced Topics Exercises"
create_file "$BASE_DIR/modules/07-advanced-topics/exercises/script-development.md" "Script Development"
create_file "$BASE_DIR/modules/07-advanced-topics/exercises/security-hardening.md" "Security Hardening"
create_file "$BASE_DIR/modules/07-advanced-topics/exercises/performance-analysis.md" "Performance Analysis"
create_file "$BASE_DIR/modules/07-advanced-topics/labs/lab1-automation.md" "Automation Lab"
create_file "$BASE_DIR/modules/07-advanced-topics/labs/lab2-security-implementation.md" "Security Implementation Lab"
create_file "$BASE_DIR/modules/07-advanced-topics/labs/lab3-performance-optimization.md" "Performance Optimization Lab"

# Validate the final structure
log_info "Validating directory structure..."
if ! validate_against_nav; then
    log_warn "Some files referenced in mkdocs.yml are missing. Please review the warnings above."
else
    log_info "Directory structure validation completed successfully!"
fi

log_info "Displaying final directory structure..."
tree "$BASE_DIR"

log_info "Script completed successfully!"
