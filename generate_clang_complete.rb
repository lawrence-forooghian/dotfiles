require 'xcodeproj'
require 'shellwords'
require 'set'

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

      args = Set.new

      args << "-isysroot #{Shellwords.escape(@sdkroot)}"
      args << "-std=gnu99"
      args << "-fobjc-arc"
      args << "-miphoneos-version-min=7.0"
      args << "-fmodules"
      # TODO pull preprocessor macros out of Xcode
      args << "-DDEBUG=1"

      # TODO do this in a better way; this is to make sure that we can see XCTest. Not sure why it wasn't already picked up
      args << "-F /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks"

      project_args = extract_args_from_build_configuration_list(pbxproject.build_configuration_list)
      args.merge(project_args)

      pbxproject.targets.each do |target|
        target_args = extract_args_from_build_configuration_list(target.build_configuration_list, target.name)
        args.merge(target_args)
      end

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

        args.concat(extract_args_from_enumerable(build_settings["FRAMEWORK_SEARCH_PATHS"], "-F", target_name))
        args.concat(extract_args_from_enumerable(build_settings["HEADER_SEARCH_PATHS"], "-I", target_name))

        # TODO figure out exactly what Xcode is doing with its
        # -I~/Library/Developer/Xcode/DerivedData/{blah}/Build/Intermediates/{blah}/Debug-iphoneos/{blah}.build/{blah}-all-target-headers.hmap,
        # but seems to basically include as header search paths all of the
        # locations of the target's headers (whatever exactly that means)
        header_directories = Dir.glob(File.join(@srcroot, "**", "*.h")).inject(Set.new) { |set, header_path| set << File.dirname(header_path); set }
        args.concat(extract_args_from_enumerable(header_directories, "-I", target_name))

        prefix_header_path = build_settings["GCC_PREFIX_HEADER"]
        if (prefix_header_path)
          args.concat(extract_args_from_enumerable([prefix_header_path], "-include", target_name))
        end
      end

      return args
    end

    def extract_args_from_enumerable(enumerable_or_nil, flag, target_name)
      args = []
      return args if !enumerable_or_nil
      return args if !enumerable_or_nil.is_a? Enumerable

      enumerable_or_nil.each do |value|
        if (value != "$(inherited)")
          resolved_args = self.resolve(value, target_name).collect do |resolved_value|
            "#{flag} #{Shellwords.escape(resolved_value)}"
          end
          args.concat(resolved_args)
        end
      end

      return args
    end

    def resolve(value, target_name)
      return [] if (value.include? "$(SYMROOT)")
      return [] if (value.include? "$(SYSTEM_APPS_DIR)")
      return [] if (value.include? "$(OBJROOT)")
      return [] if (value.include? "$(TARGET_BUILD_DIR)")

      build_environment = { 
                            "SDKROOT" => @sdkroot,
                            "DEVELOPER_FRAMEWORKS_DIR" => File.join(@developer_library_dir, "Frameworks"),
                            "DEVELOPER_LIBRARY_DIR" => @developer_library_dir,
                            "SRCROOT" => @srcroot,
                            "PROJECT_DIR" => @srcroot,
                            "LOCAL_LIBRARY_DIR" =>  "/Library",
                            "TARGET_NAME" => target_name,
                            "SD_KITT_DIR"=>"/Users/lawrence.forooghian/code/storefront/BMW/Library/KITTInCarCommunication/com.saffrondigital.BMW"
                          }
      resolved_value = value.gsub(/\$\((\w+)\)/) do |match|
        key = $1
        value = build_environment[key]
        raise "Could not resolve environment key #{key}" if !value
        value
      end

      resolved_value = resolved_value.gsub('"', '')

      if !resolved_value.start_with?(File::SEPARATOR)
        resolved_value = File.expand_path(File.join(@srcroot, resolved_value))
      end

      # TODO looks like Xcode checks and only passes clang the directories that
      # actually contain headers or frameworks
      glob_expanded_resolved_values = nil
      if resolved_value.include?("**")
        glob_expanded_resolved_values = Dir.glob(resolved_value + File::SEPARATOR)
      else
        glob_expanded_resolved_values = [resolved_value]
      end

      return glob_expanded_resolved_values
    end

  end

end

Runner.run
