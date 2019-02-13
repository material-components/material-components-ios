Pod::Spec.new do |s|
  s.name         = "MaterialComponentsSnapshotTests"
  s.version      = "76.1.2"
  s.authors      = "The Material Components authors."
  s.summary      = "This spec is an aggregate of all the Material Components snapshot tests."
  s.homepage     = "https://github.com/material-components/material-components-ios"
  s.license      = 'Apache 2.0'
  s.source       = { :git => "https://github.com/material-components/material-components-ios.git", :tag => "v#{s.version}" }
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.dependency 'MaterialComponents'
  s.dependency 'MaterialComponentsBeta'
  s.dependency 'iOSSnapshotTestCase', '2.2.0'

  s.subspec "BottomNavigation" do |component|
    component.ios.deployment_target = '8.0'
    component.source_files = [
      "components/private/Snapshot/src/Dummy/Dummy.h",
      "components/private/Snapshot/src/Dummy/Dummy.m",
    ]
    component.test_spec 'SnapshotTests' do |snapshot_tests|
      snapshot_tests.requires_app_host = true
      snapshot_tests.source_files = [
        "components/#{component.base_name}/tests/snapshot/*.{h,m,swift}",
      ]
      snapshot_tests.dependency "MaterialComponentsSnapshotTests/private"
    end
  end

  s.subspec "Cards" do |component|
    component.ios.deployment_target = '8.0'
    component.source_files = [
      "components/private/Snapshot/src/Dummy/Dummy.h",
      "components/private/Snapshot/src/Dummy/Dummy.m",
    ]
    component.test_spec 'SnapshotTests' do |snapshot_tests|
      snapshot_tests.requires_app_host = true
      snapshot_tests.source_files = [
        "components/Cards/tests/snapshot/*.{h,m,swift}",
        "components/Cards/tests/snapshot/supplemental/*.{h,m,swift}",
      ]
      snapshot_tests.resources = "components/#{component.base_name}/tests/snapshot/resources/*"
      snapshot_tests.dependency "MaterialComponentsSnapshotTests/private"
    end
  end

#  s.subspec "Chips" do |component|
#    component.ios.deployment_target = '8.0'
#    component.test_spec 'tests' do |tests|
#      tests.test_spec 'snapshot' do |snapshot_tests|
#        snapshot_tests.requires_app_host = true
#        snapshot_tests.source_files = "components/#{component.base_name}/tests/snapshot/*.{h,m,swift}", "components/#{component.base_name}/tests/snapshot/supplemental/*.{h,m,swift}"
#        snapshot_tests.resources = "components/#{component.base_name}/tests/snapshot/resources/*"
#        snapshot_tests.dependency "MaterialComponentsSnapshotTests/private/Snapshot"
#      end
#    end
#  end
#
#  s.subspec "Ripple" do |component|
#    component.ios.deployment_target = '8.0'
#    component.test_spec 'tests' do |tests|
#      tests.test_spec 'snapshot' do |snapshot_tests|
#        snapshot_tests.requires_app_host = true
#        snapshot_tests.source_files = "components/#{component.base_name}/tests/snapshot/*.{h,m,swift}", "components/#{component.base_name}/tests/snapshot/supplemental/*.{h,m,swift}"
#        snapshot_tests.dependency "MaterialComponentsSnapshotTests/private/Snapshot"
#      end
#    end
#  end
#
# s.subspec "TextFields" do |component|
#    component.ios.deployment_target = '8.0'
#    component.test_spec 'tests' do |tests|
#      tests.test_spec 'snapshot' do |snapshot_tests|
#        snapshot_tests.requires_app_host = true
#        snapshot_tests.source_files = "components/#{component.base_name}/tests/snapshot/*.{h,m,swift}", "components/#{component.base_name}/tests/snapshot/supplemental/*.{h,m,swift}"
#        snapshot_tests.resources = "components/#{component.base_name}/tests/snapshot/resources/*"
#        snapshot_tests.dependency "MaterialComponentsSnapshotTests/private/Snapshot"
#        snapshot_tests.dependency "MDFInternationalization"
#      end
#    end
#  end

  # Private for Snapshot test helpers

  s.subspec "private" do |private_spec|
    private_spec.source_files = [
     "components/private/Snapshot/src/*.{h,m,swift}",
    ]
  end
end
