PYTHON = python
VENV = venv
ifeq ($(OS),Windows_NT)
    VENV_PATH = $(VENV)/Scripts
	VENV_PIP = $(VENV_PATH)/pip.exe
	VENV_PYTHON = $(VENV_PATH)/$(PYTHON).exe
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		VENV_PATH = $(VENV)/bin
		VENV_PIP = $(VENV_PATH)/pip
		VENV_PYTHON = $(VENV_PATH)/$(PYTHON)
	endif
endif

VENV_PYTHON = $(VENV_PATH)/python

# Remove the old virtual environment
clean:
	rm -rf $(VENV)

# Generate a new virtual environment and install dependencies
venv: clean
	$(PYTHON) -m venv $(VENV)
	$(VENV_PYTHON) -m pip install --upgrade pip
	$(VENV_PIP) install -r requirements.txt
	source $(VENV_PATH)/activate 

update_requirements: clean
	$(PYTHON) -m venv $(VENV)
	$(VENV_PYTHON) -m pip install --upgrade pip
	$(VENV_PIP) install -r requirements-loose.txt
	$(VENV_PIP) freeze > requirements.txt
