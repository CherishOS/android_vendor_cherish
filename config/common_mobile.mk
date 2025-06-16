# Inherit common mobile CherishOS stuff
$(call inherit-product, vendor/cherish/config/common.mk)

# Charger
PRODUCT_PACKAGES += \
    vendor_charger_res_images

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# SystemUI plugins
PRODUCT_PACKAGES += \
    QuickAccessWallet

# LatinIME
PRODUCT_PACKAGES += \
    LatinIME
