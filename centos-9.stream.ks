#install
text
reboot
lang en_US.UTF-8
keyboard us
network --bootproto dhcp
rootpw builder
sshpw --username root --plaintext builder
firewall --enabled --ssh
timezone --utc America/New_York
selinux --enforcing

# systemd.unified_cgroup_hierarchy=0 for LP#1936005
bootloader --location=mbr --append="console=tty0 console=ttyS0,115200 rd_NO_PLYMOUTH systemd.unified_cgroup_hierarchy=0"

url --url="https://odcs.stream.centos.org/test/latest-CentOS-Stream/compose/BaseOS/x86_64/os"

repo --name="AppStream" --baseurl="https://odcs.stream.centos.org/test/latest-CentOS-Stream/compose/AppStream/x86_64/os"

zerombr
clearpart --all --initlabel --disklabel=gpt
autopart --type=plain

# Halt the system once configuration has finished.
poweroff

%packages
@core
acpid
cloud-init
cloud-utils-growpart
%end

services --enabled=sshd,cloud-init
