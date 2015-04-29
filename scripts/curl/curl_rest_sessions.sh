echo List Sessions:
curl -G 'http://admin:admin@localhost:8020/rest/management/sessions' 

echo 
echo 
echo Start Recording
curl 'http://admin:admin@localhost:8020/rest/management/profiles/easyTravel/startrecording' --data-urlencode 'presentableName=easyTravelTestRun1&description=MyTestRun1&isTimeStampAllowed=true'


