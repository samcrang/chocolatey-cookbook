require 'chefspec'
require 'chefspec/berkshelf'

describe 'chocolatey::default' do
  context 'on a supported OS' do
    let(:chef_run) {
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2012').converge(described_recipe)
    }

    it 'installs chocolatey' do
      expect(chef_run).to run_powershell_script('install chocolatey')
    end

    it 'upgrades chocolatey' do
      expect(chef_run).to upgrade_chocolatey_package('chocolatey')
    end
  end

  context 'on an unsupported OS' do
    let(:chef_run) {
      ChefSpec::SoloRunner.new(platform: 'debian', version: '7.6').converge(described_recipe)
    }

    it 'does not install chocolatey' do
      expect(chef_run).to_not run_powershell_script('install chocolatey')
    end
  end
end
