# aerback - *a*ge *e*ncrypted *r*clone *back*ups

This repository provides a small bash script to encrypt files and folders and back them up to a
remote storage of your choice.

1. Create a compressed archive with [tar][tar].
2. Encrypt the archive with [age][age].
3. Copy the encrypted archive to one of many supported backend via [rclone][rclone].

## Requirements

- [tar][tar]
- [age][age]
- [rclone][rclone]
- [systemd][systemd] (\*)

(\*): Optional

## Installation

The script, as well as a systemd [service][systemd.service] and [timer][systemd.timer], can be
installed with the provided `Makefile` to `/usr/local/{bin, etc, lib}`.

You may need root privileges to execute the `Makefile`.
As with everything coming from the internet, please review the files before executing anything!

```sh
git clone https://github.com/lukasdietrich/aerback
cd aerback/
sudo make install
```

## Configuration

The three configuration files are located at `/usr/local/etc/aerback`.

Configuration File                      | Description
--------------------------------------- | ----------------------------------------------------------------------------
`/usr/local/etc/aerback/files.txt`      | Newline separated list of filepaths to backup.
`/usr/local/etc/aerback/recipients.txt` | Newline separated list of [public keys][age.recipients] used for encryption. 
`/usr/local/etc/aerback/remote.txt`     | A single line containing the name of the rclone remote.

If you want to modify the systemd [timer][systemd.timer] or [service][systemd.service], you can add
a drop-in via `systemctl edit aerback.service` or `systemctl edit aerback.timer`.

### Run as a different user

You may want to run the backups as a user other than root. For security reasons or for rclone to
find your personal `rclone.conf`.

```
systemctl edit aerback.service

# [Service]
# User=myuser
```

### Run at a different time

The timer defaults to weekly execution on saturday at 00:00 local time.
If you prefer a different time, you need to override the `OnCalendar` attribute.

```
systemctl edit aerback.timer

# [Timer]
# OnCalendar=
# OnCalendar=daily
```

[age]: https://github.com/FiloSottile/age
[age.recipients]: https://github.com/FiloSottile/age#recipient-files
[rclone]: https://github.com/rclone/rclone
[tar]: https://manpages.ubuntu.com/manpages/bionic/de/man1/tar.1.html
[systemd]: https://manpages.ubuntu.com/manpages/bionic/man1/systemd.1.html
[systemd.timer]: https://manpages.ubuntu.com/manpages/bionic/man5/systemd.timer.5.html
[systemd.service]: https://manpages.ubuntu.com/manpages/bionic/man5/systemd.service.5.html
