# Makefile — Build and check the Jekyll site under docs/
#
# Quickstart:
#   make serve                 # Serve at http://localhost:4000 with live reload
#   make build                 # Build static site into docs/_site
#   make check                 # Check built site links
#   make clean                 # Remove build artifacts and containers
#   make podman-fix            # Restart podman machine and show connection info
#
# Requirements:
# - Podman with docker-compose support, OR local Ruby with `jekyll` and `jekyll-remote-theme` gems

# ------------------------------
# Configuration
# ------------------------------
DOCS_DIR        ?= docs
SITE_DIR        ?= docs/_site
PORT            ?= 4000
COMPOSE_FILE    ?= docker-compose.yml
OS_NAME         := $(shell uname -s)
PID_FILE        ?= service.pid
LOG_FILE        ?= service.log

# ------------------------------
# Tool detection and runtime selection
# ------------------------------
HAS_PODMAN_BIN := $(shell command -v podman >/dev/null 2>&1 && echo 1 || echo 0)
HAS_JEKYLL_BIN := $(shell command -v jekyll >/dev/null 2>&1 && echo 1 || echo 0)
HAS_BUNDLE_BIN := $(shell command -v bundle >/dev/null 2>&1 && echo 1 || echo 0)
HAS_GEM_BIN    := $(shell command -v gem >/dev/null 2>&1 && echo 1 || echo 0)
PODMAN_OK      := $(shell podman info >/dev/null 2>&1 && echo 1 || echo 0)
COMPOSE_OK     := $(shell podman-compose version >/dev/null 2>&1 && echo 1 || echo 0)

# Choose container runtime if available
ifeq ($(PODMAN_OK),1)
	CONTAINER := podman
	ifeq ($(COMPOSE_OK),1)
		COMPOSE := podman-compose
	else
		COMPOSE := podman compose
	endif
else
	CONTAINER :=
	COMPOSE :=
endif

.DEFAULT_GOAL := help

# ------------------------------
# Help
# ------------------------------
.PHONY: help
help: ## Show this help and the most common targets
	@echo "Usage: make [target]"
	@echo ""
	@echo "\033[1;36m🚀 **Essential Commands** (Start Here)\033[0m"
	@echo "  build                   Build static site into \$$(SITE_DIR) (uses Podman Compose if available)"
	@echo "  open                    Open the local site in your browser (after serve)"
	@echo "  serve                   Serve the site locally with auto-refresh"
	@echo "  serve-with-watch        Serve with smart file watching and auto-restart"
	@echo ""
	@echo "\033[1;33m🔧 **Development Workflow**\033[0m"
	@echo "  check                   Check built site links (containerized lychee)"
	@echo "  clean                   Remove build artifacts and containers"
	@echo "  dev                     Development mode: build, serve, and watch for changes"
	@echo "  force-clean             Force clean everything (use when normal clean fails)"
	@echo "  quick-serve             Quick serve without port checking (for development)"
	@echo "  quick-serve-with-watch  Quick serve with file watching (skip port checks)"
	@echo "  restart                 Restart the development server"
	@echo ""
	@echo "\033[1;34m🐳 **Container Management**\033[0m"
	@echo "  compose-down            Stop and remove containers"
	@echo "  compose-logs            Show container logs"
	@echo "  compose-restart         Restart all services"
	@echo ""
	@echo "\033[1;35m📝 **Log Management**\033[0m"
	@echo "  logs                    Show the service logs (tail -f)"
	@echo "  logs-clear              Clear the service logs"
	@echo "  logs-show               Show the last 50 lines of service logs"
	@echo "  watch-logs              Show file watcher logs (live tail)"
	@echo "  watch-logs-show         Show the last 50 lines of file watcher logs"
	@echo ""
	@echo "\033[1;31m🛠️ **System & Troubleshooting**\033[0m"
	@echo "  doctor                  Show detected tools, runtime status, and key variables"
	@echo "  podman-fix              Restart podman machine and show connection info (macOS/Linux with Podman)"
	@echo ""
	@echo "\033[1;32m🔍 **Advanced/Internal Commands**\033[0m"
	@echo "  check-port-range        Check ports in priority order for availability"
	@echo "  check-ports             Check what's using the configured ports"
	@echo "  compose-build           Internal: Build using Podman Compose or fall back to local build"
	@echo "  compose-serve           Internal: Serve using Podman Compose or fall back to local serve"
	@echo "  ensure-port-4000-free   Ensure port 4000 is free (internal use)"
	@echo "  force-clean-containers  Force clean all containers (internal use)"
	@echo "  local-build             Build using local jekyll or gem-installed jekyll"
	@echo "  local-serve             Serve using local jekyll or gem-installed jekyll"
	@echo "  smart-serve             Smart serve with automatic port discovery"
	@echo "  start-file-watcher      Start file watching system (internal use)"
	@echo "  status                  Check server status and port"
	@echo "  stop                    Stop the currently running development server"
	@echo ""
	@echo "\033[1;37m💡 **Quick Start**\033[0m"
	@echo "  make clean              # Clean up everything"
	@echo "  make logs               # View server logs"
	@echo "  make serve              # Start development server"
	@echo "  make stop               # Stop server"

