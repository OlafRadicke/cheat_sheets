journalctl
==========

```bash
journalctl --since --until "2 minutes ago" 
```

Use the -r option to display the newest log entries first
---------------------------------------------------------

```bash
ournalctl -r
```

Display specific number of recent log entries
---------------------------------------------

```bash
journalctl -n 3
```

Display log entries of specific priority
----------------------------------------

Use the –p [priority] option to display only log entries of a specific [priority]. Valid priorities are debug, info, notice, warning, err, crit, alert, and emerg. The following example displays only crit log entries. Entries with err priority and higher are in red.

```bash
journalctl -p crit
```
