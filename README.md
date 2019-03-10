# Pathagar snap

This is an Ubuntu Snap package for the Pathagar Book Server.


## Usage

Install the snap. _Note: the snap is not published to any store and is unsigned.
`--dangerous` allows it to be installed. `--devmode` is needed before we work
out the kinks._

    $ sudo snap install --dangerous --devmode ./pathagar.snap

Create a superuser.

    $ snap run pathagar.manage createsuperuser

Start pathagar.

    $ snap run pathagar.start

Open your web browser to [localhost:8000](https://localhost:8000/).


## Development


### Setup

(Optional) If you don't have an Ubuntu machine you can use Vagrant to setup a virtual
machine.

    $ vagrant up
    $ vagrant ssh
    $ cd /vagrant


### Building the snap

Prime the snap. This runs through most of the build steps, enough to test and
debug.

    $ snapcraft --debug prime

Install the snap locally with `try`.

    $ sudo snap try --devmode prime

Then, run the snap.

    $ snap run pathagar.start

The final step is to pack the primed files into a snap package.

   $ snapcraft --debug

You'll get a snap, in the current directory, something like
`pathagar_0+git.9128412-dirty_amd64.snap`.


### How snap building works

This section covers topics that I found difficult to find in the official
snapcraft docs.

[Build lifecycle](https://docs.snapcraft.io/snapcraft-lifecycle/5123) looks like this for each part:

1. **pull** will fetch the source code.
1. **build** builds and installs any artifacts.
1. **stage** copies files from the install as specified. Here it is available to
   _other_ parts for consuming in their build step.
1. **prime** copies files from stage area to be packed into the final image.

#### pull

Pretty straightforward with git.


#### build

The python plugin installs your python dependencies from your requirements.txt
as specified. If you need to build python bindings for a native library, the dev
package should be specified in `build-packages`. You could also use
`build-snaps` if there was something in a snap that you need for the build
stage.

It's important that your snap part must also _install_ the files to
`SNAPCRAFT_PART_INSTALL`. If your python app has a setup.py, it will use this to
build your package and install it. Most Django apps do not have a setup.py,
including pathagar. We could add one which will simplify the process. Without
this, we have to manually copy the app to the snap install directory.


#### stage

This step copies files from the install directory. You may have to explicitly
list files to stage by specifying [`filesets`](https://docs.snapcraft.io/snapcraft-filesets/8973) and `staging` options.


#### prime

This step copies files from stage into prime which will become part of the final
image. You may have to explicitly list files to stage by specifying
[`filesets`](https://docs.snapcraft.io/snapcraft-filesets/8973) and `prime`
options.


### Debugging tips

You can run a snap with a shell to inspect the snap. It doesn't setup the shell
like it does when the snap is actually run, though.

    $ snap run --shell pathagar

The snap files are in `$SNAP`, which is also the working directory, I believe.
`$SNAP/command-*.wrapper` is what actually sets up the environment and runs the
command.