## 🚀 **Essential Commands** (Start Here)
## 🔧 **Development Workflow**
## 🐳 **Container Management**
## 📝 **Log Management**
## 🛠️ **System & Troubleshooting**
## 🔍 **Advanced/Internal Commands**

# ------------------------------
# Essential Commands (Start Here)
# ------------------------------
.PHONY: serve
serve: ## Serve the site locally with auto-refresh (smart port discovery)
	@$(MAKE) smart-serve

.PHONY: build
build: compose-build ## Build the static site into $(SITE_DIR) (uses Podman Compose if available)

.PHONY: open
open: ## Open the local site in your browser (after serve)
ifeq ($(OS_NAME),Darwin)
	@if [ -f "$(PID_FILE)" ]; then \
		PID=$$(cat $(PID_FILE)); \
		if ps -p $$PID > /dev/null 2>&1; then \
			SERVER_PORT=$$(lsof -i -P -n | grep $$PID | grep LISTEN | head -1 | awk '{print $$9}' | cut -d: -f2); \
			if [ -n "$$SERVER_PORT" ]; then \
				open http://localhost:$$SERVER_PORT; \
			else \
				open http://localhost:$(PORT); \
			fi; \
		else \
			open http://localhost:$(PORT); \
		fi; \
	else \
		open http://localhost:$(PORT); \
	fi
else
	@echo "Open http://localhost:$(PORT) in your browser"
endif

# ------------------------------
# Development Workflow
# ------------------------------
.PHONY: dev
dev: ## Development mode: build, serve, and watch for changes
	@echo "Starting development mode..."
	@echo "1. Building site..."
	$(MAKE) build
	@echo "2. Starting server..."
	$(MAKE) serve

.PHONY: quick-serve
quick-serve: ## Quick serve without port checking (for development)
	@echo "Quick serve mode (skipping port checks)..."
	@PORT=4000 $(MAKE) compose-serve

.PHONY: restart
restart: ## Restart the development server
	@echo "🔄 Restarting development server..."
	@$(MAKE) stop
	@sleep 3
	@echo "🚀 Starting fresh server..."
	@$(MAKE) smart-serve

.PHONY: check
check: build ## Check built site links (containerized lychee)
ifneq ($(COMPOSE),)
	$(COMPOSE) -f $(COMPOSE_FILE) run --rm lychee
else
	@echo "Podman Compose required for link checking (uses lycheeverse/lychee)." && exit 1
endif

.PHONY: clean
clean: ## Remove build artifacts and containers
	@echo "Cleaning up build artifacts and containers..."
	@$(MAKE) stop || true
	@$(call cleanup-artifacts)
	@echo "🐳 Stopping all containers..."
	@$(MAKE) force-clean-containers
	@echo "Cleanup complete."

