APanel: main.vala
	valac main.vala -o ALaunch --pkg gtk+-3.0

all: clean Panel

clean:
	rm -f APanel
	
install: all
	cp -f ALaunch /usr/bin/APanel
