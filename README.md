# SquadJS Docker Container
[Docker](https://docs.docker.com/) container containing a basic installation of the [SquadJS](https://github.com/Thomas-Smyth/SquadJS) scripting framework. The installation is mounted on a [volume](#Volume) by default, which can be edited to [configure](#Configuration) the [NodeJS](https://nodejs.org/en/docs/) module.

## Prerequisites
- [Docker](https://docs.docker.com/)

## Running the Container
To [run](https://docs.docker.com/engine/reference/commandline/run/) the container, execute the command below. The -d (--detach) [option](https://docs.docker.com/engine/reference/commandline/run/#options) for detached mode is optional. 
```
$ docker run -d -it larsvansoest/squadjs
```
At first launch, the installation is not [configured](#Configuration) to connect with a [Squad Server](https://squad.gamepedia.com/Dedicated_server). Subsequently, the [SquadJS](https://github.com/Thomas-Smyth/SquadJS) executable will exit. If desired, to override the [SquadJS](https://github.com/Thomas-Smyth/SquadJS) executable entry point, append the run command with command parameters. For example, the command below runs the container with a shell as its default entry point. To run Node from the shell, execute `# node index.js`.
```
$ docker run -d -it larsvansoest/squadjs /bin/sh
```
For instructions on how to configure the SquadJS module, please refer to the [Configuration](#Configuration) section below.

## Volume
The entirety of the source of the container, including the [SquadJS](https://github.com/Thomas-Smyth/SquadJS) installation, is located on a [volume](https://docs.docker.com/storage/volumes/) mount. The [build argument](#Build-Arguments) *DIR* with default value `"home/squad"` specifies the mount location at build time. 

## Configuration
To configure the installed [SquadJS](https://github.com/Thomas-Smyth/SquadJS) module, modify the source in the [volume](#Volume). As usual, the volume can be edited from [within](#Modify-From-Outside-the-Container) and from [outside](#Modify-From-Outside-the-Container). In most cases, modifying from [within](#Modify-From-Outside-the-Container) requires additional container space for the installation of file interaction systems.

### Config.json
The installation source contains the `config.json` file. For an elaborate explanation on the different aspects of the `config.json` file components, please refer to the article '[Configuring SquadJS](https://github.com/Thomas-Smyth/SquadJS#configuring-squadjs)' of the [SquadJS GitHub Repository](https://github.com/Thomas-Smyth/SquadJS), which contains instructions on [server configuration](https://github.com/Thomas-Smyth/SquadJS#server), [connectors](https://github.com/Thomas-Smyth/SquadJS#connectors), [squad layer filters](https://github.com/Thomas-Smyth/SquadJS#squad-layer-filter), [mysql](https://github.com/Thomas-Smyth/SquadJS#mysql), [included plugins](https://github.com/Thomas-Smyth/SquadJS#plugins-1) and [https://github.com/Thomas-Smyth/SquadJS#creating-your-own-plugins](https://github.com/Thomas-Smyth/SquadJS#creating-your-own-plugins).

### Modify From Within the Container
To optimise storage, a docker contains only contain those packages necessary for serving its purpose. Therefore, at first launch, no text editor is included with the container. By default, the container comes with the `sed` command, which allows inline file modification. For instructions and an example on using sed to modify [config.json](#Config.json), please refer to '[Using sed]()' below. If storage optimisation is not the main priority, install a text editor such as [GNU nano](https://en.wikipedia.org/wiki/GNU_nano). For instructions on how to install and edit [config.json](#Config.json), refer to '[Using nano](#Using-nano)' below.

#### Using nano
To install nano, perform the following series of commands below.
```
$ docker run -it larsvansoest/squadjs /bin/sh
# apt-get update
# apt-get intall -y nano
# rm -rf /var/lib/apt/lists/*
# nano config.json
```
Respectively, this series of commands will boot up the container with a shell as default entrypoint, update package definitions, install [nano](https://en.wikipedia.org/wiki/GNU_nano), remove unnessecary data, and launch an editing interface to edit [config.json](#Config.json).

#### Using sed
In order to edit [config.json](#Config.json) using only the command line, execute a `sed` command. The command below serves as an example on how to set the value `1` to the `"id"` field of the server configuration part of the file.
```
sed -i '/"id\"/c\   \"id\": 1,' ${DIR}/SquadJS/config.json
```
For further information, please refer to the [sed manual](https://www.gnu.org/software/sed/manual/sed.html).

### Modify From Outside the Container
As mentioned, modifying the container from [within](#Modify-From-Within-the-Container) may require an increase in container storage size. Therefore, modify and [configure](#Configuration) the installation source with an external source. For instructions and examples, please refer to the examples below.

#### External Editing Example - Gateways
Mount a gateway container on the same volume, and allow a user to connect to it and edit the source from a remote source. Use-case examples are [ftp containers](https://github.com/stilliard/docker-pure-ftpd) and [sftp containers](https://hub.docker.com/r/atmoz/sftp).

#### External Editing Example - Temporary Container
Create a temporary container mounted to the same volume as the original SquadJS container, install the required file editing packages, and modify the volume from there. For examples on how to edit the volume from inside a container, please refer to '[Modify From Within the Container](#Modify-From-Outside-the-Container)'.

## Build Arguments
- DIR `ARG $DIR="home/squad"` *Specifies the [volume](#Volume) mount.*
- GIT `ARG $GIT="https://github.com/Thomas-Smyth/SquadJS.git --single-branch"` *Specifies git clone parameters to fetch the SquadJS source.*
To modify the build arguments illustrated above, build the container with the [docker file](https://hub.docker.com/r/larsvansoest/squadjs/dockerfile). An example is given below.
```
docker build --build-arg DIR="home/squad" --build-arg GIT="https://github.com/Thomas-Smyth/SquadJS.git --single-branch" .
```
For more information, please refer to the [docker build](https://docs.docker.com/engine/reference/commandline/build/) reference.

This README.md is written by Lars van Soest, *dev@larsvansoest.nl*, and published on October 10th, 2020.

## References
- [Docker Docs](https://docs.docker.com/) *Docker Inc. (2020). Docker documentation. Last Accessed: 10-18-2020.*
- [Dockerfile](https://hub.docker.com/r/larsvansoest/squadjs/dockerfile) *Lars van Soest. (2020). The Dockerfile of the container. Last Accessed: 10-18-2020.*
- [NodeJS](https://nodejs.org/en/docs/) *OpenJS Foundation (2020). NodeJS documentation. Last Accessed: 10-18-2020.*
- [Squad Dedicated Server](https://squad.gamepedia.com/Dedicated_server) *Fandom, Inc. (2020). Information related to dedicated servers for Squad. Last Accessed: 10-18-2020.*
- [SquadJS GitHub Repository](https://github.com/Thomas-Smyth/SquadJS) *Thomas Smyth. (2020) Source of the installed SquadJS module. Last Accessed: 10-18-2020. GitHub*
- [Sed, a Stream Editor](https://www.gnu.org/software/sed/manual/sed.html) *GNU.org. (2020) Manual on using sed. Last Accessed: 10-18-2020. Github*
