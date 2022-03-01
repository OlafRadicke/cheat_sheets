List of helpful tools
=====================

* [sign git commits](git_sign.md)
* [journalctl](journalctl.md): System logs
* *neofetch:* CLI system information tool written in Btools/md-icons.mdash
* *htop:* Interactive process viewer
* *Markdown*
  * *ghostwriter:* Cross-platform, aesthetic, distraction-free Markdown editor
  * *pandoc:* Conversion between markup formats
  * *[Marp for VS Code](https://yhatt.github.io/marp/):* Creating presentation with visual code IDE and markdown
  * [markdown icons](md-icons.md)
* *mediawriter:* Fedora Media Writer for creat boot usb sticks
* *geteltorito:* El Torito boot image extractor
* *bash:*
  * `systemd-run` for long running jobs


VirtualBox
----------

Übersichtstabelle Zugriffsmöglichkeiten

| Netzwerktyp | Gast -> andere Gäste | Host -> Gast | Gast -> externes Netzwerk |
|-------------|----------------------|--------------|---------------------------|
| Not attached | N | N | N |
| Network Address Translation (NAT) | N | N | Y |
| Network Address Translation Service | Y | N | Y |
| Bridged networking | Y | Y | Y |
| Internal networking  | Y | N | N |
| Host-only networking | Y | Y | N |