.PHONY: force-clean
force-clean: ## Force clean everything (when normal clean fails)
	@echo "🧹 Force cleaning everything..."
	@# Stop any running server first
	@$(MAKE) stop >/dev/null 2>&1 || true
	@# Kill ALL file watcher processes aggressively
	@echo "👀 Killing all file watcher processes..."
	@pkill -f "start-simple-watcher" >/dev/null 2>&1 || true
	@pkill -f "serve-with-watch" >/dev/null 2>&1 || true
	@pkill -f "while true.*Checking for file changes" >/dev/null 2>&1 || true
	@# Force clean containers
	@$(MAKE) force-clean-containers >/dev/null 2>&1 || true
	@# Clean up all artifacts
	@$(call cleanup-artifacts)
	@# Kill any remaining processes on our ports
	@$(call kill-processes-on-ports)
	@echo "✅ Force clean complete"

# ------------------------------
# Server Management
# ------------------------------
.PHONY: smart-serve
smart-serve: ## Smart serve with automatic port discovery and PID tracking
	@echo "🚀 Starting development server..."
	@echo "🔍 Checking for available ports..."
	@# Pre-cleanup: remove any lingering containers and free port 4000
	@echo "🧹 Pre-cleaning any lingering containers and processes..."
	@$(MAKE) force-clean-containers >/dev/null 2>&1 || true
	@$(MAKE) ensure-port-4000-free >/dev/null 2>&1 || true
	@$(eval AVAILABLE_PORT := $(shell $(MAKE) check-port-range))
	@if [ -z "$(AVAILABLE_PORT)" ]; then \
		echo "❌ No available ports found in range. Please free some ports or use custom port:"; \
		echo "   PORT=9000 make serve"; \
		exit 1; \
	fi
	@echo "✅ Found available port: $(AVAILABLE_PORT)"
	@echo "🌐 Starting server on http://localhost:$(AVAILABLE_PORT)"
	@echo "📝 PID tracked in $(PID_FILE)"
	@echo ""
	@echo "💡 Tips:"
	@echo "  • Edit files in docs/ and see changes instantly!"
	@echo "  • Use 'make stop' to stop the server"
	@echo "  • Use 'make status' to check server status"
	@echo "  • Server will automatically refresh when you edit files"
	@echo ""
	@PORT=$(AVAILABLE_PORT) $(MAKE) compose-serve

.PHONY: stop
stop: ## Stop the currently running development server
	@if [ -f "$(PID_FILE)" ]; then \
		PID=$$(cat $(PID_FILE)); \
		if [ -n "$$PID" ]; then \
			echo "🛑 Stopping server (ID: $$PID)..."; \
			if echo "$$PID" | grep -qE '^[a-f0-9]{12,64}$$'; then \
				podman stop "$$PID" 2>/dev/null || true; \
			else \
				kill $$PID 2>/dev/null || true; \
				sleep 2; \
				ps -p $$PID > /dev/null 2>&1 && kill -9 $$PID 2>/dev/null || true; \
			fi; \
			echo "✅ Server stopped"; \
		fi; \
		rm -f $(PID_FILE); \
	fi
	@echo "👀 Stopping file watcher..."
	@pkill -f "start-simple-watcher" >/dev/null 2>&1 || true
	@pkill -f "serve-with-watch" >/dev/null 2>&1 || true
	@echo "🐳 Stopping containers..."
	@$(MAKE) compose-down >/dev/null 2>&1 || true
	@echo "✅ Server cleanup complete"

.PHONY: status
status: ## Check the status of the development server
	@if [ -f "$(PID_FILE)" ]; then \
		PID=$$(cat $(PID_FILE)); \
		if [ -n "$$PID" ]; then \
			if echo "$$PID" | grep -qE '^[a-f0-9]{12,64}$$'; then \
				echo "🟢 Server is running (Container ID: $$PID)"; \
				echo "🌐 Check http://localhost:$(PORT)"; \
			else \
				if ps -p $$PID > /dev/null 2>&1; then \
					echo "🟢 Server is running (PID: $$PID)"; \
					echo "🌐 Check http://localhost:$(PORT)"; \
				else \
					echo "🔴 Server PID file exists but process not running"; \
					rm -f $(PID_FILE); \
				fi; \
			fi; \
		else \
			echo "🔴 PID file is empty"; \
			rm -f $(PID_FILE); \
		fi; \
	else \
		echo "⚪ No server running (no PID file)"; \
		$(MAKE) check-ports; \
	fi

