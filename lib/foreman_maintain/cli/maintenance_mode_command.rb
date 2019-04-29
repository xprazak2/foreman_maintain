module ForemanMaintain
  module Cli
    class MaintenanceModeCommand < Base
      extend Concerns::Finders

      subcommand 'start', 'Start maintenance-mode' do
        def execute
          scenario = Scenarios::MaintenanceModeStart.new
          run_scenario(scenario)
          exit runner.exit_code
        end
      end

      subcommand 'stop', 'Stop maintenance-mode' do
        def execute
          scenario = Scenarios::MaintenanceModeStop.new
          run_scenario(scenario)
          exit runner.exit_code
        end
      end

      subcommand 'remove-docker', 'remove docker' do
        def execute
          scenario = Scenarios::DropForemanDocker.new
          run_scenario scenario
          exit runner.exit_code
        end
      end

      subcommand 'status', 'Get maintenance-mode status' do
        def execute
          scenario = Scenarios::MaintenanceModeStatus.new
          run_scenario(scenario)
          exit runner.exit_code
        end
      end

      subcommand 'is-enabled', 'Get maintenance-mode status code' do
        def execute
          scenario = Scenarios::IsMaintenanceMode.new
          run_scenario(scenario)
          procedure_used = fetch_procedure(scenario, Procedures::MaintenanceMode::IsEnabled)
          puts procedure_used.status_code

          if procedure_used.status_code == 1
            exit procedure_used.status_code
          else
            exit runner.exit_code
          end
        end

        def fetch_procedure(scenario, procedure_class_name)
          scenario.steps.find { |procedure| procedure.class.eql?(procedure_class_name) }
        end
      end
    end
  end
end
