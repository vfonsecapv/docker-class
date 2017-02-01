# Rancher Demo using Vagrant

This is a simple Vagrantfile that allows a quick example of how to use Rancher.
This is not intended for anything production-related.

# Use

Run:

    vagrant up

Wait several minutes for all images to download and VM to start.
What this does:

1. Creates a single VM as the `rancher-server`. This will automatically install
and start the server for you.
1. Creates two 'mostly' blank Linux boxes running Ubuntu 14.04. The only
additional step it takes is to install the latest stable release of Docker
for you.

When everything is up, you can visit your Rancher user interface by going to
`172.30.0.100:8080` (give it time to start up even after the VM is created).

# Add the Hosts

To add the two hosts that are available:

1. Go to the Rancher Server, click `Infrastructure`, and `Add Host`.
Select `Save` the first time you visit this page.
1. Select `Custom` and copy that string in `Step 4`
1. SSH into the two boxes and run that command you just copied.
    * `vagrant ssh rancher-host-01` and `vagrant ssh rancher-host-02`
    * Run the command on each host `sudo docker run -d --privileged...`
1. After running the command on both hosts, return to the Rancher interface
1. Click on the `Infrastructure` -> `Hosts` tab, after a minute or so the
new hosts will appear in that list!
1. Follow tutorials online for how to create Application Stacks, add Services,
etc.
