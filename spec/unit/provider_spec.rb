require 'spec_helper'

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
