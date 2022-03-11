$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# Inherit common CherishOS stuff
$(call inherit-product, vendor/cherish/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME