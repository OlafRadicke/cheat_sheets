# K3s

## STORAGE

Configuration in /var/lib/rancher/k3s/server/manifests/local-storage.yam

## KNOWN ISSUES

### failed to create fsnotify watcher: too many open files

Check:

```
sysctl fs.inotify.max_user_watches
sysctl fs.inotify.max_user_instances
```

Fix:

```
sudo sysctl -w fs.inotify.max_user_watches=524288
sudo sysctl -w fs.inotify.max_user_instances=1024
sudo sysctl -p
```

Persistent:

```
echo "fs.inotify.max_user_watches=524288" | sudo tee -a /etc/sysctl.conf
echo "fs.inotify.max_user_instances=1024" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```
