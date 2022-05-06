#!/bin/bash
CheckSysAndInstallSngrep()
{
    if grep -Eqii "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
        echo 'CentOS'
        CentOSInstallSngrep
    elif grep -Eqi "Red Hat Enterprise Linux Server" /etc/issue || grep -Eq "Red Hat Enterprise Linux Server" /etc/*-release; then
        echo 'RHEL'
        CentOSInstallSngrep
    elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
        echo 'Debian'
        DebianInstallSngrep
    elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
        echo 'Ubuntu'
        UbuntuInstallSngrep
    else
        echo 'unknow system'
    fi
}

DebianInstallSngrep(){
    cat >>  /etc/apt/sources.list <<-'EOF'
deb http://packages.irontec.com/debian squeeze main
deb http://packages.irontec.com/debian wheezy main
deb http://packages.irontec.com/debian jessie main
deb http://packages.irontec.com/debian stretch main
EOF
    wget http://packages.irontec.com/public.key -q -O - | apt-key add -
    apt-get update
    apt-get install sngrep
}

UbuntuInstallSngrep(){
    cat >> /etc/apt/sources.list <<-'EOF'
deb http://packages.irontec.com/ubuntu trusty main
deb http://packages.irontec.com/ubuntu precise main
deb http://packages.irontec.com/ubuntu vivid main
deb http://packages.irontec.com/ubuntu xenial main
deb http://packages.irontec.com/ubuntu zesty main
deb http://packages.irontec.com/ubuntu artful main
EOF
    wget http://packages.irontec.com/public.key -q -O - | apt-key add -
    apt-get update
    apt-get install sngrep
}

CentOSInstallSngrep(){
    cat >> /etc/yum.repos.d/irontec.repo <<-'EOF'
[irontec]
name=Irontec RPMs repository
baseurl=http://packages.irontec.com/centos/\$releasever/\$basearch/
EOF
    rpm --import http://packages.irontec.com/public.key
    yum install sngrep -y
}

CheckSysAndInstallSngrep
