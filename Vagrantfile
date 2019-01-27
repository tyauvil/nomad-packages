Vagrant.configure("2") do |config|
  config.vm.provider "docker" do |d|
      d.image = "tyauvil/docker-vagrant"
      d.privileged = true
      d.has_ssh = true
      d.ports = ["4646:4646"]
  end

  config.ssh.port = 2222

  config.vm.provision "shell",
    inline: "yum list installed | grep nomad || sudo yum localinstall -y /vagrant/build/nomad.rpm"
  config.vm.provision "shell",
    inline: "sudo cp /vagrant/tests/nomad.hcl /etc/nomad/nomad.hcl; chown root:root /etc/nomad/nomad.hcl"
  config.vm.provision "shell",
    inline: "sudo systemctl start nomad"

end
