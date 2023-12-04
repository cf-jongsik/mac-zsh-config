    #! /bin/bash

    # OS check
    KERNEL=$(uname) > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "no uname? check bin or env:path";
        exit;
    fi

    if [ $KERNEL = 'Darwin' ]; then
        echo "Mac";
        OS="Mac"
        # zsh pre-installed
    elif [ $KERNEL = 'Linux' ] ; then
        echo "Linux";
        OS="Linux"
        # zsh check
        zsh -c exit > /dev/null 2>&1
        if [[ $? -ne 0 ]]; then
            echo "Install Zsh first"
            echo "example: sudo apt install zsh"
            exit;
        fi
    else
        echo "noway Jose, Kernel?"
        exit;
    fi

    # curl check
    curl -V > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "please install curl";
        echo "example: sudo apt install curl \
            brew install curl \
            sudo yum install curl \
            sudo pacman -S curl"
        exit;
    fi

    # root check
    if [ $(id -u) -ne 0 ]; then
        # sudo check
        sudo -v > /dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo "no sudo, please install sudo or run as root";
            echo "example: apt install sudo";
            exit;
        else
            # copy completions with sudo
            sudo mkdir -p "/usr/local/share/zsh/site-functions";
            sudo curl -Lk "https://github.com/cf-jongsik/mac-zsh-config/raw/main/_cloudflared" -o "/usr/local/share/zsh/site-functions/_cloudflared";
            sudo curl -Lk "https://github.com/cf-jongsik/mac-zsh-config/raw/main/_warp-cli" -o "/usr/local/share/zsh/site-functions/_warp-cli";
        fi
    else
        # copy completions as root
        mkdir -p "/usr/local/share/zsh/site-functions";
        curl -Lk "https://github.com/cf-jongsik/mac-zsh-config/raw/main/_cloudflared" -o "/usr/local/share/zsh/site-functions/_cloudflared";
        curl -Lk "https://github.com/cf-jongsik/mac-zsh-config/raw/main/_warp-cli" -o "/usr/local/share/zsh/site-functions/_warp-cli";
    fi
    # remove old dump
    rm -rf ~/.zcomp* ;
    # init
    zsh;