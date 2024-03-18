# startsapinstances

STARTSAPALL.sh is a script with ready commands to start and stop SAP S/4 HANA instances easily and outputing the information colorfully.

- This script use $count, to count processes in start mode "Green" or in stop mode "Grey" and based on the number output 
  detects if the instance has successfully started or stopped. In this way we make sure that HANA has started successfully and 
  we can after start apps like ABAP or AS JAVA.

What you can add more to this script?!

- You can add times on echo's to calculate the exact time took the HANA DB or APP to start.
- You can add "Status" information to check if the instances are already running or stopped
- You can use this script to automate the process of starting(on boot or reboot) and stopping(before shutdown) the instances by 
  using crontab or rc6.d options in Linux.

To run the script:

- S4 SID=S4H, AS JAVA SID=S4J, HANA DB SID=HDB. Change to your SID instances accordingly.
- Give chmod 775 permissions to the file.

Credits:
Gabriel Lami

![IMAGE_DESCRIPTION](https://private-user-images.githubusercontent.com/44748406/313483162-cea6b819-7761-46ca-80e0-2ed691ac9add.PNG?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MTA3Nzc1MzIsIm5iZiI6MTcxMDc3NzIzMiwicGF0aCI6Ii80NDc0ODQwNi8zMTM0ODMxNjItY2VhNmI4MTktNzc2MS00NmNhLTgwZTAtMmVkNjkxYWM5YWRkLlBORz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDAzMTglMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQwMzE4VDE1NTM1MlomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWJmOWQwOWQyMjQ4NjlmODA2MzAxNDgyMTljNmMxZjFlZmI1ZjJkNzcyNDI1ZWM5Zjk3MWJhYTI0ODQ4MmM5ZjkmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.Xcq2AWuONAVvlJCTZZCngDrtCPl9TY_k1t0WggibPoY)
