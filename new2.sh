#!/bin/bash

# Create overview directory and files
mkdir -p docs/overview
touch docs/overview/{introduction,prerequisites,structure}.md

# Function to create directory and file if they don't exist
create_if_missing() {
    local file_path="docs/$1"
    mkdir -p "$(dirname "$file_path")"
    
    if [[ ! -f "$file_path" ]]; then
        echo "Creating $file_path"
        touch "$file_path"
        
        # Add basic content to the file
        echo "# $(basename "${file_path%.*}" | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')" > "$file_path"
        echo "" >> "$file_path"
        echo "Content coming soon..." >> "$file_path"
    fi
}

# Create missing files
create_if_missing "overview/introduction.md"
create_if_missing "overview/prerequisites.md"
create_if_missing "overview/structure.md"

# Module 1 files
for file in {01..04}; do
    create_if_missing "modules/01-command-line-basics/${file}-introduction.md"
done

create_if_missing "modules/01-command-line-basics/exercises/index.md"
create_if_missing "modules/01-command-line-basics/exercises/basic-commands.md"
create_if_missing "modules/01-command-line-basics/exercises/shell-navigation.md"
create_if_missing "modules/01-command-line-basics/labs/lab1-shell-basics.md"
create_if_missing "modules/01-command-line-basics/labs/lab2-navigation.md"

# Module 2 files
for file in {01..04}; do
    create_if_missing "modules/02-file-system/${file}-filesystem-hierarchy.md"
done

# Create exercise and lab directories for all modules
for module in {01..07}; do
    module_path=$(printf "modules/%02d" $module)
    create_if_missing "$module_path/index.md"
    create_if_missing "$module_path/exercises/index.md"
    mkdir -p "docs/$module_path/labs"
done

echo "All missing files have been created!"
