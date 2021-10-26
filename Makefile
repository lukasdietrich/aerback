.PHONY: install install-script install-config install-systemd

SRC_BIN     = $(wildcard usr/local/bin/*)
SRC_ETC     = $(wildcard usr/local/etc/aerback/*)
SRC_SYSTEMD = $(wildcard usr/local/lib/systemd/system/*)

DST_BIN     = /usr/local/bin
DST_ETC     = /usr/local/etc/aerback
DST_SYSTEMD = /usr/local/lib/systemd/system

install: install-script install-config install-systemd

install-script:
	install -d $(DST_BIN)
	install -b -m 0755 -t $(DST_BIN) $(SRC_BIN)

install-config:
	install -d $(DST_ETC)
	install -b -m 0600 -t $(DST_ETC) $(SRC_ETC)

install-systemd: 
	install -d $(DST_SYSTEMD)
	install -b -m 0644 -t $(DST_SYSTEMD) $(SRC_SYSTEMD)
