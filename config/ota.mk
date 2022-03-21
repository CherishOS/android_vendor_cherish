ifeq ($(CHERISH_BUILD_TYPE), OFFICIAL)
CHERISH_OTA_VERSION_CODE := twelve

PRODUCT_PRODUCT_PROPERTIES += \
    ro.cherish.ota.version_code=$(CHERISH_OTA_VERSION_CODE)
    
PRODUCT_PACKAGES += \
    Updates
endif
