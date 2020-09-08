platform :ios, '12.0'
use_frameworks!
inhibit_all_warnings!
workspace 'ios-row'


def projectPods

end


def unitTestPods

end


def uiTestPods

end

target 'ios-row' do
  projectPods

  target 'ios-rowTests' do
    inherit! :search_paths
    unitTestPods
  end

  target 'ios-rowUITests' do
    inherit! :search_paths
    uiTestPods
  end

end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.0'
    end
  end
end
