# Inherit mobile full common cherish stuff
$(call inherit-product, vendor/cherish/config/common_mobile_full.mk)

# Inherit tablet common cherish stuff
$(call inherit-product, vendor/cherish/config/tablet.mk)

# GMS
ifeq ($(WITH_GMS),true)
ifeq ($(TARGET_USES_MINI_GAPPS),true)
$(call inherit-product, vendor/gms/gms_mini.mk)
else ifeq ($(TARGET_USES_PICO_GAPPS),true)
$(call inherit-product, vendor/gms/gms_pico.mk)
else
$(call inherit-product, vendor/gms/gms_full.mk)
endif
endif

$(call inherit-product, vendor/cherish/config/telephony.mk)
