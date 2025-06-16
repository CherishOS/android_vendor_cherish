# Inherit mobile full common cherish stuff
$(call inherit-product, vendor/cherish/config/common_mobile_full.mk)

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true

$(call inherit-product, vendor/cherish/config/telephony.mk)
