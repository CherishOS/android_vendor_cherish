ifeq ($(CHERISH_BUILD_TYPE), OFFICIAL)

CHERISH_OTA_VERSION_CODE := eleven

PRODUCT_GENERIC_PROPERTIES += \
    ro.cherish.ota.version_code=$(CHERISH_OTA_VERSION_CODE) \
    sys.ota.disable_uncrypt=1

PRODUCT_PACKAGES += \
    Updates

endif
