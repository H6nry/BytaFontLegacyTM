TARGET := iphone:clang

TARGET_SDK_VERSION := 6.1
TARGET_IPHONEOS_DEPLOYMENT_VERSION := 6.1
ARCHS := armv7

#CFLAGS = -Wno-unused-function #how to remove annoying errors :) use with caution

include theos/makefiles/common.mk

TWEAK_NAME = BytaFontLegacyTM
BytaFontLegacyTM_FILES = Tweak.xm
BytaFontLegacyTM_PRIVATE_FRAMEWORKS = GraphicsServices

include $(THEOS_MAKE_PATH)/tweak.mk


SUBPROJECTS += bfltmprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
