# Inherit common Cherish stuff
$(call inherit-product, vendor/cherish/config/common_mobile.mk)

PRODUCT_SIZE := full

# Recorder
PRODUCT_PACKAGES += \
    Recorder
