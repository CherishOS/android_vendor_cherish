# Basic
PRODUCT_PACKAGES += \
    messaging \
    Gallery2 \
    Contacts \
    Dialer \
    LatinIME \
    SettingsIntelligenceGoogle \
    SoundPickerGoogleRelease

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += \
    vendor/cherish/overlay-aosp

DEVICE_PACKAGE_OVERLAYS += \
    vendor/cherish/overlay-aosp/common
    
# Build
PRODUCT_BROKEN_VERIFY_USES_LIBRARIES := true
