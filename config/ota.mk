ifeq ($(CHERISH_BUILD_TYPE), OFFICIAL)

CHERISH_OTA_VERSION_CODE := ten

CUSTOM_PROPERTIES += \
    com.cherish.ota.version_code=$(CHERISH_OTA_VERSION_CODE)

PRODUCT_PACKAGES += \
    Updates

PRODUCT_COPY_FILES += \
    vendor/cherish/config/permissions/com.cherish.ota.xml:system/etc/permissions/com.cherish.ota.xml

endif
