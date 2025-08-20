# # At the top of your Makefile
# #PYTHON := python3.12
# # or
# PYTHON := /usr/local/bin/python3.12

# #PIP
# #PIP := pip3.12

# PIP :=  ~/.local/bin/pip3.12

# install:
# 	$(PIP) install --upgrade pip && \
# 		$(PIP)  install -r requirements.txt && \
# 			$(PIP)  install pylint

# format:
# 	black *.py
	
# lint:
# 	pylint --disable=R,C hello.py

# test:
# 	$(PYTHON) -m pytest -vv --cov=hello test_hello.py
	
# all: install format lint test

# Detect Python executable
# Priority: python3 (GitHub Actions default) -> python3.12 (your local) -> python
PYTHON := $(shell which python3 2>/dev/null || which python3.12 2>/dev/null || which python 2>/dev/null)

# Validate Python is found
ifeq ($(PYTHON),)
    $(error Python not found. Please install Python)
endif

# Print Python info for debugging
.PHONY: python-info
python-info:
	@echo "Using Python: $(PYTHON)"
	@$(PYTHON) --version
	@echo "Python location: $(shell which $(PYTHON))"

# Installation target
.PHONY: install
install:
	$(PYTHON) -m pip install --upgrade pip
	$(PYTHON) -m pip install -r requirements.txt
	$(PYTHON) -m pip install pylint pytest pytest-cov black

# Linting
.PHONY: lint
lint:
	$(PYTHON) -m pylint --disable=R,C hello.py

# Testing
.PHONY: test
test:
	$(PYTHON) -m pytest -vv --cov=hello test_hello.py

# Formatting check
.PHONY: format
format:
	$(PYTHON) -m black --check hello.py

# Format code (fix formatting)
.PHONY: format-fix
format-fix:
	$(PYTHON) -m black hello.py

# Run all checks
.PHONY: all
all: install lint test format
	@echo "All checks passed!"

# Clean up
.PHONY: clean
clean:
	rm -rf __pycache__/
	rm -rf .pytest_cache/
	rm -rf .coverage
	find . -name "*.pyc" -delete