# ------------------------------
# Port Management
# ------------------------------
.PHONY: ensure-port-4000-free
ensure-port-4000-free: ## Ensure port 4000 is free (internal use)
	@echo "  Ensuring port 4000 is free..."
	@if lsof -i :4000 >/dev/null 2>&1; then \
		echo "    Port 4000 is in use. Attempting to free it..."; \
		for pid in $$(lsof -i :4000 -t 2>/dev/null || true); do \
			echo "      Found process $$pid using port 4000"; \
			echo "      Attempting to stop process $$pid..."; \
			kill -TERM $$pid 2>/dev/null || true; \
			sleep 2; \
			if ps -p $$pid > /dev/null 2>&1; then \
				echo "      Process $$pid still running, force killing..."; \
				kill -9 $$pid 2>/dev/null || true; \
			fi; \
		done; \
		sleep 1; \
		if lsof -i :4000 >/dev/null 2>&1; then \
			echo "    ⚠️  Port 4000 still in use after cleanup attempts"; \
		else \
			echo "    ✅ Port 4000 is now free"; \
		fi; \
	else \
		echo "    ✅ Port 4000 is already free"; \
	fi

.PHONY: check-port-range
check-port-range: ## Check ports in priority order for availability
	@# Always try port 4000 first, then fallback to alternatives
	@if ! lsof -i :4000 >/dev/null 2>&1; then \
		echo 4000; \
	else \
		for port in 4001 4002 4003 4004 4005 4006 4007 4008 4009 4010 5000 5001 5002 5003 5004 8000 8001 8002 8003 8004; do \
			if ! lsof -i :$$port >/dev/null 2>&1; then \
				echo $$port; \
				break; \
			fi; \
		done; \
	fi

.PHONY: check-ports
check-ports: ## Check what's using the configured ports
	@echo "Checking port usage:"
	@echo "Port $(PORT) (Jekyll):"
	@lsof -i :$(PORT) 2>/dev/null || echo "  Free"
	@echo "Port 4000 (Default):"
	@lsof -i :4000 2>/dev/null || echo "  Free"

# ------------------------------
# Build System
# ------------------------------
.PHONY: compose-build
compose-build: ## Internal: Build using Podman Compose or fall back to local build
ifneq ($(COMPOSE),)
	@echo "Building with Podman Compose..."
	$(COMPOSE) -f $(COMPOSE_FILE) run --rm jekyll-build
else
	@echo "Podman Compose not available. Falling back to local build." && $(MAKE) local-build
endif

.PHONY: local-build
local-build: ## Build using local jekyll or gem-installed jekyll
ifeq ($(HAS_JEKYLL_BIN),1)
	JEKYLL_ENV=development jekyll build --source $(DOCS_DIR) --destination $(SITE_DIR)
else ifeq ($(HAS_GEM_BIN),1)
	@echo "Installing local jekyll gems to user gem path..."
	gem install --user-install jekyll jekyll-remote-theme jekyll-seo-tag jekyll-sitemap jekyll-include-cache
	JEKYLL_ENV=development PATH="$$((ruby -e 'print Gem.user_dir'))/bin:$$PATH" jekyll build --source $(DOCS_DIR) --destination $(DOCS_DIR)/_site
else ifeq ($(HAS_BUNDLE_BIN),1)
	JEKYLL_ENV=development bundle exec jekyll build --source $(DOCS_DIR) --destination $(SITE_DIR)
else
	@echo "Local jekyll not found. Install Podman or 'gem install jekyll jekyll-remote-theme'." && exit 1
endif

