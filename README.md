# UCSD Data Science Capstone – Website

This repository hosts a documentation site for the capstone project, built from Markdown files under `docs/` and published with GitHub Pages using the Just the Docs theme.

## 📋 Prerequisites

Before you can work with this repository, you'll need to install the following software and tools:

### 🐳 **Container Runtime (Recommended)**
- **Podman** - A daemonless container engine for developing, managing, and running containers
  - **macOS**: `brew install podman`
  - **Linux**: `sudo dnf install podman` (Fedora/RHEL) or `sudo apt install podman` (Ubuntu/Debian)
  - **Windows**: Download from [podman.io](https://podman.io/getting-started/installation)
  - **Verify**: `podman --version`

- **Podman Compose** - Docker Compose compatibility for Podman
  - **Install**: `pip install podman-compose` or `brew install podman-compose`
  - **Verify**: `podman-compose --version`

### 🔧 **Alternative: Local Development Stack**
If you prefer not to use containers, you can run Jekyll locally:

- **Ruby** (version 3.1 or higher)
  - **macOS**: `brew install ruby`
  - **Linux**: `sudo dnf install ruby` or `sudo apt install ruby`
  - **Windows**: Download from [rubyinstaller.org](https://rubyinstaller.org/)
  - **Verify**: `ruby --version`

- **Jekyll** and required gems
  - **Install**: `gem install jekyll bundler`
  - **Verify**: `jekyll --version`

### 🛠️ **Essential Tools**
- **Git** - Version control system
  - **macOS**: `brew install git`
  - **Linux**: `sudo dnf install git` or `sudo apt install git`
  - **Windows**: Download from [git-scm.com](https://git-scm.com/)
  - **Verify**: `git --version`

- **Make** - Build automation tool
  - **macOS**: Usually pre-installed, or `brew install make`
  - **Linux**: Usually pre-installed, or `sudo dnf install make`
  - **Windows**: Install via WSL or use alternatives like `nmake`

### 💻 **System Requirements**
- **Operating System**: macOS 10.15+, Ubuntu 18.04+, Windows 10+ (with WSL2)
- **Memory**: Minimum 4GB RAM (8GB+ recommended)
- **Storage**: At least 2GB free space
- **Network**: Internet connection for downloading containers and gems

### 🔍 **Verification Commands**
After installation, verify everything is working:

```bash
# Check all prerequisites
make doctor

# Expected output should show:
# ✅ Podman: Available
# ✅ Podman Compose: Available
# ✅ Git: Available
# ✅ Make: Available
# ✅ Ports: Available
```

### 🚨 **Troubleshooting Installation**
- **Podman issues**: Run `podman machine init && podman machine start` (macOS/Windows)
- **Permission errors**: Ensure your user is in the appropriate groups (`docker` on Linux)
- **Port conflicts**: The system automatically finds available ports (4000+)
- **Gem conflicts**: Use `make clean` to reset the environment

## 🚀 Quick Start (5 Minutes)

### Prerequisites
- **Podman** with docker-compose support (recommended)
- **Ruby** with Jekyll gems (fallback option)
- **Git** for version control

### Get Started
```bash
# 1. Clone and enter
git clone <your-repo-url>
cd <your-repo>

# 2. Check your system
make doctor

# 3. Start development with auto-reload (RECOMMENDED)
make serve-with-watch

# 4. Open in browser
make open
```

### Your First Edit
```bash
# Edit homepage announcements
nano docs/_data/announcements.yml

# Edit project overview
nano docs/project-overview.md

# Server automatically restarts! ✨
```

### Build and Deploy
```bash
# Build the site
make build

# Check for broken links
make check

# Clean up before committing
make clean
```

## 🛠️ Essential Commands

| Command | Description | When to Use |
|---------|-------------|-------------|
| `make serve-with-watch` | Start development server with auto-reload | **Daily development** - automatically restarts when files change |
| `make build` | Build static site for production | **Before deploying** - create optimized site files |
| `make open` | Open site in browser | **After starting server** - view your site |
| `make stop` | Stop development server | **Stop development** - clean shutdown |
| `make status` | Check server status | **Monitor** - see if server is running |
| `make clean` | Clean up build artifacts | **Before committing** - clean working directory |
| `make check` | Validate site links | **Quality check** - find broken links |

## 📁 Project Structure

```
docs/
├── _config.yml              # Jekyll + theme configuration
├── _data/
│   ├── announcements.yml    # Homepage announcements
│   └── deadlines.yml        # Upcoming deadlines
├── index.md                 # Homepage
├── project-overview.md      # Project description
├── timeline.md              # Project schedule (with Mermaid chart)
├── people-and-communication.md  # Team info
├── evaluation-and-submissions.md # Grading & submission
├── faq.md                   # Frequently asked questions
└── resources/               # Datasets, technology, templates
    ├── index.md
    ├── datasets.md
    └── technology.md
```

## 🔄 Development Workflow

### Daily Development
```bash
# 1. Start server with auto-reload
make serve-with-watch

# 2. Edit files (server auto-restarts!)
code docs/project-overview.md

# 3. Check quality
make check

# 4. Clean up
make clean
```

### Publishing Changes
```bash
# 1. Build production site
make build

# 2. Test locally
make serve

# 3. Commit and push
git add .
git commit -m "Update project overview"
git push

# 4. GitHub Pages builds automatically!
```

## 🆘 Common Issues & Solutions

### Server Won't Start
```bash
# Check system status
make doctor

# Use alternative port
PORT=4100 make serve

# Force cleanup
make force-clean
```

### Site Not Updating
```bash
# Check server status
make status

# Restart server
make restart

# Use auto-reload
make serve-with-watch
```

### Port Conflicts
```bash
# Stop containers
make compose-down

# Check what's using ports
make status

# Force cleanup
make force-clean
```

## 📝 Content Editing

- **Homepage data**:
  - Announcements: edit `docs/_data/announcements.yml` (top 3 shown)
  - Deadlines: edit `docs/_data/deadlines.yml` (top 3 shown)
- **Pages**: edit Markdown files in `docs/`. Navigation order controlled by `nav_order` in YAML front matter.
- **Links**: use relative links like `[Timeline](timeline)` or `[Datasets](resources/datasets)`.
- **Timeline diagram**: `docs/timeline.md` uses Mermaid and renders on GitHub Pages.

## 🌐 GitHub Pages Setup

1. Push to GitHub
2. Go to Repo Settings → Pages → Build and deployment
3. Choose "Deploy from a branch"
4. Set Branch: `master` (or `main`) and Folder: `/docs`
5. Save. Site builds automatically.

## 📚 Advanced Commands

For advanced usage, run `make help` to see all available commands organized by category.

---

**Need help?** Run `make doctor` to check your system setup, or `make help` to see all available commands.
