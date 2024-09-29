ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0
THEOS_DEVICE_IP = localhost -p 2222
INSTALL_TARGET_PROCESSES = SpringBoard

# THEOS_PACKAGE_SCHEME = rootless
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = LookinLoader
LookinLoader_FILES = LookinLoader.xm

include $(THEOS_MAKE_PATH)/tweak.mk