# ------------------------------
# Serve System
# ------------------------------
.PHONY: compose-serve
compose-serve: ## Internal: Serve using Podman Compose or fall back to local serve
ifneq ($(COMPOSE),)
	@echo "Starting Jekyll server with Podman Compose..."
	@echo "Site will be available at: http://localhost:$(PORT)"
	@echo "📝 Logs redirected to $(LOG_FILE)"
	@echo "Press Ctrl+C to stop the server"
	@# Clean up any existing Gemfile to avoid conflicts
	@rm -f $(DOCS_DIR)/Gemfile $(DOCS_DIR)/Gemfile.lock
	@# Start the server and track the container
	@$(COMPOSE) -f $(COMPOSE_FILE) up jekyll > $(LOG_FILE) 2>&1 &
	@# Wait for container to start and get its container ID
	@sleep 8
	@# Get the container ID for tracking
	@CONTAINER_ID=$$(podman ps --filter "name=ucsd-intuit-data-science-capstone_jekyll_1" --format "{{.ID}}" 2>/dev/null | head -1); \
	if [ -n "$$CONTAINER_ID" ]; then \
		echo "$$CONTAINER_ID" > $(PID_FILE); \
		echo "📝 Container ID saved to $(PID_FILE): $$CONTAINER_ID"; \
	else \
		echo "⚠️  Could not get container ID, using podman-compose PID"; \
		ps aux | grep "podman-compose.*up jekyll" | grep -v grep | awk '{print $$2}' | head -1 > $(PID_FILE) || true; \
	fi
	@echo "🔄 Server starting... Check logs with 'make logs'"
	@# Wait a moment for the server to start
	@sleep 5
	@# Verify the server is running
	@if curl -s http://localhost:$(PORT) >/dev/null 2>&1; then \
		echo "✅ Server is running and accessible!"; \
		echo "🌐 Open http://localhost:$(PORT) in your browser"; \
		echo "📝 View logs: make logs"; \
		echo "🛑 Stop server: make stop"; \
	else \
		echo "⚠️  Server may still be starting... Check logs with 'make logs'"; \
	fi
else
	@echo "Podman Compose not available. Falling back to local serve." && $(MAKE) local-serve
endif

.PHONY: local-serve
local-serve: ## Serve using local jekyll or gem-installed jekyll
ifeq ($(HAS_JEKYLL_BIN),1)
	@echo "Starting local Jekyll server..."
	@echo "Site will be available at: http://localhost:$(PORT)"
	@echo "📝 Logs redirected to $(LOG_FILE)"
	$(call start-server-with-pid,JEKYLL_ENV=development jekyll serve --source $(DOCS_DIR) --destination $(SITE_DIR) --host 0.0.0.0 --port $(PORT) --watch --force_polling > $(LOG_FILE) 2>&1)
else ifeq ($(HAS_GEM_BIN),1)
	@echo "Installing local jekyll gems to user gem path..."
	gem install --user-install jekyll jekyll-remote-theme jekyll-seo-tag jekyll-sitemap jekyll-include-cache
	@echo "Starting local Jekyll server..."
	@echo "Site will be available at: http://localhost:$(PORT)"
	@echo "📝 Logs redirected to $(LOG_FILE)"
	$(call start-server-with-pid,JEKYLL_ENV=development PATH="$$((ruby -e 'print Gem.user_dir'))/bin:$$PATH" jekyll serve --source $(DOCS_DIR) --destination $(DOCS_DIR)/_site --host 0.0.0.0 --port $(PORT) --watch --force_polling > $(LOG_FILE) 2>&1)
else ifeq ($(HAS_BUNDLE_BIN),1)
	@echo "Starting local Jekyll server with bundle..."
	@echo "Site will be available at: http://localhost:$(PORT)"
	@echo "📝 Logs redirected to $(LOG_FILE)"
	$(call start-server-with-pid,JEKYLL_ENV=development bundle exec jekyll serve --source $(DOCS_DIR) --destination $(SITE_DIR) --host 0.0.0.0 --port $(PORT) --watch --force_polling > $(LOG_FILE) 2>&1)
else
	@echo "Local jekyll not found. Install Podman or 'gem install jekyll jekyll-remote-theme'." && exit 1
endif

# ------------------------------
# Log Management
# ------------------------------
.PHONY: logs
logs: ## Show the service logs (live tail)
	@$(call show-logs,$(LOG_FILE),"service logs","Start the server first with 'make serve'")

