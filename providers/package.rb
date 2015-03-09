def whyrun_supported?
  true
end

use_inline_resources

action :install do
  name = new_resource.name
  mirror = node['r']['mirror']
  package_version_command = Mixlib::ShellOut.new(
    "R -q -e 'packageVersion(\"#{name}\")'"
  )
  package_version_command.run_command()
  if package_version_command.error?
    package_install_script = <<-EOH
      R -q -e "install.packages('#{name}', repos = '#{mirror}')"
    EOH
    bash "install R package #{name}" do
      code package_install_script
    end
  end
end
