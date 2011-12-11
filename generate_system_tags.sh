find /Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator4.3.sdk/System/Library/Frameworks -name '*.h' | /usr/local/bin/ctags --language-force=objectivec -f ~/tagsfiles/ios_system_framework_tags --c-kinds=+px -L -

find /Library/Frameworks/ -name '*.h' | /usr/local/bin/ctags --language-force=objectivec -f ~/tagsfiles/library_framework_tags --c-kinds=+px -L -

find /System/Library/Frameworks/ -name '*.h' | /usr/local/bin/ctags --language-force=objectivec -f ~/tagsfiles/system_framework_tags --c-kinds=+px -L -

find /usr/include/ -name '*.h' | /usr/local/bin/ctags -f ~/tagsfiles/usr_include_tags --c-kinds=+px -L -
