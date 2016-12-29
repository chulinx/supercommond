#/bin/bash
###

CONFIGFILE=/mds/supercommod/etc/supercommod.conf
if [ ! -f $CONFIGFILE ]
then
        echo "$CONFIGFILE does not exist ! "
fi

. $CONFIGFILE

irunshell()
{
scp $3 $i:$4
ssh -t $i chown mds:mds $4 && chmod 774 $4
ssh $i bash -x $4
}


hrunshell()
{
echo -e  ${RED_COLOR}"正在复制shell文件$2"${RES}
scp $3 $2:$4
ssh -t $2 chown mds:mds $4 >$DefaultDir/supercommond.log 2>&1
ssh -t $2 chmod 774 $4 >$DefaultDir/supercommond.log 2>&1
ScriptName=`echo $3 |awk -F '\/' '{print $NF}'` >$DefaultDir/supercommond.log 2>&1
echo -e ${RED_COLOR}正在执行Scripts...${RES}
ssh $2 bash  $4$ScriptName
}
