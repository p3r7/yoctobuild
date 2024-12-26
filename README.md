# yoctobuild

[yocotcore](https://github.com/schollz/yoctocore) builder.

inspired by the [original gh workflow](https://github.com/schollz/yoctocore/blob/main/.github/workflows/build.yml).


## image build

    docker build -t yoctobuild .


## usage

run:

    docker run -it --rm --name yoctobuild yoctobuild
    git clone --recursive https://github.com/schollz/yoctocore
    cd yoctocore

build yoctocore:

    make yoctocore
