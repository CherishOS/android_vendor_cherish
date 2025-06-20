# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017,2020 The LineageOS Project
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

# -----------------------------------------------------------------
# CHERISH OTA update package

CHERISH_TARGET_PACKAGE := $(PRODUCT_OUT)/CherishOS-v$(CHERISH_VERSION).zip

SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

CL_PRP="\033[35m"
CL_RED="\033[31m"
CL_GRN="\033[32m"
BLUE="\033[34m"
GREEN="\033[32m"
RED="\033[31m"
ENDCOLOR="\033[0m"

$(CHERISH_TARGET_PACKAGE): $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) mv -f $(INTERNAL_OTA_PACKAGE_TARGET) $(CHERISH_TARGET_PACKAGE)
	$(hide) $(SHA256) $(CHERISH_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(CHERISH_TARGET_PACKAGE).sha256sum
	echo -e ${CL_BLD}${CL_RED}"===============================-Package complete-==============================="${CL_RED};
	echo -e ${GREEN}"======================================================"${ENDCOLOR};
	echo -e ${BLUE}"     _____ _               _     _      ____   _____    "${ENDCOLOR};
	echo -e ${BLUE} "   / ____| |             (_)   | |    / __ \ / ____|   "${ENDCOLOR};
	echo -e ${BLUE} "  | |    | |__   ___ _ __ _ ___| |__ | |  | | (___     "${ENDCOLOR};
	echo -e ${GREEN}"   | |    | '_ \ / _ \ '__| / __| '_ \| |  | |\___ \    "${ENDCOLOR};
	echo -e ${BLUE} "  | |____| | | |  __/ |  | \__ \ | | | |__| |____) |   "${ENDCOLOR};
	echo -e ${RED} "   \_____|_| |_|\___|_|  |_|___/_| |_|\____/|_____/    "${ENDCOLOR};
	echo -e ${BLUE}"                                                       "${ENDCOLOR};
	echo -e ${RED} "                 #CherishTheLove                       "${ENDCOLOR};
	echo -e ${GREEN}"======================================================"${ENDCOLOR};
	echo -e ${CL_BLD}${CL_GRN}"Zip: "${CL_RED} $(CHERISH_TARGET_PACKAGE)${CL_RST}
	echo -e ${CL_BLD}${CL_GRN}"SHA256: "${CL_RED}" `cat $(CHERISH_TARGET_PACKAGE).sha256sum | awk '{print $$1}' `"${CL_RST}
	echo -e ${CL_BLD}${CL_GRN}"Size:"${CL_RED}" `du -sh $(CHERISH_TARGET_PACKAGE) | awk '{print $$1}' `"${CL_RST}
	$(hide) rm -rf $(call intermediates-dir-for,PACKAGING,target_files)

.PHONY: bacon
bacon: $(CHERISH_TARGET_PACKAGE) $(DEFAULT_GOAL)