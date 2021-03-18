# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'tabi!' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for tabi!

  target 'tabi!Tests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'tabi!UITests' do
    # Pods for testing
  end
  
  platform :ios, '14,4'
  
  source 'https://cdn.cocoapods.org/'
  
  # add the Firebase pod for Google Analytics
#  pod 'Firebase/Analytics'
#  pod 'Firebase/Core'
#  pod 'Firebase/Firestore'
#  pod 'FirebaseUI'
#  pod 'FirebaseFirestoreSwift'
#  pod 'FirebaseUI/Google'
#  pod 'Firebase/Auth'
#  # add pods for any other desired Firebase products
  # https://firebase.google.com/docs/ios/setup#available-pods
  
  pod 'Firebase/AdMob'
  pod 'Firebase/Analytics'
  pod 'Firebase/Database'
  pod 'Firebase/RemoteConfig'
  pod 'Firebase/Storage'
  pod 'Firebase/Crashlytics'
  pod 'GoogleSignIn'
  pod 'Firebase/Auth'
  
#  pod 'GoogleSignIn', '~> 5.0'

  
  #warning消したい
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
  end

end
