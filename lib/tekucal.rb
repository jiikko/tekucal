require 'yaml'
require 'capybara/dsl'
require 'pry'

module Tekucal
  CONDFIG_FILE = 'config.yml'

  def self.run
    load_config
    browser_init
    exporter = Exporter.new(@config)
    csv = exporter.run
  end

  private

  def self.load_config
    config_file = File.join(File.expand_path('../../', __FILE__), CONDFIG_FILE)
    if File.exists?(config_file)
      @config = YAML.load_file(config_file)
    else
      puts 'not found condfig_path'
      exit 1
    end
  end

  def self.browser_init
    browser_name = :firefox
    Capybara.run_server = false
    Capybara.register_driver(browser_name) do |app|
      Capybara::Selenium::Driver.new(app, {
        browser: browser_name,
      })
    end
    Capybara.current_driver = browser_name
  end
  Capybara.reset_sessions!
end
