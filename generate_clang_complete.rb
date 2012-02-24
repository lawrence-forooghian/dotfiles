require 'pathname'

# This should be automated at some point
STANDARD_PREAMBLE = <<PREAMBLE_
-fblocks
-nostdinc
-x objective-c-header
-I/usr/lib/clang/3.1/include

-I/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator5.0.sdk/usr/include
-F/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator5.0.sdk/System/Library/Frameworks
-F/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator5.0.sdk/Developer/Library/Frameworks

-D__IPHONE_OS_VERSION_MIN_REQUIRED=050100
PREAMBLE_

all_pathnames = `find .`.split("\n").collect { |path| Pathname.new path }

pch_pathnames = all_pathnames.select { |path| path.extname == '.pch' }
absolute_pch_pathnames = pch_pathnames.collect { |path| path.expand_path }

framework_pathnames = all_pathnames.select { |path| path.extname == '.framework' }
unique_absolute_framework_directories_pathnames = framework_pathnames.collect { |path| path.dirname.expand_path }.uniq

header_pathnames = all_pathnames.select { |path| path.extname == '.h' }
unique_absolute_header_directories_pathnames = header_pathnames.collect { |path| path.dirname.expand_path }.uniq

#TODO: escape names so "Unit Tests" works
puts STANDARD_PREAMBLE
puts unique_absolute_framework_directories_pathnames.collect { |path| "-F#{path}"}
puts absolute_pch_pathnames.collect { |path| "-include#{path}" }
puts unique_absolute_header_directories_pathnames.collect{ |path| "-I#{path}" } 
