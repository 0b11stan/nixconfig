```bash
podman build -t archlinux .
alias openshot='podman run --rm --volume /tmp/.X11-unix:/tmp/.X11-unix --volume $PWD:/mnt --env DISPLAY=$DISPLAY --network host --name archlinux archlinux'
```
