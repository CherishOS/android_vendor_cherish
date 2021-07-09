# Inherit mini common Cherish stuff
$(call inherit-product, vendor/cherish/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/cherish/config/telephony.mk)
