module Procedures::ForemanDocker
  class RemoveForemanDocker < ForemanMaintain::Procedure
    metadata do
      advanced_run false
      description 'Drop foreman_docker plugin'
    end

    def docker_package
      'tfm-rubygem-foreman_docker'
    end

    def run
      return unless execute?("rpm -q #{docker_package}")
      execute!('foreman-rake foreman_docker:cleanup')
      package_action(:remove, [docker_package])
    end
  end
end