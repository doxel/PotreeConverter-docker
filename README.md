# potree_converter-build

## License

This program is part of the DOXEL project <[http://doxel.org](http://doxel.org)>.
Copyright (c) 2015-2017 ALSENET SA - http://www.alsenet.com
This program is licensed under the terms of the
GNU Affero General Public License v3 (http://www.gnu.org/licenses/agpl.html)
(GNU AGPL).

## About 

This docker image is intended for building PotreeConverter from source and for testing.

A second container (potree_converter-bin) should be built using the resulting binaries to reduce the image weight.

## Install

```
git clone https://github.org/doxel/PotreeConverter-build
cd PotreeConverter-build
make && sudo make install
```

## Use

A ```PotreeConverter``` script is installed in /usr/local/bin as a shortcut to run the container.

Default docker options are set to:
```
DOCKER_DEFAULTS="-v /mnt:/mnt -it --rm=true"
```

That means that your /mnt directory will be accessible by PotreeConverter, and that input and output files should be loaded and saved there.

You can redefine ```DOCKER_DEFAULTS```, or set more options with ```DOCKER_OPTIONS```


### Example

For example you can run:
```
DOCKER_OPTIONS="--cpus=2" PotreeConverter -p potree -o /mnt/workdir/potree /mnt/workdir/pointcloud.ply
```

