# Inherit mobile full common Lineage stuff
$(call inherit-product, vendor/cherish/config/common_mobile_full.mk)

# Inherit tablet common Lineage stuff
$(call inherit-product, vendor/cherish/config/tablet.mk)

$(call inherit-product, vendor/cherish/config/wifionly.mk)

# GMS
WITH_GMS ?= true
ifeq ($(WITH_GMS),true)
$(call inherit-product, vendor/gms/gms_full_tablet_wifionly.mk)
endif
