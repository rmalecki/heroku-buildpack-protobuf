# heroku-buildpack-mapnik

I am a Heroku buildpack that installs
[Protocol Buffers](https://code.google.com/p/protobuf/)).
I was built by stripping down
[heroku-buildpack-mapnik](https://github.com/mojodna/heroku-buildpack-mapnik)

When used with
[heroku-buildpack-multi](https://github.com/ddollar/heroku-buildpack-multi),
I enable subsequent buildpacks / steps to link to these libraries.  (You'll
need to use the `build-env` branch of [@mojodna's
fork](https://github.com/mojodna/heroku-buildpack-multi/tree/build-env) for the
build environment (`CPATH`, `LIBRARY_PATH`, etc.) to be set correctly.)

*Note:* Python bindings are *not* currently included.

When creating a new Heroku app:

```bash
heroku apps:create -b https://github.com/mojodna/heroku-buildpack-multi.git#build-env

cat << EOF > .buildpacks
https://github.com/hfwang/heroku-buildpack-protobuf.git
https://github.com/heroku/heroku-buildpack-nodejs.git
EOF

git push heroku master
```

When modifying an existing Heroku app:

```bash
heroku config:set BUILDPACK_URL=https://github.com/mojodna/heroku-buildpack-multi.git#build-env

cat << EOF > .buildpacks
https://github.com/mojodna/heroku-buildpack-mapnik.git
https://github.com/heroku/heroku-buildpack-nodejs.git
EOF

git push heroku master
```

## Building

GDAL and proj were built according to [the steps in the GDAL buildpack](https://github.com/mojodna/heroku-buildpack-gdal#building).

Everything else was built in an Ubuntu 10.04 `chroot`. (See
[heroku/stack-images](https://github.com/heroku/stack-images) for package
listings and post-installation.)

`chroot` preparation:

```bash
mkdir app tmp
sudo /vagrant/bin/install-stack cedar64-2.0.0.img.gz
sudo mount -o bind /dev /mnt/stacks/cedar64-2.0.0/dev/
sudo mount -o bind /home/vagrant/tmp /mnt/stacks/cedar64-2.0.0/tmp/
sudo mount -o bind /home/vagrant/app /mnt/stacks/cedar64-2.0.0/app/
```

[Steps to be updated next time Mapnik or its dependencies are upgraded.]