.PHONY: logs-show
logs-show: ## Show the last 50 lines of service logs
	@$(call show-logs-tail,$(LOG_FILE),"service logs","Start the server first with 'make serve'")

.PHONY: logs-clear
logs-clear: ## Clear the service logs
	@$(call clear-logs,$(LOG_FILE),"service logs")

.PHONY: watch-logs
watch-logs: ## Show file watcher logs (live tail)
	@$(call show-logs,file-watcher.log,"file watcher logs","Start with 'make serve-with-watch' first")

.PHONY: watch-logs-show
watch-logs-show: ## Show the last 50 lines of file watcher logs
	@$(call show-logs-tail,file-watcher.log,"file watcher logs","Start with 'make serve-with-watch' first")

# ------------------------------
# Container Management
# ------------------------------
.PHONY: compose-down
compose-down: ## Stop and remove containers
ifneq ($(COMPOSE),)
	@echo "Stopping containers..."
	$(COMPOSE) -f $(COMPOSE_FILE) down --remove-orphans
	@echo "Containers stopped."
else
	@echo "Podman Compose not available."
endif

.PHONY: compose-logs
compose-logs: ## Show container logs
ifneq ($(COMPOSE),)
	$(COMPOSE) -f $(COMPOSE_FILE) logs -f
else
	@echo "Podman Compose not available."
endif

.PHONY: compose-restart
compose-restart: ## Restart all services
ifneq ($(COMPOSE),)
	@echo "Restarting all services..."
	$(COMPOSE) -f $(COMPOSE_FILE) restart
else
	@echo "Podman Compose not available."
endif

# ------------------------------
# System & Troubleshooting
# ------------------------------
.PHONY: doctor
doctor: ## Show detected tools, runtime status, and key variables
	@echo "🔍 System Health Check - Checking all prerequisites..."
	@echo ""
	@echo "🐳 Container Runtime:"
	@if [ $(HAS_PODMAN_BIN) -eq 1 ]; then \
		echo "  ✅ Podman: Available"; \
	else \
		echo "  ❌ Podman: Not found - Install with 'brew install podman' (macOS) or 'sudo dnf install podman' (Linux)"; \
	fi
	@if [ $(COMPOSE_OK) -eq 1 ]; then \
		echo "  ✅ Podman Compose: Available"; \
	else \
		echo "  ❌ Podman Compose: Not found - Install with 'pip install podman-compose' or 'brew install podman-compose'"; \
	fi
	@echo ""
	@echo "🔧 Development Tools:"
	@if [ $(HAS_JEKYLL_BIN) -eq 1 ]; then \
		echo "  ✅ Jekyll: Available (local installation)"; \
	else \
		echo "  ℹ️  Jekyll: Not found locally (will use containerized version)"; \
	fi
	@if [ $(HAS_BUNDLE_BIN) -eq 1 ]; then \
		echo "  ✅ Bundler: Available"; \
	else \
		echo "  ℹ️  Bundler: Not found locally (will use containerized version)"; \
	fi
	@echo ""
	@echo "🛠️ Essential Tools:"
	@if command -v git >/dev/null 2>&1; then \
		echo "  ✅ Git: Available"; \
	else \
		echo "  ❌ Git: Not found - Install with 'brew install git' (macOS) or 'sudo dnf install git' (Linux)"; \
	fi
	@if command -v make >/dev/null 2>&1; then \
		echo "  ✅ Make: Available"; \
	else \
		echo "  ❌ Make: Not found - Install with 'brew install make' (macOS) or 'sudo dnf install make' (Linux)"; \
	fi
	@echo ""
	@echo "🌐 Network & Ports:"
	@if lsof -i :$(PORT) >/dev/null 2>&1; then \
		echo "  ⚠️  Port $(PORT): In use by another process"; \
	else \
		echo "  ✅ Port $(PORT): Available"; \
	fi
	@echo ""
	@echo "📊 Runtime Status:"
	@echo "  🎯 Chosen Runtime: $(if $(CONTAINER),$(CONTAINER),Local Jekyll)"
	@echo "  🔗 Compose Tool: $(if $(COMPOSE),$(COMPOSE),None)"
	@echo "  💻 OS: $(OS_NAME)"
	@echo ""
	@echo "💡 Recommendations:"
	@if [ $(HAS_PODMAN_BIN) -eq 0 ]; then \
		echo "  • Install Podman for the best development experience"; \
	fi
	@if [ $(COMPOSE_OK) -eq 0 ]; then \
		echo "  • Install Podman Compose for easier container management"; \
	fi
	@if [ $(HAS_JEKYLL_BIN) -eq 0 ] && [ $(HAS_PODMAN_BIN) -eq 0 ]; then \
		echo "  • Install either Podman OR local Jekyll to get started"; \
	fi
	@if [ $(HAS_PODMAN_BIN) -eq 1 ] && [ $(PODMAN_OK) -eq 0 ]; then \
		echo "  • Podman installed but not working - run 'make podman-fix'"; \
	fi
	@echo ""
	@echo "🚀 Ready to start? Run 'make serve-with-watch' to begin development!"

