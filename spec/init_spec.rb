# for serverspec documentation: http://serverspec.org/
require 'spec_helper'

pkgs = ['nomad']
services = ['nomad']
files = ['/etc/nomad/nomad.hcl']

pkgs.each do |pkg|
    describe package("#{pkg}") do
        it { should be_installed }
    end
end

files.each do |file|
    describe file("#{file}") do
        it { should be_file }
        it { should be_mode 644 }
        it { should be_owned_by 'root' }
    end
end

services.each do |service|
    describe service("#{service}") do
        it { should be_running }
    end
end

describe port(4646) do
    it { should be_listening }
end
