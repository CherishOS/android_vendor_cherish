ifeq ($(CHERISH_BUILD_TYPE), OFFICIAL)

PRODUCT_PACKAGES += \
    Updates

PRODUCT_COPY_FILES += \
    vendor/cherish/config/permissions/com.cherish.ota.xml:system/etc/permissions/com.cherish.ota.xml

endif
