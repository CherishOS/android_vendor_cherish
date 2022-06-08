ifneq ($(filter OFFICIAL CI,$(CHERISH_BUILD_TYPE)),)
PRODUCT_PACKAGES += \
    Updater
endif