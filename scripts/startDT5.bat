rem Stop all dynaTrace 5.6.0 services

net start "dynaTrace Analysis Server 5.6.0"
net start "dynaTrace Collector 5.6.0"
net start "dynaTrace Host Agent 5.6.0"
net start "dynaTrace Server 5.6.0"
net start "dynaTrace Web Server Agent 5.6.0"

rem Set the startup type (manual, demand, disabled)
sc config "dynaTrace Analysis Server 5.6.0" start= manual
sc config "dynaTrace Collector 5.6.0" start= disabled
sc config "dynaTrace Host Agent 5.6.0" start= disabled
sc config "dynaTrace Server 5.6.0" start= disabled
sc config "dynaTrace Web Server Agent 5.6.0" start= manual