# AdSilencify

Silence Spotify ads under Linux. Whenever the script detects an advertisement that is played, it turns off the system sound. When the advertisement is over, it increases the volume back to it's original value.

## Installation

You just have to checkout the project to your device by using git. Open a terminal
and enter the following command:

`$ git clone https://github.com/ysorge/ad-silencify.git/ ~/ad-silencify`

## Usage

1. Start Spotify.
2. Open a terminal and start the shell script, e.g. with `~/ad-silencify/ad-silencify.sh`

## How it works

The script uses the D-Bus messaging system to communicate with applications that implement the MPRIS (Media Player Remote Interfacing Specification) D-Bus interface. Specifically, it queries metadata from the Spotify client. It should work out of the box on a wide range of Linux distributions, including Ubuntu and its derivatives, Fedora, Debian, Linux Mint, Arch Linux and its derivatives (e.g., Manjaro), openSUSE, and CentOS. 
