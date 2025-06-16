# Inherit mobile full common cherish stuff
$(call inherit-product, vendor/cherish/config/common_mobile_full.mk)

# Inherit tablet common cherish stuff
$(call inherit-product, vendor/cherish/config/tablet.mk)

$(call inherit-product, vendor/cherish/config/wifionly.mk)
