dwlDir="/dwl";

. ${dwlDir}/envvar.sh
. ${dwlDir}/user.sh
. ${dwlDir}/ssh.sh

echo ">> Ubuntu initialized";

echo ">> Base initialized";

. ${dwlDir}/permission.sh
echo ">> permission assigned";

. ${dwlDir}/activateconf.sh
echo ">> dwl conf activated";

if [ "`find /etc/lestencrypt/live/${DWL_USER_DNS} -type f &> /dev/null | wc -l`" = "0" ]; then
    . ${dwlDir}/openssl.sh
    echo ">> Openssl initialized";
fi

. ${dwlDir}/apache2.sh
echo ">> apache2 initialized";

. ${dwlDir}/certbot.sh
echo ">> certbot initialized";

. ${dwlDir}/sendmail.sh
echo ">> sendmail initialized";

. ${dwlDir}/keeprunning.sh
