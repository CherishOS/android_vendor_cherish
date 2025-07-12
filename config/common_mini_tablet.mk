# Inherit mobile mini common Lineage stuff
$(call inherit-product, vendor/cherish/config/common_mobile_mini.mk)

# Inherit tablet common Lineage stuff
$(call inherit-product, vendor/cherish/config/tablet.mk)

$(call inherit-product, vendor/cherish/config/telephony.mk)
