#! /bin/sh

#Check if ClientAP shall be limited
#

logfile="/tmp/ClientAP.log"
echo "$(date):ClientAP invoked" >> $logfile

ClientRadio0off="/tmp/ClientRadio0.off"
ClientRadio0on="/tmp/ClientRadio0.on"

CurrentTime="$(date +%k%M)"
CurrentDayOfWeek="$(date +%w)"
#echo "CurrentTime is $CurrentTime, CurrentDayOfWeek is $CurrentDayOfWeek"

dummy=$(uci get wireless.client_radio0.disabled)
if [ $? -eq 0 ]; then
  dummy=$(uci get wireless.client_radio0.clock_on)
  if [ $? -eq 0 ]; then
    apclock0on=$(uci get wireless.client_radio0.clock_on)
    apclock0off=$(uci get wireless.client_radio0.clock_off)
    if ( [ ${#apclock0on} -eq 4 ] ) && ( [ ${#apclock0off} -eq 4 ] ) ; then
      if ( [ $CurrentTime -le $apclock0on ] ) || ( [ $CurrentTime -ge $apclock0off ] ) ; then
        if [ $(uci get wireless.client_radio0.disabled) -eq 0 ] ; then
          uci set wireless.client_radio0.disabled=1
          echo "$(date):APradio0 deaktiviert" >> $logfile
          /sbin/wifi
          rm $ClientRadio0on &>/dev/null
          echo 1> $ClientRadio0off
         fi
       else
        if [ $(uci get wireless.client_radio0.disabled) -eq 1 ] ; then
          uci set wireless.client_radio0.disabled=0
          echo "$(date):APradio0 aktiviert" >> $logfile
          /sbin/wifi
          rm $ClientRadio0off &>/dev/null
          echo 1> $ClientRadio0on
        fi
      fi
     else
      echo "wireless.client_radio1.apclock0on or apclock0off not set correctly to hhmm format."
     fi
   fi
 fi

dummy=$(uci get wireless.client_radio1.disabled)
if [ $? -eq 0 ]; then
  dummy=$(uci get wireless.client_radio1.clock_on)
  if [ $? -eq 0 ]; then
    apclock1on=$(uci get wireless.client_radio1.clock_on)
    apclock1off=$(uci get wireless.client_radio1.clock_off)
    if ( [ ${#apclock1on} -eq 4 ] ) && ( [ ${#apclock1off} -eq 4 ] ) ; then
      if ( [ $CurrentTime -le $apclock1on ] ) || ( [ $CurrentTime -ge $apclock1off ] ) ; then
        if [ $(uci get wireless.client_radio1.disabled) -eq 0 ] ; then
          uci set wireless.client_radio1.disabled=1
          echo "$(date):APradio1 deaktiviert" >> $logfile
          /sbin/wifi
          rm $ClientRadio0on &>/dev/null
          echo 1> $ClientRadio1off
         fi
       else
        if [ $(uci get wireless.client_radio1.disabled) -eq 1 ] ; then
          uci set wireless.client_radio1.disabled=0
          echo "$(date):APradio1 aktiviert" >> $logfile
          /sbin/wifi
          rm $ClientRadio0off &>/dev/null
          echo 1> $ClientRadio1on
        fi
      fi
     else
      echo wireless.client_radio1.apclock1on or .apclock1off not set correctly to hhmm format."
     fi
   fi
 fi


#case $CurrentDayOfWeek in
#        0)
#                #echo "Sonntag"
#                DoLimit=1
#                ;;
# esac

#eof
