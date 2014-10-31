require 'xcodeproj'
require 'shellwords'

class Runner

  def self.run
    project_dir_paths = Dir.glob('./**/*.xcodeproj')

    if (project_dir_paths.length == 0)
      raise "No Xcode project directories found."
    end

    project_dir_paths.each do |project_dir_path|
      project = Project.new(project_dir_path)
      project.write_file
    end
  end

  class Project

    def initialize(project_dir_path)
      @project_dir_path = project_dir_path
      @srcroot = File.expand_path(File.join(@project_dir_path, '..'))
      xcode_path = `xcode-select --print-path`.strip
      @sdkroot = File.join(xcode_path, 'Platforms', 'iPhoneSimulator.platform', 'Developer', 'SDKs', 'iPhoneSimulator.sdk')
      @developer_library_dir = File.join(xcode_path, 'Library')
    end

    def write_file
      project = Xcodeproj::Project.open(@project_dir_path)
      pbxproject = project.root_object

      args = []

      args << "-isysroot #{Shellwords.escape(@sdkroot)}"
      args << "-fobjc-arc"
      args << "-std=gnu99"

      project_args = extract_args_from_build_configuration_list(pbxproject.build_configuration_list)
      args.concat(project_args)

      pbxproject.targets.each do |target|
        target_args = extract_args_from_build_configuration_list(target.build_configuration_list, target.name)
        args.concat(target_args)
      end

      args.sort!.uniq!

      clang_complete_filename = File.join(@srcroot, '.clang_complete')
      File.open(clang_complete_filename, 'w') do |f|
        args.each do |arg|
          f << arg + "\n"
        end
      end
      $stderr.puts("Created #{clang_complete_filename}")
    end

    def extract_args_from_build_configuration_list(build_configuration_list, target_name = nil)
      args = []

      build_configuration_list.build_configurations.each do |configuration|
        build_settings = configuration.build_settings

        args.concat(extract_args_from_array(build_settings["FRAMEWORK_SEARCH_PATHS"], "-F", target_name))
        args.concat(extract_args_from_array(build_settings["HEADER_SEARCH_PATHS"], "-I", target_name))

        prefix_header_path = build_settings["GCC_PREFIX_HEADER"]
        if (prefix_header_path)
          args << "-include #{Shellwords.escape(self.resolve(prefix_header_path, target_name))}"
        end
      end

      return args
    end

    def extract_args_from_array(array_or_nil, flag, target_name)
      args = []
      return args if !array_or_nil
      return args if !array_or_nil.is_a? Array

      array_or_nil.each do |value|
        if (value != "$(inherited)")
          args << "#{flag} #{Shellwords.escape(self.resolve(value, target_name))}"
        end
      end

      return args
    end

    def resolve(value, target_name)
      build_environment = { 
                            "SDKROOT" => @sdkroot,
                            "DEVELOPER_FRAMEWORKS_DIR" => File.join(@developer_library_dir, "Frameworks"),
                            "DEVELOPER_LIBRARY_DIR" => @developer_library_dir,
                            "SRCROOT" => @srcroot,
                            "PROJECT_DIR" => @srcroot,
                            "LOCAL_LIBRARY_DIR" =>  "/Library",
                            "TARGET_NAME" => target_name,
                          }
      result = value.gsub(/\$\((\w+)\)/) do |match|
        key = $1
        value = build_environment[key]
        raise "Could not resolve environment key #{key}" if !value
        value
      end

      result = result.gsub('"', '')

      if !result.start_with?(File::SEPARATOR)
        result = File.expand_path(File.join(@srcroot, result))
      end

      return result
    end

  end

end

Runner.run
