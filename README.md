# yoctobuild

[yocotcore](https://github.com/schollz/yoctocore) builder.

inspired by the [original gh workflow](https://github.com/schollz/yoctocore/blob/main/.github/workflows/build.yml).


## image build

    docker build -t yoctobuild .


## usage

run:

    docker run -it --rm --name yoctobuild -p 1234:1234 --platform linux/amd64 yoctobuild
    git clone --recursive https://github.com/schollz/yoctocore
    cd yoctocore

build yoctocore:

    make yoctocore-release

build web interface:

    make web

it gets accessible at http://localhost:1234/


#### note for Apple ARM / colima

if running on `aarm` (Apple ARM) w/ [colima](https://github.com/abiosoft/colima), you'd need to install i386 emulation support w/ (see [#989](https://github.com/abiosoft/colima/issues/989)):

    docker run --privileged --rm tonistiigi/binfmt --install 386

you'd need to do this after every fresh `colima start`.

likewise, to prevent docker complaining about platform mismatch, you can pass the `--platform linux/amd64` option when `docker run`ning the aleph-builder container.

#### emacs

i typically precise a container name w/ e.g. `--name yoctobuild`.

this allows me to jump directly in the container w/ TRAMP:

    /docker:yoctobuild:~/

my typicall launch command is:

    docker run -it --rm --platform linux/amd64 -v ~/Documents/code/monome/yoctocore:/root/yoctocore --name yoctobuild yoctobuild

```el
(defun yoctoflash ()
  (interactive)
  (let* ((remote-path "/docker:yoctobuild:/root/yoctocore/yoctocore.uf2")
         (local-path "/tmp/yoctocore.uf2")
         (flash-cmd "pv -batep /tmp/yoctocore.uf2 > /media/eigen/RPI-RP2/_core.uf2"))
    (message "Copying UF2 file...")
    (copy-file remote-path local-path t)
    (message "Flashing UF2 file...")
    (async-shell-command flash-cmd "*yoctobuild-flash*")))
```

```
