# Copyright (C) 2021 cherishOS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ANDROID_VERSION := 16
CHERISH_VERSION := 6.3

CHERISH_BUILD_TYPE ?= UNOFFICIAL
CHERISH_DATE_YEAR := $(shell date -u +%Y)
CHERISH_DATE_MONTH := $(shell date -u +%m)
CHERISH_DATE_DAY := $(shell date -u +%d)
CHERISH_DATE_HOUR := $(shell date -u +%H)
CHERISH_DATE_MINUTE := $(shell date -u +%M)
CHERISH_BUILD_DATE := $(CHERISH_DATE_YEAR)$(CHERISH_DATE_MONTH)$(CHERISH_DATE_DAY)-$(CHERISH_DATE_HOUR)$(CHERISH_DATE_MINUTE)
TARGET_PRODUCT_SHORT := $(subst cherish_,,$(CHERISH_BUILD))

# OFFICIAL_DEVICES
ifeq ($(CHERISH_BUILD_TYPE), OFFICIAL)
  LIST = $(shell cat vendor/cherish/cherish.devices)
    ifeq ($(filter $(CHERISH_BUILD), $(LIST)), $(CHERISH_BUILD))
      IS_OFFICIAL=true
      CHERISH_BUILD_TYPE := OFFICIAL
    endif
    ifneq ($(IS_OFFICIAL), true)
      CHERISH_BUILD_TYPE := UNOFFICIAL
      $(error Device is not official "$(CHERISH_BUILD)")
    endif
endif

ifeq ($(WITH_GMS),true)
CHERISH_VERSION := $(CHERISH_VERSION)-$(CHERISH_BUILD)-$(CHERISH_BUILD_DATE)-$(CHERISH_BUILD_TYPE)-Gapps
else
CHERISH_VERSION := $(CHERISH_VERSION)-$(CHERISH_BUILD)-$(CHERISH_BUILD_DATE)-$(CHERISH_BUILD_TYPE)-Vanilla
endif

CHERISH_MOD_VERSION :=$(ANDROID_VERSION)-$(CHERISH_VERSION)
CHERISH_DISPLAY_VERSION := CherishOS-$(CHERISH_VERSION)
CHERISH_DISPLAY_BUILDTYPE := $(CHERISH_BUILD_TYPE)
CHERISH_FINGERPRINT := CherishOS/$(CHERISH_MOD_VERSION)/$(TARGET_PRODUCT_SHORT)/$(CHERISH_BUILD_DATE)
CHERISH_PLATFORM_RELEASE_OR_CODENAME := 15.0

# cherishOS System Version
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.cherish.version=$(CHERISH_DISPLAY_VERSION) \
  ro.cherish.build.status=$(CHERISH_BUILD_TYPE) \
  ro.modversion=$(CHERISH_MOD_VERSION) \
  ro.cherish.build.date=$(CHERISH_BUILD_DATE) \
  ro.cherish.buildtype=$(CHERISH_BUILD_TYPE) \
  ro.cherish.fingerprint=$(CHERISH_FINGERPRINT) \
  ro.cherish.device=$(CHERISH_BUILD) \
  ro.cherish.platform_release_or_codename=$(CHERISH_PLATFORM_RELEASE_OR_CODENAME) \
  org.cherish.version=$(CHERISH_VERSION)
