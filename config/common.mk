# Copyright (C) 2019-2020 The CherishOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

PRODUCT_BRAND ?= CherishOS

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.dataroaming=false \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true \
    ro.setupwizard.rotation_locked=true

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Ambient Play
#PRODUCT_PACKAGES += \
#    AmbientPlayHistoryProvider

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED := true
ifneq ($(TARGET_DISABLE_ALTERNATIVE_FACE_UNLOCK), true)
PRODUCT_PACKAGES += \
    FaceUnlockService
TARGET_FACE_UNLOCK_SUPPORTED := true
endif
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face.moto_unlock_service=$(TARGET_FACE_UNLOCK_SUPPORTED)
    
# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/cherish/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/cherish/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/cherish/prebuilt/common/bin/50-base.sh:system/addon.d/50-base.sh

# OTA
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_COPY_FILES += \
    vendor/cherish/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/cherish/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/cherish/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Flipendo
PRODUCT_COPY_FILES += \
    vendor/cherish/config/permissions/pixel_experience_2020.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/pixel_experience_2020.xml
	
# Some permissions
PRODUCT_COPY_FILES += \
    vendor/cherish/config/permissions/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml \
    vendor/cherish/config/permissions/privapp-permissions-cherish.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-cherish.xml

# Copy all custom init rc files
$(foreach f,$(wildcard vendor/cherish/prebuilt/common/etc/init/*.rc),\
    $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/cherish/prebuilt/common/lib/content-types.properties:$(TARGET_COPY_OUT_SYSTEM)/lib/content-types.properties

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/cherish/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Vendor_045e_Product_0719.kl

# TEMP: Enable transitional log for Privileged permissions
PRODUCT_PRODUCT_PROPERTIES += \
    ro.control_privapp_permissions=log

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/cherish/config/permissions/custom-power-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/custom-power-whitelist.xml

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/cherish/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/cherish/overlay/common

#OmniStyle
PRODUCT_PACKAGES += \
    OmniStyle

# TouchGestures
PRODUCT_PACKAGES += \
    TouchGestures

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI \
    NexusLauncherRelease

# PixelSetupWizard overlay
#PRODUCT_PACKAGES += \
#    PixelSetupWizardOverlay \
#    PixelSetupWizardAodOverlay

# Custom Overlays
# Settings
#PRODUCT_PACKAGES += \
#    SystemPitchBlackOverlay \
#    SystemUIPitchBlackOverlay \
#    SystemDarkGrayOverlay \
#    SystemUIDarkGrayOverlay \
#    SystemStyleOverlay \
#    SystemUIStyleOverlay \
#    SystemNightOverlay \
#    SystemUINightOverlay \
#    SystemSolarizedDarkOverlay \
#    SystemUISolarizedDarkOverlay \
#    SystemMaterialOceanOverlay \
#    SystemUIMaterialOceanOverlay \
#    SystemBakedGreenOverlay \
#    SystemUIBakedGreenOverlay \
#    SystemChocoXOverlay \
#    SystemUIChocoXOverlay \
#    SystemDarkAubergineOverlay \
#    SystemUIDarkAubergineOverlay

# Long Screenshot
#PRODUCT_PACKAGES += \
#    StitchImage

PRODUCT_PACKAGES += \
    NoCutoutOverlay

# Branding
include vendor/cherish/config/branding.mk

# Include CherishOS Themes Styles
include vendor/themes/themes.mk

# OTA
include vendor/cherish/config/ota.mk

ifeq ($(CHERISH_WITHGAPPS), true)
include vendor/google/gms/config.mk
include vendor/google/pixel/config.mk
else
include vendor/cherish/config/basicapps.mk
endif

# Do not preoptimize prebuilts when building GApps
DONT_DEXPREOPT_PREBUILTS := true

# Bootanimation
ifeq ($(TARGET_BOOT_ANIMATION_RES),1080)
     PRODUCT_COPY_FILES += vendor/cherish/bootanimation/bootanimation_1080.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
else ifeq ($(TARGET_BOOT_ANIMATION_RES),1440)
     PRODUCT_COPY_FILES += vendor/cherish/bootanimation/bootanimation_1440.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
else ifeq ($(TARGET_BOOT_ANIMATION_RES),720)
     PRODUCT_COPY_FILES += vendor/cherish/bootanimation/bootanimation_720.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
else
    ifeq ($(TARGET_BOOT_ANIMATION_RES),)
        $(warning "CherishStyle: TARGET_BOOT_ANIMATION_RES is undefined, assuming 1080p")
    else
        $(warning "CherishStyle: Current bootanimation res is not supported, forcing 1080p")
    endif
    PRODUCT_COPY_FILES += vendor/cherish/bootanimation/bootanimation_1080.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
endif

# Plugins
include packages/apps/PotatoPlugins/plugins.mk

# Packages
PRODUCT_PACKAGES += \
    Seedvault \
    Terminal \
    StitchImage \
    StitchImageService \
    SimpleDeviceConfig 

  # Required packages
PRODUCT_PACKAGES += \
    ThemePicker \
	 CherishThemesStub
	
#OmniJaws
PRODUCT_PACKAGES += \
    OmniJaws \
    WeatherIcons
	
# Enable blurs, hidden under dev option
PRODUCT_PRODUCT_PROPERTIES += \
    ro.surface_flinger.supports_background_blur=1 \
    persist.sys.sf.disable_blurs=1 \
    ro.sf.blurs_are_expensive=1
	
# Customization
#include vendor/google-customization/config.mk

-include $(WORKSPACE)/build_env/image-auto-bits.mk
