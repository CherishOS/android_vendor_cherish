$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# Inherit mini common Cherish stuff
$(call inherit-product, vendor/cherish/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME
