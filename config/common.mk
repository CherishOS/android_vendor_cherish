# Main version
$(call inherit-product, vendor/cherish/config/main_version.mk)

PRODUCT_BRAND ?= CherishOS

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_PROPERTIES += \
    ro.com.google.clientidbase=android-google

PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.clientidbase=android-google

else
PRODUCT_SYSTEM_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)

PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)

endif

# ART
# Optimize everything for preopt
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := everything
# Don't preopt prebuilts
DONT_DEXPREOPT_PREBUILTS := true

PRODUCT_PROPERTY_OVERRIDES += \
    pm.dexopt.boot=verify \
    pm.dexopt.first-boot=quicken \
    pm.dexopt.install=speed-profile \
    pm.dexopt.bg-dexopt=everything

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_PROPERTY_OVERRIDES += \
    pm.dexopt.ab-ota=quicken
endif

# BtHelper
PRODUCT_PACKAGES += \
    BtHelper

PRODUCT_SYSTEM_PROPERTIES += \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_PROPERTIES += ro.adb.secure=1

# Disable extra StrictMode features on all non-engineering builds
PRODUCT_SYSTEM_PROPERTIES += persist.sys.strictmode.disable=true
endif


# Enable WiFi Display
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.wfd.nohdcp=1 \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0

# Blurs
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1

# # Disable blur on app-launch
# PRODUCT_SYSTEM_EXT_PROPERTIES += \
#     ro.launcher.blur.appLaunch=0

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/cherish/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/cherish/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/cherish/prebuilt/common/bin/50-cherish.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-cherish.sh

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    vendor/cherish/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/cherish/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/cherish/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif
endif

# Some permissions
PRODUCT_COPY_FILES += \
    vendor/cherish/config/permissions/backup.xml:system/etc/sysconfig/backup.xml \
    vendor/cherish/config/permissions/cherish-sysconfig.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/cherish-sysconfig.xml

# Copy all custom init rc files
PRODUCT_COPY_FILES += \
    vendor/cherish/prebuilt/common/etc/init/cherish-system.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/cherish-system.rc \
    vendor/cherish/prebuilt/common/etc/init/cherish-updater.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/cherish-updater.rc \
    vendor/cherish/prebuilt/common/etc/init/cherish-ssh.rc:$(TARGET_COPY_OUT_PRODUCT)/etc/init/cherish-ssh.rc

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_PRODUCT)/usr/keylayout/Vendor_045e_Product_0719.kl

# Enable Google LILY_EXPERIENCE feature
PRODUCT_COPY_FILES += \
    vendor/cherish/target/config/permissions/lily_experience.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/lily_experience.xml

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_PROPERTIES += \
    ro.control_privapp_permissions=log

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/cherish/config/permissions/privapp-permissions-cherish-system_ext.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-cherish-system_ext.xml \

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Enable whole-program R8 Java optimizations for SystemUI and system_server,
# but also allow explicit overriding for testing and development.
SYSTEM_OPTIMIZE_JAVA ?= true
SYSTEMUI_OPTIMIZE_JAVA ?= true

# Charger
PRODUCT_PACKAGES += \
    charger_res_images \
    product_charger_res_images

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.ntfs \
    mke2fs \
    mkfs.ntfs \
    mount.ntfs

# # Config
# PRODUCT_PACKAGES += \
#      SimpleDeviceConfig \
#      RepainterServicePriv

# Storage manager
PRODUCT_SYSTEM_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# Overlays
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += \
    vendor/cherish/overlay

PRODUCT_PACKAGE_OVERLAYS += \
    vendor/cherish/overlay/common

# TouchGestures
TARGET_SUPPORTS_TOUCHGESTURES ?= false
ifeq ($(TARGET_SUPPORTS_TOUCHGESTURES),true)
PRODUCT_PACKAGES += \
    TouchGestures \
    TouchGesturesSettingsOverlay
endif

# One Handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true \

# NavigationBarMode
PRODUCT_PACKAGES += \
    NavigationBarMode2ButtonOverlay

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SettingsGoogle \
    SystemUIGoogle \
    NexusLauncherRelease

ifeq ($(TARGET_SUPPORTS_64_BIT_APPS), true)
# Use 64-bit dex2oat for better dexopt time.
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dex2oat64.enabled=true
endif

# SystemUI plugins
 PRODUCT_PACKAGES += \
      GameSpace \
      Aperture \
      ParallelSpace \
      Launcher3QuickStep \
      ThemePicker

