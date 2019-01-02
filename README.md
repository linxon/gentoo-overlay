
gentoo-overlay
=

![Image](https://raw.githubusercontent.com/linxon/gentoo-overlay/master/logo.png)
Useful tools for gentoo linux

---
#### Make sure that layman and git are installed
```
# emerge --sync && emerge app-portage/layman git
```

#### Add this overlay

```
# layman -a linxon
```

or

```
# layman -o https://raw.github.com/linxon/gentoo-overlay/master/repo.xml -f -a linxon
```

#### Manually
Add an entry to `/etc/portage/repos.conf`:
```ini
[reagentoo]
location = /usr/local/portage/reagentoo
sync-uri = https://github.com/reagentoo/gentoo-overlay.git
sync-type = git
auto-sync = yes
```
---


