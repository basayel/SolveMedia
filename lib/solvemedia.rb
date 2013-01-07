# SolveMedia
require 'view_methods'
require 'controller_methods'

module SolveMedia
  VERIFY_SERVER = 'http://verify.solvemedia.com'
  API_SERVER = 'http://api.solvemedia.com'
  API_SECURE_SERVER = 'https://api-secure.solvemedia.com'
  SIGNUP_URL = 'http://portal.solvemedia.com/portal/public/signup'
  
  class AdCopyError < StandardError
  end

  def self.CONFIG_FILE
    "#{Rails.root.to_s}/config/solvemedia_config.yml"
  end

  def self.CONFIG
    YAML.load_file(self.CONFIG_FILE) if File.exist?(self.CONFIG_FILE)
  end

  def self.check_for_keys!
    if !File.exist?("#{self.CONFIG_FILE}") || self.CONFIG.nil? || self.CONFIG['C_KEY'].nil? || self.CONFIG['V_KEY'].nil? || self.CONFIG['H_KEY'].nil?
      raise AdCopyError, "Solve Media API keys not found. Keys can be obtained at #{SIGNUP_URL}"
    end
  end
end

class ActionView::Base
  include SolveMedia::ViewMethods
end

class ActionController::Base
  include SolveMedia::ControllerMethods
end
