module SnapshotPodspecHelper
  class Component
    attr_accessor :name
    attr_accessor :source_files
    attr_accessor :resources

    def initialize(name)
      @name = name
      @source_files = default_source_files
      @resources = default_resources
    end

    def default_source_files
      if @name.present?
        source_files = Dir["components/#{@name}/tests/snapshot/*.{h,m,swift}"]
        supplemental_files = Dir["components/#{@name}/tests/snapshot/supplemental/*.{h,m,swift}"]
        example_files = Dir["components/#{@name}/examples/tests/snapshot/*.{h,m,swift}"]
        extension_files = Dir["components/#{@name}/tests/snapshot/*/*.{h,m,swift}"]
        return source_files + supplemental_files + example_files + extension_files
      end
      return []
    end

    def default_resources
      if @name.present?
        return [
          "components/#{@name}/tests/snapshot/resources/*",
        ]
      end
      return []
    end
  end

  def self.snapshot_sources
    base_sources = ["components/private/Snapshot/src/*.{h,m,swift}", "components/private/Snapshot/src/*/*.{h,m,swift}"]
    return components.reduce(base_sources) do |sources_so_far, component|
      sources_so_far + component.source_files
    end
  end

  def self.snapshot_resources
    return components.reduce([]) do |resources_so_far, component|
      resources_so_far + component.resources
    end
  end

  def self.components
    return Dir["components/**/tests/snapshot"].map { |dir|
      dir = Component.new(dir.split(File::SEPARATOR)[1])
    }
  end
end

Pod::Spec.new do |s|
  s.name         = "MaterialComponentsSnapshotTests"
  s.version      = "115.1.0"
  s.authors      = "The Material Components authors."
  s.summary      = "This spec is an aggregate of all the Material Components snapshot tests."
  s.homepage     = "https://github.com/material-components/material-components-ios"
  s.license      = 'Apache 2.0'
  s.source       = { :git => "https://github.com/material-components/material-components-ios.git", :tag => "v#{s.version}" }
  s.platform     = :ios, '10.0'
  s.requires_arc = true
  s.dependency 'MaterialComponents'
  s.dependency 'MaterialComponentsExamples'

  # Top level sources are required. Without them, unit test targets do not show up in Xcode.
  # However, no top level sources can import iOSSnapshotTestCase, otherwise the app will crash on
  # launch because XCTest isn't found.
  s.source_files = ["components/private/Snapshot/src/SourceDummies/*.{h,m}"]

  s.test_spec "SnapshotTests" do |snapshot_tests|
    snapshot_tests.ios.deployment_target = '10.0'
    snapshot_tests.requires_app_host = true
    snapshot_tests.source_files = SnapshotPodspecHelper.snapshot_sources
    snapshot_tests.resources = SnapshotPodspecHelper.snapshot_resources
    snapshot_tests.dependency 'iOSSnapshotTestCase/Core', '2.2.0'
  end
end
