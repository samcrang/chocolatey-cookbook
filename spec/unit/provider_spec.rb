require 'spec_helper'
require '../libraries/chocolatey_helpers.rb'


describe 'chocolatey_test::install_package' do
  context 'on a supported OS' do
    let(:chef_run) {
      ChefSpec::SoloRunner.new(
        platform: 'windows',
        version: '2012',
        step_into: 'chocolatey'
      ).converge(described_recipe)
    }

    it 'installs package' do
      expect(chef_run).to run_execute('install package test-package').with(command: /[^\"].+\/bin\/choco\" install test-package/)
    end

    it 'installs package at a specific version' do
      expect(chef_run).to run_execute('install package test-package-version version 0.0.1').with(command: /[^\"].+\/bin\/choco\" install test-package-version -version 0.0.1/)
    end
  end
end

describe 'chocolatey_test::remove_package' do
  context 'on a supported OS' do
    let(:chef_run) {
      ChefSpec::SoloRunner.new(
        platform: 'windows',
        version: '2012',
        step_into: 'chocolatey'
      )
    }

    it 'removes package' do
      chef_run.converge(described_recipe) do
        ChocolateyHelpers.stub(:package_installed?).and_return(true)
        ChocolateyHelpers.stub(:package_exists?).and_return(true)
      end
      expect(chef_run).to run_execute('uninstall package test-package').with(command: /[^\"].+\/bin\/choco\" uninstall test-package/)
    end
  end
end
