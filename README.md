# disposable-vm
My scripts for copying and sshing into a VM.


**config.sh** -  includes the amount of RAM and cores you want to have in your VM.

**run_main_iso.sh** - takes the ISO as an argument, starts your OS graphically with the ISO.

**run_main_graphical.sh** - if you haven't set up ssh yet, this is what you use.

**run_main_ssh.sh** - starts your vm and automatically connects to ssh.

**run_clone.sh** - copies your vm and automatically connects to ssh. Deleted automatically when the VM shuts down.
