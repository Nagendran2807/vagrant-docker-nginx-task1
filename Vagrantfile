
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  # boxes at https://vagrantcloud.com/search.
  config.vm.provider = "virtualbox"
  config.vm.box = "centos/7"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  config.vm.network "forwarded_port", guest: 80, host: 4444, host_ip: "127.0.0.1"


   config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
     vb.memory = "1024"
   end


  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
#   config.vm.provision "shell", inline: <<-SHELL   	       
  #  SHELL
#   config.vm.provision "file", source: "transfer/", destination: "$HOME/" 
   config.vm.provision "file" do |file|
	 file.source = "transfer/"
	 file.destination = "$HOME/"
   end 
   
   config.vm.provision "shell", path: "docker-installation.sh" 
end
