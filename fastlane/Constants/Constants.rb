# frozen_string_literal: true

class Constants
  #################
  #### PROJECT ####
  #################

  # Workspace path
  def self.WORKSPACE_PATH
    './WeatherToday.xcworkspace'
  end

  # Project path
  def self.PROJECT_PATH
    './WeatherToday.xcodeproj'
  end

  # bundle ID for Staging app
  def self.BUNDLE_ID_STAGING
    'com.example.weathertoday'
  end

  # bundle ID for Production app
  def self.BUNDLE_ID_PRODUCTION
    'com.example.weathertoday'
  end

  #################
  #### BUILDING ###
  #################

  # a derived data path
  def self.DERIVED_DATA_PATH
    './DerivedData'
  end

  # a build path
  def self.BUILD_PATH
    './Build'
  end

  #################
  #### TESTING ####
  #################

  # a device name
  def self.DEVICE
    ENV.fetch('DEVICE', 'iPhone 12 Pro Max')
  end

  # a scheme name for testing
  def self.TESTS_SCHEME
    'WeatherToday Staging'
  end

  # a target name for tests
  def self.TESTS_TARGET
    'WeatherTodayTests'
  end

  # a target name for UI tests
  def self.UI_TESTS_TARGET
    'WeatherTodayUITests'
  end

  # xcov output directory path
  def self.XCOV_OUTPUT_DIRECTORY_PATH
    './fastlane/xcov_output'
  end

  # test output directory path
  def self.TEST_OUTPUT_DIRECTORY_PATH
    './fastlane/test_output'
  end

  #################
  #### KEYCHAIN ####
  #################

  # Keychain name
  def self.KEYCHAIN_NAME
    'github_action_keychain'
  end

  # a scheme name for unit testing
  def self.KEYCHAIN_PASSWORD
    'password'
  end

  #################
  ### ARCHIVING ###
  #################

   # a developer portal team id
  def self.DEV_PORTAL_TEAM_ID
    '{PROJECT_TEAM_ID}'
  end

  # an staging environment scheme name
  def self.SCHEME_NAME_STAGING
    'WeatherToday Staging'
  end

  # a Production environment scheme name
  def self.SCHEME_NAME_PRODUCTION
    'WeatherToday'
  end

  # an staging product name
  def self.PRODUCT_NAME_STAGING
    'WeatherToday Staging'
  end

  # a staging TestFlight product name
  def self.PRODUCT_NAME_STAGING_TEST_FLIGHT
    'WeatherToday TestFlight'
  end

  # a Production product name
  def self.PRODUCT_NAME_PRODUCTION
    'WeatherToday'
  end

  # a main target name
  def self.MAIN_TARGET_NAME
    'WeatherToday'
  end

end
