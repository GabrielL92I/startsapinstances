# startsapinstances

STARTSAPALL.sh is a script with ready commands to start and stop SAP S/4 HANA instances easily and outputing the information colorfully.

- This script use $count, to count processes in start mode "Green" or in stop mode "Grey" and based on the number output 
  detects if the instance has successfully started or stopped. In this way we make sure that HANA has started successfully and 
  we can after start apps like ABAP or AS JAVA.

Features:

- Optional CIN(Central Instance Number).
- Optional Start/Stop Instance based on CIN
- Start/Stop/Show Status of SAP Instances
- 
To run the script:

- chmod 775 /path to the script
- sed -i -e 's/\r$//' /path to the script
- Run it: ./path to the script

Credits:
Gabriel Lami
