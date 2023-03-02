-- Do not autocommit on Ctl-C crashouts
set exitcommit OFF
set sqlformat ANSICONSOLE
set timing ON
set serveroutput ON size 500000
set sqlprompt "@|white _USER|@@@|green _CONNECT_IDENTIFIER|@@|white > |@"
