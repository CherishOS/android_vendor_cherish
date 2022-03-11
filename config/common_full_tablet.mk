$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# Inherit full common Cherish stuff
$(call inherit-product, vendor/cherish/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Lineage LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/cherish/overlay/dictionaries

$(call inherit-product, vendor/cherish/config/telephony.mk)
