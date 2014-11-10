if defined?(ChefSpec)
  def upgrade_chocolatey_package(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:chocolatey, :upgrade, resource_name)
  end
end
