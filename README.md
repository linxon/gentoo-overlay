
gentoo-overlay
=
Useful tools for gentoo linux

---
#### Add this overlay

```
# eselect repository enable linxon
# emaint sync --repo linxon
```

#### Using layman (make sure that layman and git are installed)

```
# emerge --sync && emerge app-portage/layman git
# layman -a linxon
```

or

```
# layman -o https://raw.github.com/linxon/gentoo-overlay/master/repo.xml -f -a linxon
```

#### Manually
Add an entry to `/etc/portage/repos.conf/linxon.conf`:
```ini
[linxon]
location = /var/db/repos/linxon
sync-uri = https://github.com/linxon/gentoo-overlay.git
sync-type = git
auto-sync = yes
```
---

#### Tool request
if you have any suggestions for adding new tools please feel free to create a pull request or alert me via email@linxon.ru
