# 1. ���ȵ�½root�û�
if [ `whoami` == "root" ] ; then
    echo "root has login"
else
    echo "login root user, please input password"
    su root
fi

# 2. ���ݴ������, �����û�
USER_NAME='bpzj'
USER_COUNT=`cat /etc/passwd | grep "^$USER_COUNT:" -c`

if [ $USER_COUNT -ne 1 ]
    then
		useradd $USER_NAME
		echo "4260" | passwd --stdin $USER_NAME
    else
		echo 'user exits'
fi
