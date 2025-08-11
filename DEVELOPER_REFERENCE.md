# Developer Reference - UCSD Data Science Capstone

This document contains technical details, advanced commands, and implementation information for developers working on the project.

## 📚 Complete Makefile Command Reference

The Makefile commands are organized into logical groups and alphabetically sorted within each section. Run `make help` to see the organized command structure.

### 🚀 **Essential Commands** (Start Here)
| Command | Description | Use Case |
|---------|-------------|----------|
| `make build` | Build static site for production | **Before deploying** - create optimized site files |
| `make help` | Show all available commands with descriptions | **First command to run** - see organized command structure |
| `make open` | Open site in default browser (after serve) | **After `make serve`** - view your site |
| `make serve` | **Smart serve** with auto-port discovery and PID tracking | **Daily development** - automatically finds available ports |
| `make serve-with-watch` | **Smart serve with auto-reload** (RECOMMENDED) | **Best development experience** - automatically restarts when files change |
| `make stop` | Stop the currently running development server | **Stop development** - clean shutdown using PID tracking |
| `make status` | Check the status of the development server | **Monitor** - see if server is running and on which port |

### 🔧 **Development Workflow Commands**
| Command | Description | Use Case |
|---------|-------------|----------|
| `make check` | Validate all links in built site | **Quality check** - find broken links before publishing |
| `make clean` | Remove all build artifacts and containers | **Before committing** - clean working directory |
| `make dev` | Full development mode (build + serve) | **Complete workflow** - one command to start everything |
| `make force-clean` | Force clean everything (when normal clean fails) | **Emergency cleanup** - resolve "proxy already running" errors |
| `make quick-serve` | Serve without port checking | **Fast iteration** - skip port verification for speed |
| `make quick-serve-with-watch` | Quick serve with file watching | **Fast development** - skip port checks, enable auto-reload |
| `make restart` | Restart the development server | **Refresh environment** - after configuration changes |

### 🐳 **Container Management Commands**
| Command | Description | Use Case |
|---------|-------------|----------|
| `make compose-down` | Stop and remove containers | **Fix port conflicts** - when `make serve` fails |
| `make compose-logs` | Show detailed container logs | **Debug issues** - see what's happening inside containers |
| `make compose-restart` | Restart all services | **Refresh environment** - after configuration changes |

### 📝 **Log Management Commands**
| Command | Description | Use Case |
|---------|-------------|----------|
| `make logs` | Show service logs (live tail) | **Monitor server** - see real-time logs |
| `make logs-clear` | Clear service logs | **Clean logs** - start fresh logging |
| `make logs-show` | Show last 50 lines of service logs | **Quick debugging** - recent log entries |
| `make watch-logs` | Show file watcher logs (live tail) | **Monitor auto-reload** - see file change detection |
| `make watch-logs-show` | Show last 50 lines of file watcher logs | **Quick file watcher status** - recent activity |

### 🛠️ **System & Troubleshooting Commands**
| Command | Description | Use Case |
|---------|-------------|----------|
| `make doctor` | System health check and tool detection | **Diagnose problems** - see what's working and what's not |
| `make podman-fix` | Restart Podman machine (macOS) | **Fix Podman issues** - when containers won't start |

### 🔍 **Advanced/Internal Commands**
| Command | Description | Use Case |
|---------|-------------|----------|
| `make check-port-range` | Check ports in priority order | **Port troubleshooting** - understand port selection logic |
| `make check-ports` | Check what's using the configured ports | **Port conflicts** - see what's blocking your server |
| `make compose-build` | Build using Podman Compose | **Container builds** - when you need containerized builds |
| `make compose-serve` | Serve using Podman Compose | **Container serving** - when you need containerized serving |
| `make ensure-port-4000-free` | Ensure port 4000 is free (internal use) | **Port management** - automatic port conflict resolution |
| `make force-clean-containers` | Force clean all containers (internal use) | **Internal cleanup** - used by `make clean` and `make force-clean` |
| `make local-build` | Build using local Jekyll | **Fallback option** - when containers aren't available |
| `make local-serve` | Serve using local Jekyll | **Fallback option** - when containers aren't available |
| `make smart-serve` | Smart serve with automatic port discovery | **Automatic port management** - finds available ports automatically |

## 🚀 **Smart Serve System**

The `make serve` command provides seamless port management with automatic conflict resolution and process tracking.

### **How Smart Serve Works**

1. **Port 4000 Priority**: Always tries port 4000 first for consistency
2. **Automatic Port Discovery**: Falls back to 4001 → 4002... if port 4000 is busy
3. **PID Tracking**: Saves process ID to `service.pid` for easy management
4. **Seamless Experience**: No manual port selection needed
5. **Smart Fallback**: Automatically handles port conflicts

### **Port Priority System**

The system automatically tries ports in this order:
- **4000** (preferred development port)
- **4001-4010** (close range for development)
- **5000-5004** (alternative range)
- **8000-8004** (common dev server range)

### **PID Management**

- **Automatic PID capture** when starting server
- **PID file**: `service.pid` (configurable)
- **Easy process management** with `make stop`
- **Clean shutdown** without orphaned processes

## 👀 **Smart File Watching System**

