require 'yaml'
require 'capybara/dsl'
require 'pry'
require './lib/tekucal/convert2ical'
require './lib/tekucal/loader'
require './lib/tekucal/exporter'
require './lib/tekucal/event_struct'

module Tekucal
  CONDFIG_FILE = 'config.yml'
  SCHEDULE_FILE = "schedule.csv"
  ICAL_FILE = "schedule.ical"

  def self.run
    load_config
    browser_init
    Exporter.new(@config).run
    Convert2Ical.new.run
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
