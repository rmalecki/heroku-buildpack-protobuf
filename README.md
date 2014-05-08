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
https://github.com/hfwang/heroku-buildpack-protobuf.git
https://github.com/heroku/heroku-buildpack-nodejs.git
EOF

git push heroku master
```

## Building

You can build the protobuf lib by taking a look at `make.sh`, the comment at the
top explains how to build via anvil (the heroku build service). When executed
successfully, anvil will print a URL where the built binaries will be available
from.
