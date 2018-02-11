gentoo-overlay
==============

Useful tools for gentoo linux

-----------------
#### Make sure that layman and git are installed ####
```bash
emerge --sync && emerge app-portage/layman git
```

#### Add this overlay ####

```bash
layman -a linxon
```

or

```bash
layman -o https://raw.github.com/linxon/gentoo-overlay/master/repo.xml -f -a linxon
```
-----------------
![Image](http://storage8.static.itmages.com/i/18/0211/h_1518379269_4096683_a697215105.jpg)

