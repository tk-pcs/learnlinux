#!/bin/bash

# Create main directory structure
mkdir -p docs/{assets/{images,diagrams,files},overview,modules}

# Create main documentation files
touch docs/index.md

# Create overview files
for file in introduction prerequisites structure; do
    touch docs/overview/$file.md
done

# Function to create module structure
create_module() {
    local module_path="docs/modules/$1"
    mkdir -p "$module_path"/{exercises,labs}
    
    # Create main module files
    touch "$module_path/index.md"
    
    # Create numbered module files
    for file in "$@"; do
        [[ $file != $1 ]] && touch "$module_path/$file"
    done
}

# Function to create exercise and lab files
create_module_exercises() {
    local module_path="docs/modules/$1"
    shift
    
    # Create exercise files
    touch "$module_path/exercises/index.md"
    for exercise in "$@"; do
        [[ $exercise == lab* ]] && touch "$module_path/labs/$exercise.md" || touch "$module_path/exercises/$exercise.md"
    done
}

# Module 1: Command Line Basics
create_module "01-command-line-basics" \
    "01-introduction.md" \
    "02-terminal.md" \
    "03-shell-basics.md" \
    "04-navigation.md"

create_module_exercises "01-command-line-basics" \
    "basic-commands" \
    "shell-navigation" \
    "lab1-shell-basics" \
    "lab2-navigation"

# Module 2: File System
create_module "02-file-system" \
    "01-filesystem-hierarchy.md" \
    "02-file-types.md" \
    "03-file-operations.md" \
    "04-permissions.md"

create_module_exercises "02-file-system" \
    "file-operations" \
    "permissions" \
    "lab1-file-ops" \
    "lab2-permissions"

# Module 3: Text Processing
create_module "03-text-processing" \
    "01-editors.md" \
    "02-basic-operations.md" \
    "03-filters.md" \
    "04-regex.md"

create_module_exercises "03-text-processing" \
    "vim-basics" \
    "text-processing" \
    "lab1-vim" \
    "lab2-text-tools"

# Set up empty .gitkeep files in empty directories to ensure they're tracked by git
find docs -type d -empty -exec touch {}/.gitkeep \;

echo "Directory structure created successfully!"

# Verify the structure
tree docs/

# Create requirements.txt
cat > requirements.txt << EOF
mkdocs-material
mkdocs-minify-plugin
mkdocs-git-revision-date-localized-plugin
EOF

# Create base mkdocs.yml if it doesn't exist
if [ ! -f mkdocs.yml ]; then
    cat > mkdocs.yml << EOF
site_name: Linux Command Line Training
site_description: Comprehensive Linux command line training for new hires and junior engineers
theme:
  name: material
  features:
    - navigation.tabs
    - navigation.sections
    - navigation.top
    - search.suggest
    - search.highlight
    - content.code.copy
  palette:
    - scheme: default
      toggle:
        icon: material/brightness-7
        name: Switch to dark mode
    - scheme: slate
      toggle:
        icon: material/brightness-4
        name: Switch to light mode

markdown_extensions:
  - attr_list
  - md_in_html
  - admonition
  - pymdownx.details
  - pymdownx.superfences
  - pymdownx.highlight:
      anchor_linenums: true
  - pymdownx.emoji:
      emoji_index: !!python/name:materialx.emoji.twemoji
      emoji_generator: !!python/name:materialx.emoji.to_svg

plugins:
  - search
EOF
fi

echo "Setup complete! You can now run 'pip install -r requirements.txt' to install dependencies."
