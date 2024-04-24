# Inherit common mobile CherishOS stuff
$(call inherit-product, vendor/cherish/config/common.mk)

# Charger
PRODUCT_PACKAGES += \
    vendor_charger_res_images

# Default notification/alarm sounds
ifeq ($(WITH_GMS),true)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.config.notification_sound=Eureka.ogg \
    ro.config.alarm_alert=Fresh_start.ogg
else
PRODUCT_PRODUCT_PROPERTIES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg
endif

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# SystemUI plugins
PRODUCT_PACKAGES += \
    QuickAccessWallet

# LatinIME
PRODUCT_PACKAGES += \
    LatinIME
