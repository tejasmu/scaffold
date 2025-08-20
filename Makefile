# At the top of your Makefile
#PYTHON := python3.12
# or
PYTHON := /usr/local/bin/python3.12

#PIP
#PIP := pip3.12

PIP :=  ~/.local/bin/pip3.12

install:
	$(PIP) install --upgrade pip && \
		$(PIP)  install -r requirements.txt && \
			$(PIP)  install pylint

format:
	black *.py
	
lint:
	pylint --disable=R,C hello.py

test:
	$(PYTHON) -m pytest -vv --cov=hello test_hello.py
	
all: install format lint test
