# Building the image from Dockerfile

```bash
docker build -t behnke-buildenv .
```

# Running the container

First, prepare your workspace. You'll need to create two directories: `input` and `output`. 

The `input` directory should contain the `*.tar.bz2` file. After running the container, the `output` directory will contain the build output.

```bash
mkdir input
mv <path to Arcturus-Behnke-dist-*.tar.bz2> .
mkdir output
```

Your directory structure should look like this:
```bash
.
├── Dockerfile
├── input
│   └── Arcturus-Behnke-dist-R240.266.1942.tar.bz2
├── output
└── README.md
```

Finally, start the build process.

```bash
docker run -it --rm -v `realpath input`:/tmp  -v `realpath output`:/build-image behnke-buildenv
```

Then, check the `output` folder for the firmware image files.
