# Pathagar snap

This is an Ubuntu Snap package for the Pathagar Book Server.


## Development


### Setup

(Optional) If you don't have an Ubuntu machine you can use Vagrant to setup a virtual
machine.

    $ vagrant up
    $ vagrant ssh
    $ cd /vagrant


### Snap

Run all the stages to build the snap.

    $ snapcraft --debug

Install the snap locally. The name of the snap will depend on your git history.

    $ sudo snap install --devmode pathagar_0+git.008ee0a-dirty_amd64.snap