.PHONY: podman-fix
podman-fix: ## Restart podman machine and show connection info (macOS/Linux with Podman)
	@echo "Restarting Podman machine..."
	- podman machine stop
	- podman machine start
	- podman system connection list || true
	- podman info || true

# ------------------------------
# Advanced/Internal Commands
# ------------------------------
.PHONY: force-clean-containers
force-clean-containers: ## Force clean all containers (internal use)
	@# Stop and remove containers using podman-compose
	@if [ -n "$(COMPOSE)" ]; then \
		echo "  Stopping containers with $(COMPOSE)..."; \
		$(COMPOSE) -f $(COMPOSE_FILE) down --remove-orphans --volumes 2>/dev/null || true; \
	fi
	@# Force remove any lingering containers by name pattern
	@echo "  Checking for lingering containers..."; \
	@podman ps -a --format "{{.Names}}" 2>/dev/null | grep -E "(jekyll|lychee|ucsd-intuit)" | xargs -I {} sh -c 'echo "    Removing container: {}"; podman rm -f "{}" 2>/dev/null || true' || true
	@# Simple port cleanup - just kill processes on our ports
	@echo "  Checking for processes on our ports..."; \
	for port in $(PORT); do \
		echo "    Checking port $$port..."; \
		lsof -i :$$port -t 2>/dev/null | xargs -I {} sh -c 'echo "      Found process {} on port $(PORT)"; kill -9 {} 2>/dev/null || true' || true; \
	done

# ------------------------------
# Smart Serve with File Watching
# ------------------------------
.PHONY: serve-with-watch
serve-with-watch: ## Smart serve with file watching and auto-restart (recommended for development)
	@echo "🚀 Starting development server with smart file watching..."
	@echo "🔍 This will automatically restart the server when files change"
	@echo "📝 PID tracked in service.pid"
	@echo "📁 Watching directory: docs"
	@echo "📝 File watcher logs: file-watcher.log"
	@echo "📝 Server logs: service.log"
	@echo ""
	@echo "💡 Tips:"
	@echo "  • Edit files in docs/ and the server will restart automatically!"
	@echo "  • Use 'make stop' to stop the server"
	@echo "  • Use 'make status' to check server status"
	@echo "  • Check logs with 'make logs'"
	@echo "  • Check file watcher logs with 'make watch-logs'"
	@echo ""
	@echo "🚀 Starting background development environment..."
	@# Create the .last-check file for file watching
	@touch .last-check
	@# Start everything in the background and redirect all output to logs
	@$(MAKE) smart-serve > service.log 2>&1 &
	@# Wait for server to be fully ready
	@sleep 10
	@# Start the file watcher in the background
	@$(MAKE) start-simple-watcher > file-watcher.log 2>&1 &
	@# Save the background process PIDs for easy management
	@echo "🚀 Background development environment started!"
	@echo "🌐 Server: http://localhost:4000 (check with 'make status')"
	@echo "👀 File watcher: Active (logs in file-watcher.log)"
	@echo "📝 Server logs: service.log"
	@echo ""
	@echo "💡 Management Commands:"
	@echo "  • make status     - Check if server is running"
	@echo "  • make logs       - View server logs (live)"
	@echo "  • make watch-logs - View file watcher logs (live)"
	@echo "  • make stop       - Stop everything"
	@echo "  • make open       - Open site in browser"
	@echo ""
	@echo "✅ Terminal is now free for other commands!"
	@echo "🔍 The server will automatically restart when you edit files in docs/"