The `make serve-with-watch` command provides seamless auto-reload functionality by monitoring file changes and automatically restarting the server.

### **How Smart File Watching Works**

1. **Background Operation**: File watcher runs in background, terminal remains fully usable
2. **File Change Detection**: Monitors `.md`, `.yml`, `.css`, and `.scss` files in `docs/`
3. **Automatic Restart**: Server restarts automatically when changes are detected
4. **Separate Logging**: File watcher logs go to `file-watcher.log`, server logs to `service.log`
5. **Smart Exclusions**: Ignores build artifacts (`_site/`, `.jekyll-cache/`) to prevent false triggers

### **Monitored File Types**

- **Content**: `.md` (Markdown), `.yml` (YAML data)
- **Styling**: `.css`, `.scss` (CSS and Sass)
- **Excluded**: `_site/`, `.jekyll-cache/` (build artifacts)

## 📝 **Log Management System**

The development server redirects all logs to `service.log` for a cleaner terminal experience and persistent logging.

### **Log Features**

- **Clean terminal**: No more verbose container logs when starting server
- **Persistent logs**: All logs saved to `service.log` for debugging
- **Easy access**: Simple commands to view and manage logs
- **Automatic cleanup**: Log file included in `make clean` operations

### **Log File Location**

- **Default**: `service.log` in project root
- **Configurable**: `LOG_FILE=custom.log make serve`
- **Auto-cleanup**: Removed with `make clean` and `make force-clean`

## ⚙️ **Environment Configuration**

### **Port Configuration**
```bash
# Default port (exclusive)
PORT=4000              # Main site - single port approach

# Use alternative ports if needed
PORT=4100 make serve   # Site on port 4100
PORT=5000 make serve   # Site on port 5000
```

### **Single Port Benefits**
- **Simplified configuration**: Only one port to manage
- **No conflicts**: Eliminated LiveReload port issues
- **More reliable**: Fewer points of failure
- **Easier debugging**: Single port to check
- **Better compatibility**: Works in all environments

### **Directory Configuration**
```bash
# Source and output directories
DOCS_DIR=docs          # Source Markdown files
SITE_DIR=docs/_site    # Built static site
COMPOSE_FILE=docker-compose.yml  # Container configuration
```

### **Build Environment**
```bash
# Jekyll environment
JEKYLL_ENV=development  # Development mode (default)
JEKYLL_ENV=production   # Production mode (optimized)
```

## ⚡ **Makefile Optimizations**

The Makefile has been optimized for efficiency and maintainability:

### **Consolidated Functions**
- **Log Management**: Unified `show-logs`, `show-logs-tail`, and `clear-logs` functions
- **Cleanup Operations**: Consolidated `cleanup-artifacts` and `kill-processes-on-ports` helpers
- **Port Management**: Streamlined port checking and conflict resolution

### **Reduced Redundancy**
- **Eliminated duplicate code** in log commands
- **Consolidated cleanup logic** between `clean` and `force-clean`
- **Streamlined serve function chains** for better performance

### **Improved Maintainability**
- **Helper functions** for common operations
- **Consistent error handling** across all commands
- **Modular design** for easier future enhancements

## 🔄 **Auto-Refresh Features**

The development server includes automatic browser refresh:
- **File watching**: Monitors all files in `docs/`
- **Instant updates**: Browser refreshes when you save changes
- **Smart detection**: Works with Markdown, YAML, CSS, and other files
- **Single port**: Uses only port 4000 for simplicity and reliability
- **No port conflicts**: Eliminated LiveReload port management issues

## 📝 **Log Files & Monitoring**

The development environment creates several log files for monitoring:

- **`service.log`** - Server activity and Jekyll output
- **`file-watcher.log`** - File watching activity and auto-reload events
- **`service.pid`** - Process ID tracking for server management
- **`.last-check`** - File modification timestamp tracking

### **Monitoring Commands**
```bash
# Server activity
make logs                # Live server logs
make logs-show           # Recent server activity

# File watching activity
make watch-logs          # Live file watcher logs
make watch-logs-show     # Recent file watcher activity

# Overall status
make status              # Server and process status
```

## 🎯 **Command Organization**

The Makefile commands are organized into logical groups and alphabetically sorted within each section:

- 🚀 **Essential Commands** - Start here for basic usage
- 🔧 **Development Workflow** - Daily development tasks
- 🐳 **Container Management** - Docker/Podman operations
- 📝 **Log Management** - Service logs and file watcher monitoring
- 🛠️ **System & Troubleshooting** - Diagnostics and fixes
- 🔍 **Advanced/Internal Commands** - Expert-level operations
- 💡 **Quick Start** - Common task examples

## 📚 **Advanced Usage Examples**

### **Custom Port Configuration**
```bash
# Use specific port
PORT=8080 make serve

# Use port range
PORT=4000-4010 make serve
```

### **Advanced Troubleshooting**
```bash
# Check all ports
make check-ports

# Force port cleanup
make ensure-port-4000-free

# Detailed container logs
make compose-logs
```

### **Development Workflows**
```bash
# Quick iteration (skip port checks)
make quick-serve-with-watch

# Full development mode
make dev

# Force rebuild everything
make force-clean && make build
```

---

**Note**: This document is for developers who need technical details. For basic usage, see the main README.md file.
