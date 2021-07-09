# Inherit full common Cherish stuff
$(call inherit-product, vendor/cherish/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME
