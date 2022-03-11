$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

$(call inherit-product, vendor/cherish/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/cherish/config/telephony.mk)
