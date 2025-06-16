# Inherit common cherish stuff
$(call inherit-product, vendor/cherish/config/common_mobile.mk)

PRODUCT_SIZE := full

# Include cherishOS LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/cherish/overlay/dictionaries
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/cherish/overlay/dictionaries
