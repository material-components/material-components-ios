require 'xcodeproj'
project_path = '../Pods/Pods.xcodeproj'
pods_project = Xcodeproj::Project.open(project_path)

scheme_filename = "MaterialComponents-Unit-Tests.xcscheme"

user_data_dir = Xcodeproj::XCScheme.user_data_dir(pods_project.path)
shared_data_dir = Xcodeproj::XCScheme.shared_data_dir(pods_project.path)

old_path = File.join(user_data_dir, scheme_filename)
new_path = File.join(shared_data_dir, scheme_filename)

scheme = Xcodeproj::XCScheme.new File.join(user_data_dir, scheme_filename)
launch_action = scheme.launch_action
environment_variables = launch_action.environment_variables
goldens_environment_variable = Xcodeproj::XCScheme::EnvironmentVariable.new(:key => "FB_REFERENCE_IMAGE_DIR", :value => "$(SOURCE_ROOT)/../../ui_test_goldens")
environment_variables.assign_variable(goldens_environment_variable)
launch_action.environment_variables = environment_variables
scheme.launch_action = launch_action
puts scheme.launch_action.environment_variables
scheme.save!

FileUtils.mv(old_path, new_path)