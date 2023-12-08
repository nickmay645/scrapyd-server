PYTHON = python
VENV = venv
ifeq ($(OS),Windows_NT)
    VENV_PATH = $(VENV)/Scripts
	VENV_PIP = $(VENV_PATH)/pip.exe
	VENV_PYTHON = $(VENV_PATH)/$(PYTHON).exe
	VENV_ACTIVATE = $(VENV_PATH)/activate
	OS = Windows_NT
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		VENV_PATH = $(VENV)/bin
		VENV_PIP = $(VENV_PATH)/pip
		VENV_PYTHON = $(VENV_PATH)/$(PYTHON)
		VENV_ACTIVATE = $(VENV_PATH)/activate
		OS = Linux
	endif
endif

# Remove the old virtual environment
.PHONY: clean
clean:
	@echo "Configured for $(OS)"
	@if [ -d "$(VENV)" ]; then \
		echo "Removing virtual environment at $(VENV)"; \
		rm -rf $(VENV); \
	else \
		echo "No virtual environment found at $(VENV), skipping"; \
	fi

# Generate a new virtual environment and install dependencies
venv: clean
	$(PYTHON) -m venv $(VENV)
	$(VENV_PYTHON) -m pip install --upgrade pip
	$(VENV_PIP) install -r requirements.txt
	echo -e "Run the following command to activate the virtual environment:"
	echo -e "\033[34msource $(VENV_PATH)/activate\033[0m"

update_requirements: clean
	$(PYTHON) -m venv $(VENV)
	$(VENV_PYTHON) -m pip install --upgrade pip
	$(VENV_PIP) install -r requirements-loose.txt
	$(VENV_PIP) freeze > requirements.txt
