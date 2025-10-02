# UCSD Data Science Capstone – ML Development Environment

This repository contains the ML model development environment for the capstone project. Follow the setup instructions below to get started with Poetry and Git.

## 📋 Prerequisites

Before you can work with this repository, you'll need to install the following software:

### 🐍 **Python & Poetry**

- **Python** (version 3.12)

  - **macOS**: `brew install python@3.12`
  - **Linux**: `sudo dnf install python3.12` or `sudo apt install python3.12`
  - **Windows**: Download Python 3.12 from [python.org](https://www.python.org/downloads/)
  - **Verify**: `python3.12 --version` or `python --version`

- **Poetry** - Python dependency management and packaging tool
  - **Install**: `curl -sSL https://install.python-poetry.org | python3 -`
  - **Or via pip**: `pip install poetry`
  - **Verify**: `poetry --version`

### 🛠️ **Version Control**

- **Git** - Version control system
  - **macOS**: `brew install git`
  - **Linux**: `sudo dnf install git` or `sudo apt install git`
  - **Windows**: Download from [git-scm.com](https://git-scm.com/)
  - **Verify**: `git --version`

## 🚀 Environment Setup

### 1. Clone the Repository

```bash
# Clone the repository
git clone <your-repo-url>
cd <your-repo-name>
```

### 2. Set Up Poetry Environment

```bash
# Install dependencies from pyproject.toml
poetry install

# Activate the virtual environment
poetry shell

# Verify installation
poetry show
```

### 3. Configure Poetry (Optional)

```bash
# Create virtual environment in project directory
poetry config virtualenvs.in-project true

# Show current configuration
poetry config --list
```

## 🔧 Poetry Commands

### Environment Management

```bash
# Install all dependencies
poetry install

# Add a new dependency
poetry add numpy pandas scikit-learn

# Add development dependency
poetry add --group dev pytest jupyter

# Update dependencies
poetry update

# Show installed packages
poetry show

# Activate virtual environment
poetry shell

# Run commands in environment
poetry run python script.py
poetry run jupyter notebook
```

### Package Management

```bash
# Export requirements.txt (if needed)
poetry export -f requirements.txt --output requirements.txt

# Install from requirements.txt
poetry add $(cat requirements.txt)

# Remove a package
poetry remove package-name
```

## 📁 Git Operations

### Basic Git Workflow

```bash
# Check repository status
git status

# Pull latest changes
git pull origin main

# Create and switch to new branch
git checkout -b feature/new-model

# Stage changes
git add .
git add specific-file.py

# Commit changes
git commit -m "Add new ML model implementation"

# Push changes
git push origin feature/new-model

# Switch branches
git checkout main
git checkout feature/other-branch
```

### Advanced Git Operations

```bash
# View commit history
git log --oneline

# View differences
git diff
git diff --staged

# Undo changes
git checkout -- filename.py  # Discard local changes
git reset HEAD filename.py   # Unstage file

# Merge branches
git checkout main
git merge feature/new-model

# Stash changes temporarily
git stash
git stash pop
```

## 🤖 ML Development Workflow

### Daily Development

```bash
# 1. Start your day - pull latest changes
git pull origin main

# 2. Activate Poetry environment
poetry shell

# 3. Install any new dependencies
poetry install

# 4. Start Jupyter notebook or run scripts
poetry run jupyter notebook
# or
poetry run python train_model.py

# 5. Commit your progress
git add .
git commit -m "Update model training pipeline"
git push origin your-branch
```

### Setting Up New ML Dependencies

```bash
# Core ML libraries
poetry add numpy pandas scikit-learn matplotlib seaborn

# Deep learning frameworks
poetry add torch torchvision  # PyTorch
poetry add tensorflow         # TensorFlow

# Data processing
poetry add scipy statsmodels

# Development tools
poetry add --group dev jupyter ipykernel pytest black isort

# Install Jupyter kernel for this environment
poetry run python -m ipykernel install --user --name=capstone-env
```
