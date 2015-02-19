TARGET := iphone:clang

TARGET_SDK_VERSION := 6.1
TARGET_IPHONEOS_DEPLOYMENT_VERSION := 6.1
ARCHS := armv7

include theos/makefiles/common.mk

BUNDLE_NAME = bfltmprefs
bfltmprefs_FILES = bfltmprefs.mm
bfltmprefs_INSTALL_PATH = /Library/PreferenceBundles
bfltmprefs_FRAMEWORKS = UIKit
bfltmprefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/bfltmprefs.plist$(ECHO_END)
