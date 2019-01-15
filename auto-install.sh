#!/bin/bash

# 通用校验输入的方法
# 全局变量
input="N"
while true; do
    read -p "Do you want to install MongoDB?" yn
    case $yn in
        [Yy]* ) make install; break;;
        [Nn]* ) exit;;
        * ) echo "Please enter Y/y/N/n .";;
    esac
done

# 获取当前系统
OS=`uname -s`
if [ $OS == "Darwin" ];then
	echo "系统为 macOS "
elif [ $OS == "Linux" ];then
	echo "系统为 Linux"
else
	echo "系统为: $OS, 暂不支持, 退出运行."
fi

# todo distribution 发行版
dist=`uname -a`


# 1. 如果是linux系统登录root用户
if [ $OS == "Linux" ] ; then
    if [ `whoami` == "root" ] ; then
        echo "root has login"
    else
        echo "login root user, please input password"
        su root
    fi
fi

# 2. macOS先安装 brew 
if [ $OS == "Darwin" ] ; then
    cmdNum=`command -v git | grep -w "git" -c`
    # result 等于0 表示没有找到git 命令，需要安装git，不同系统安装命令不一样
    if [ $cmdNum -le 0 ]; then
        echo "Install homebrew"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo "Homebrew installed"
    fi
fi

# 3. 安装git
result=`command -v git | grep -w "git" -c`
# result 等于0 表示没有找到git 命令，需要安装git，不同系统安装命令不一样
if [ $result -le 0 ]; then
    echo "Install git"
    
    if [ $OS == "Darwin" ] ; then
        brew install git
    elif [ $OS == "Linux" ] ; then
        apt-get update
        apt install git
    fi

else
    echo "Git installed"
fi

# 4. git clone 安装脚本到本地
path='/Users/lym/Desktop/auto-install'
#path=''$HOME'/Downloads/auto-install'
#mkdir -p "$path"
#rm -rf "$path"
#git clone git@github.com:bpzj/auto-install.git "$path"

# 5. linux 下安装git 服务器
if [ $OS == "Linux" ] ; then
    bash ''$path'/linux/ins-git-server.sh'
fi

# 6. mac 安装iterm2
if [ $OS == "Darwin" ] ; then
    bash ''$path'/mac/ins-iterm.sh'
fi

# 7. 安装zsh, 主题ys


# 8. 是否按照mongodb