gentoo-overlay
==============

Rescue tools for gentoo linux

-----------------

#### Install layman ####
```
emerge --sync && emerge app-portage/layman git
```

#### Add this repository ####

```
layman -o https://raw.github.com/linxon/gentoo-overlay/master/repo.xml -f -a linxon
```
