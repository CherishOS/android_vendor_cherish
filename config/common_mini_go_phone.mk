# Set Lineage specific identifier for Android Go enabled products
PRODUCT_TYPE := go

# Inherit mini common Cherish stuff
$(call inherit-product, vendor/cherish/config/common_mini_phone.mk)
