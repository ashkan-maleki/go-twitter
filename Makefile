all: run

#===============================
# Environment setup
#===============================

env-setup:
	sudo apt install python3.10-venv
	sudo apt install python3-pip

#===============================
# Git commands
#===============================

# In Windows, you should use git bash to run this command.
COMMIT_MESSAGE ?= $(shell bash -c 'read -p "Commit Message: " COMMIT_MESSAGE; echo $$COMMIT_MESSAGE')

commit:
	git add .
	git commit -m "$(COMMIT_MESSAGE)"

push: commit
	git push

pull:
	git fetch
	git pull

sync: pull push


#USERNAME ?= $(shell bash -c 'read -p "Username: " username; echo $$username')
#PASSWORD ?= $(shell bash -c 'read -s -p "Password: " pwd; echo $$pwd')
#
#
#
#talk:
#	@clear
#	@echo Username › $(USERNAME)
#	@echo Password › $(PASSWORD)

#===============================
# Project setup
#===============================

pyenv-create:
	python -m venv venv

freeze:
	pipreqs . --force

install-py-packages:
	pip install pipreqs
	pip install -r requirements.txt

setup: pyenv-create pyenv-activate


# don't run this command, because source cannot executed in makefile
# I keep this command here for convenience
pyenv-activate:
	source venv/bin/activate



pyenv-deactivate:
	deactivate

#===============================
# Project run
#===============================
# Feed
#===============================
run: run-feed

run-feed:
	go run feed/cmd/service/main.go

#===============================
# Project django
#===============================
DJANGO_APP ?= $(shell bash -c 'read -p "Django App: " DJANGO_APP; echo $$DJANGO_APP')
migrate:
	python manage.py migrate

mk-migration:
	python manage.py makemigrations $(DJANGO_APP)

shell:
	python manage.py shell