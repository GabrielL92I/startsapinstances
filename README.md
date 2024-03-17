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

- S4 SID=S4H, HANA DB SID=HDB. Change to your SID instances accordingly.
- Give chmod 775 permissions to the file.

Credits:
Gabriel Lami
