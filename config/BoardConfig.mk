include vendor/cherish/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/cherish/config/BoardConfigQcom.mk
endif

include vendor/cherish/config/BoardConfigSoong.mk