#OmniJaws
PRODUCT_PACKAGES += \
    OmniJaws

# # Hide nav Overlays
PRODUCT_PACKAGES += \
    NavigationBarNoHintOverlay  

# Permissions
PRODUCT_COPY_FILES += \
    vendor/cherish/config/permissions/privapp-permissions-cherish-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-cherish-SettingsIntelligencePrebuilt.xml

# Gboard configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.ime.theme_id=5 \
    ro.com.google.ime.system_lm_dir=/product/usr/share/ime/google/d3_lms

# SetupWizard configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.setupwizard.enterprise_mode=1 \
    ro.setupwizard.rotation_locked=true \
    setupwizard.enable_assist_gesture_training=true \
    setupwizard.theme=glif_v3_light \
    setupwizard.feature.baseline_setupwizard_enabled=true \
    setupwizard.feature.skip_button_use_mobile_data.carrier1839=true \
    setupwizard.feature.show_pai_screen_in_main_flow.carrier1839=false \
    setupwizard.feature.show_pixel_tos=false

# StorageManager configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.storage_manager.show_opt_in=false

# OPA configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.opa.eligible_device=true

# Google legal
PRODUCT_PRODUCT_PROPERTIES += \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html

# Google Play services configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent

# TextClassifier
PRODUCT_PACKAGES += \
	libtextclassifier_annotator_en_model \
	libtextclassifier_annotator_universal_model \
	libtextclassifier_actions_suggestions_universal_model \
	libtextclassifier_lang_id_model

# Enable lockscreen live wallpaper
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.wm.debug.lockscreen_live_wallpaper=true

# Use gestures by default
PRODUCT_PRODUCT_PROPERTIES += \
    ro.boot.vendor.overlay.theme=com.android.internal.systemui.navbar.gestural

# Protobuf - Workaround for prebuilt Qualcomm HAL
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full-3.9.1-vendorcompat \
    libprotobuf-cpp-lite-3.9.1-vendorcompat

# Pixel customization
TARGET_SUPPORTS_GOOGLE_RECORDER ?= true
TARGET_INCLUDE_STOCK_ARCORE ?= false
TARGET_INCLUDE_LIVE_WALLPAPERS ?= false
TARGET_SUPPORTS_QUICK_TAP ?= false
TARGET_USES_MINI_GAPPS ?= false

# # Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= $(TARGET_SUPPORTS_64_BIT_APPS)

ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
PRODUCT_PACKAGES += \
    ParanoidSense

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.face.sense_service=true

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Disable touch video heatmap to reduce latency, motion jitter, and CPU usage
# on supported devices with Deep Press input classifier HALs and models
PRODUCT_PRODUCT_PROPERTIES += \
    ro.input.video_enabled=false

# Enable one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true

# NexusLauncher resources
PRODUCT_PACKAGES += \
    NexusLauncherResOverlay

# Audio
$(call inherit-product, vendor/cherish/config/audio.mk)

# Bootanimation
$(call inherit-product, vendor/cherish/config/bootanimation.mk)

# Fonts
$(call inherit-product, vendor/cherish/config/fonts.mk)

ifeq ($(EXTRA_UDFPS_ANIMATIONS),true)
PRODUCT_PACKAGES += \
    UdfpsResources
endif

# Build
ifeq ($(CHERISH_VANILLA), true)
include vendor/cherish/config/basicapps.mk

else

# Inherit from GMS product config
ifeq ($(TARGET_USES_MINI_GAPPS),true)
$(call inherit-product, vendor/gms/gms_mini.mk)
else ifeq ($(TARGET_USES_PICO_GAPPS),true)
$(call inherit-product, vendor/gms/gms_pico.mk)
else
$(call inherit-product, vendor/gms/gms_full.mk)
endif

# RRO Overlays
$(call inherit-product, vendor/cherish/config/rro_overlays.mk)
endif

# OTA
$(call inherit-product, vendor/cherish/config/ota.mk)

# Themes
$(call inherit-product, vendor/themes/themes.mk)

# Enable ThinLTO Source wide Conditionally.
ifeq ($(TARGET_BUILD_WITH_LTO),true)
GLOBAL_THINLTO := true
USE_THINLTO_CACHE := true
SKIP_ABI_CHECKS := true
endif

# Clocks
$(call inherit-product, vendor/cherish/config/clocks.mk)

# Pixel Framework
$(call inherit-product-if-exists, vendor/pixel-framework/config.mk)

-include $(WORKSPACE)/build_env/image-auto-bits.mk
