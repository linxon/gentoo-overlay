gentoo-overlay
==============

Useful tools for gentoo linux

-----------------

#### Make sure that layman and git are installed ####
```
emerge --sync && emerge app-portage/layman git
```

#### Add this overlay ####

```
layman -o https://raw.github.com/linxon/gentoo-overlay/master/repo.xml -f -a linxon
```