.PHONY: start-simple-watcher
start-simple-watcher: ## Start simple file watching system (internal use)
	@echo "🔍 File watcher active - monitoring for changes..."
	@echo "📝 File watcher PID: $$(echo $$BASHPID)"
	@# Simple file watching loop
	@while true; do \
		sleep 3; \
		echo "🔍 Checking for file changes..."; \
		RECENT_FILES=$$(find $(DOCS_DIR) -type f \( -name "*.md" -o -name "*.yml" -o -name "*.css" -o -name "*.scss" \) -not -path "$(DOCS_DIR)/_site/*" -not -path "$(DOCS_DIR)/.jekyll-cache/*" -not -path "$(DOCS_DIR)/.sass-cache/*" -newer .last-check 2>/dev/null | head -5); \
		if [ -n "$$RECENT_FILES" ]; then \
			echo "🔄 File changes detected:"; \
			echo "$$RECENT_FILES" | while read file; do \
				echo "   📝 $$file"; \
			done; \
			echo "🔄 Restarting server..."; \
			$(MAKE) restart >/dev/null 2>&1; \
			if [ $$? -eq 0 ]; then \
				echo "✅ Server restarted successfully"; \
			else \
				echo "⚠️  Server restart may have failed"; \
			fi; \
			echo "⏳ Waiting for server to stabilize..."; \
			sleep 15; \
			touch .last-check; \
			echo "🔍 File watcher resumed..."; \
		fi; \
	done

.PHONY: quick-serve-with-watch
quick-serve-with-watch: ## Quick serve with file watching (skip port checks)
	@echo "🚀 Quick start with file watching..."
	@PORT=4000 $(MAKE) serve-with-watch

# ------------------------------
# Helper Functions
# ------------------------------
define start-server-with-pid
	@echo "📝 Server PID saved to $(PID_FILE)"
	@$(1) & echo $$! > $(PID_FILE)
	@wait
endef

define show-logs
	@if [ -f "$(1)" ]; then \
		echo "📝 Showing $(2) (press Ctrl+C to stop following):"; \
		echo "Log file: $(1)"; \
		echo "---"; \
		tail -f $(1); \
	else \
		echo "📝 No $(2) found. $(3)"; \
	fi
endef

define show-logs-tail
	@if [ -f "$(1)" ]; then \
		echo "📝 Last 50 lines of $(2):"; \
		echo "Log file: $(1)"; \
		echo "---"; \
		tail -50 $(1); \
	else \
		echo "📝 No $(2) found. $(3)"; \
	fi
endef

define clear-logs
	@if [ -f "$(1)" ]; then \
		echo "🧹 Clearing $(2)..."; \
		> $(1); \
		echo "✅ Logs cleared."; \
	else \
		echo "📝 No $(2) to clear."; \
	fi
endef

define cleanup-artifacts
	@echo "🧹 Removing build artifacts..."
	rm -rf $(SITE_DIR) $(DOCS_DIR)/.jekyll-cache $(DOCS_DIR)/.sass-cache
	rm -f $(DOCS_DIR)/Gemfile $(DOCS_DIR)/Gemfile.lock $(PID_FILE) $(LOG_FILE) .last-check file-watcher.log background.pid
endef

define kill-processes-on-ports
	@echo "🛑 Killing processes on ports $(PORT)..."
	for port in $(PORT); do \
		for pid in $$(lsof -i :$$port -t 2>/dev/null || true); do \
			echo "    Killing process $$pid using port $$port"; \
			kill -9 $$pid 2>/dev/null || true; \
		done; \
	done
endef
