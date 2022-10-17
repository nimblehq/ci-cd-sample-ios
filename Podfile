platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

def testing_pods
  pod 'Quick'
  pod 'Nimble'
  pod 'RxNimble', subspecs: ['RxBlocking', 'RxTest']
  pod 'RxSwift'
  # TODO: Remove or update the version of `1.8.0` to the newest version (not 1.8.1) when init a new project.
  # Currently, there is a bug on `1.8.1` - the newest version.
  pod 'Sourcery', '1.8.0'
  pod 'SwiftFormat/CLI'
  pod 'SwiftLint'
end

target 'WeatherToday' do

  # Rx
  pod 'RxAlamofire'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'RxSwift'
  pod 'FirebaseAppDistribution'

  target 'WeatherTodayTests' do
    inherit! :search_paths
    testing_pods
  end

  target 'WeatherTodayUITests' do
    testing_pods
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      config.build_settings['ENABLE_BITCODE'] = 'NO'
    end
  end
end
