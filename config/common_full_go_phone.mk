# Set Lineage specific identifier for Android Go enabled products
PRODUCT_TYPE := go

# Inherit full common Cherish stuff
$(call inherit-product, vendor/cherish/config/common_full_phone.mk)
