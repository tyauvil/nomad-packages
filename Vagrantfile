Vagrant.configure("2") do |config|
  config.vm.provider "docker" do |d|
      d.image = "tyauvil/docker-vagrant"
      d.privileged = true
      d.has_ssh = true
      d.ports = ["4646:4646"]
  end

  config.ssh.port = 2222
  config.vm.synced_folder "./build", "/tmp/build", docker_consistency: "delegated"
  config.vm.synced_folder "./tests", "/tmp/tests", docker_consistency: "delegated"

  config.vm.provision "shell",
    inline: "yum list installed | grep nomad || sudo yum localinstall -y /tmp/build/nomad.rpm"
  config.vm.provision "shell",
    inline: "sudo cp /tmp/tests/nomad.hcl /etc/nomad/nomad.hcl; chown root:root /etc/nomad/nomad.hcl"
  config.vm.provision "shell",
    inline: "sudo systemctl restart nomad"

end
