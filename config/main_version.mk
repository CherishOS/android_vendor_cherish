# Versioning System
CHERISH_BUILD_VARIANT ?= Gapps
CHERISH_BUILD_TYPE ?= UNOFFICIAL
CHERISH_CODENAME := Beta

# CherishOS Release
ifeq ($(CHERISH_BUILD_TYPE), OFFICIAL)

  OFFICIAL_DEVICES = $(shell cat vendor/cherish/cherish.devices)
  FOUND_DEVICE =  $(filter $(CHERISH_BUILD), $(OFFICIAL_DEVICES))
    ifeq ($(FOUND_DEVICE),$(CHERISH_BUILD))
      CHERISH_BUILD_TYPE := OFFICIAL
    else
      CHERISH_BUILD_TYPE := UNOFFICIAL
      $(error Device is not official "$(CHERISH_BUILD)")
    endif
endif

# System version
TARGET_PRODUCT_SHORT := $(subst cherish_,,$(CHERISH_BUILD_TYPE))

CHERISH_DATE_YEAR := $(shell date -u +%Y)
CHERISH_DATE_MONTH := $(shell date -u +%m)
CHERISH_DATE_DAY := $(shell date -u +%d)
CHERISH_DATE_HOUR := $(shell date -u +%H)
CHERISH_DATE_MINUTE := $(shell date -u +%M)
CHERISH_BUILD_DATE_UTC := $(shell date -d '$(CHERISH_DATE_YEAR)-$(CHERISH_DATE_MONTH)-$(CHERISH_DATE_DAY) $(CHERISH_DATE_HOUR):$(CHERISH_DATE_MINUTE) UTC' +%s)
CHERISH_BUILD_DATE := $(CHERISH_DATE_YEAR)$(CHERISH_DATE_MONTH)$(CHERISH_DATE_DAY)-$(CHERISH_DATE_HOUR)$(CHERISH_DATE_MINUTE)

CHERISH_PLATFORM_VERSION := 13.0
CHERISHVERSION := 4.0.5

ifeq ($(CHERISH_VANILLA), true)
CHERISH_VERSION := Cherish-OS-v$(CHERISHVERSION)-$(CHERISH_BUILD_DATE)-$(CHERISH_BUILD)-$(CHERISH_BUILD_TYPE)-Vanilla
else
CHERISH_VERSION := Cherish-OS-v$(CHERISHVERSION)-$(CHERISH_BUILD_DATE)-$(CHERISH_BUILD)-$(CHERISH_BUILD_TYPE)-GApps
endif
CHERISH_VERSION_PROP := $(PLATFORM_VERSION)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.cherish.version=$(CHERISHVERSION) \
    ro.cherish.version.display=$(CHERISH_VERSION) \
    ro.cherish.build_date=$(CHERISH_BUILD_DATE) \
    ro.cherish.codename=$(CHERISH_CODENAME) \
    ro.cherish.version.prop=$(CHERISH_VERSION_PROP) \
    ro.cherish.build_date_utc=$(CHERISH_BUILD_DATE_UTC) \
    ro.cherish.build_type=$(CHERISH_BUILD_TYPE)
