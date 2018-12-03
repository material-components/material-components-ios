Pod::Spec.new do |s|
  s.name         = "MaterialComponentsSnapshotTests"
  s.version      = "70.1.0"
  s.authors      = "The Material Components authors."
  s.summary      = "This spec is an aggregate of all the Material Components snapshot tests."
  s.homepage     = "https://github.com/material-components/material-components-ios"
  s.license      = 'Apache 2.0'
  s.source       = { :git => "https://github.com/material-components/material-components-ios.git", :tag => "v#{s.version}" }
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.dependency 'MaterialComponents'
  s.dependency 'MaterialComponentsAlpha'

  # Cards

  s.subspec "Cards" do |component|
    component.ios.deployment_target = '8.0'
    component.test_spec 'tests' do |tests|
      tests.test_spec 'snapshot' do |snapshot_tests|
        snapshot_tests.requires_app_host = true
        snapshot_tests.source_files = "components/#{component.base_name}/tests/snapshot/*.{h,m,swift}", "components/#{component.base_name}/tests/snapshot/supplemental/*.{h,m,swift}"
        snapshot_tests.resources = "components/#{component.base_name}/tests/snapshot/resources/*"
        snapshot_tests.dependency "MaterialComponentsSnapshotTests/private/Snapshot"
      end
    end
  end

  # Private for Snapshot test helpers

  s.subspec "private" do |private_spec|
    private_spec.test_spec "Snapshot" do |snapshot|
      snapshot.ios.deployment_target = '8.0'
      snapshot.source_files = "components/private/#{snapshot.base_name}/*.{h,m,swift}"
      snapshot.dependency 'iOSSnapshotTestCase', '2.2.0'
    end
  end
end
