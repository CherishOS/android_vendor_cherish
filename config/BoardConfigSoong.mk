PATH_OVERRIDE_SOONG := $(shell echo $(TOOLS_PATH_OVERRIDE))

# Add variables that we wish to make available to soong here.
EXPORT_TO_SOONG := \
    KERNEL_ARCH \
    KERNEL_BUILD_OUT_PREFIX \
    KERNEL_CROSS_COMPILE \
    KERNEL_MAKE_CMD \
    KERNEL_MAKE_FLAGS \
    KERNEL_PATH \
    PATH_OVERRIDE_SOONG \
    TARGET_KERNEL_CONFIG \
    TARGET_KERNEL_SOURCE \
    TARGET_KERNEL_PLATFORM_TARGET \
    TARGET_PREBUILT_KERNEL_HEADERS

# Setup SOONG_CONFIG_* vars to export the vars listed above.
# Documentation here:
# https://github.com/cherishOS/android_build_soong/commit/8328367c44085b948c003116c0ed74a047237a69

$(call add_soong_config_namespace,cherishVarsPlugin)
$(foreach v,$(EXPORT_TO_SOONG),$(eval $(call add_soong_config_var,cherishVarsPlugin,$(v))))

SOONG_CONFIG_NAMESPACES += cherishGlobalVars
SOONG_CONFIG_cherishGlobalVars += \
    camera_needs_client_info_lib \
    camera_needs_client_info_lib_oplus \
    disable_bluetooth_le_read_buffer_size_v2 \
    disable_bluetooth_le_set_host_feature \
    needs_netd_direct_connect_rule \
    target_alternative_futex_waiters \
    target_camera_package_name \
    target_ld_shim_libs \
    uses_legacy_fd_fbdev \
    uses_oplus_touch

SOONG_CONFIG_NAMESPACES += cherishNvidiaVars
SOONG_CONFIG_cherishNvidiaVars += \
    uses_nv_enhancements

# Soong bool variables
SOONG_CONFIG_cherishGlobalVars_needs_netd_direct_connect_rule := $(TARGET_NEEDS_NETD_DIRECT_CONNECT_RULE)
SOONG_CONFIG_cherishGlobalVars_target_alternative_futex_waiters := $(TARGET_ALTERNATIVE_FUTEX_WAITERS)
SOONG_CONFIG_cherishNvidiaVars_uses_nv_enhancements := $(NV_ANDROID_FRAMEWORK_ENHANCEMENTS)
SOONG_CONFIG_cherishGlobalVars_uses_legacy_fd_fbdev := $(TARGET_USES_LEGACY_FD_FBDEV)
SOONG_CONFIG_cherishGlobalVars_uses_oplus_touch := $(TARGET_USES_OPLUS_TOUCH)
SOONG_CONFIG_cherishGlobalVars_camera_needs_client_info_lib := $(TARGET_CAMERA_NEEDS_CLIENT_INFO_LIB)
SOONG_CONFIG_cherishGlobalVars_camera_needs_client_info_lib_oplus := $(TARGET_CAMERA_NEEDS_CLIENT_INFO_LIB_OPLUS)

# Soong value variables
SOONG_CONFIG_cherishGlobalVars_target_ld_shim_libs := $(subst $(space),:,$(TARGET_LD_SHIM_LIBS))
SOONG_CONFIG_cherishGlobalVars_disable_bluetooth_le_read_buffer_size_v2 := $(TARGET_DISABLE_BLUETOOTH_LE_READ_BUFFER_SIZE_V2)
SOONG_CONFIG_cherishGlobalVars_disable_bluetooth_le_set_host_feature := $(TARGET_DISABLE_BLUETOOTH_LE_SET_HOST_FEATURE)
SOONG_CONFIG_cherishGlobalVars_target_camera_package_name := $(TARGET_CAMERA_PACKAGE_NAME)

SOONG_CONFIG_NAMESPACES += cherishGlobalVars
SOONG_CONFIG_cherishGlobalVars += \
    spoof_first_api_level_32

# Soong bool variables
SOONG_CONFIG_cherishGlobalVars_spoof_first_api_level_32 := $(SPOOF_FIRST_API_LEVEL_32)

# Camera
ifneq ($(TARGET_CAMERA_OVERRIDE_FORMAT_FROM_RESERVED),)
    $(error TARGET_CAMERA_OVERRIDE_FORMAT_FROM_RESERVED is deprecated, please migrate to soong_config_set,camera,override_format_from_reserved)
endif
ifneq ($(TARGET_CAMERA_SERVICE_EXT_LIB),)
    $(call soong_config_set,libcameraservice,ext_lib,$(TARGET_CAMERA_SERVICE_EXT_LIB))
endif
ifneq ($(TARGET_USES_MIUI_CAMERA),)
    $(call soong_config_set,camera,uses_miui_camera,$(TARGET_USES_MIUI_CAMERA))
endif
ifneq ($(TARGET_CAMERA_PACKAGE_NAME),)
    $(call soong_config_set,camera,package_name,$(TARGET_CAMERA_PACKAGE_NAME))
endif

# Libui
ifneq ($(TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS),)
    $(call soong_config_set,libui,additional_gralloc_10_usage_bits,$(TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS))
endif

# Lineage Health HAL
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_PATH),)
    $(error TARGET_HEALTH_CHARGING_CONTROL_CHARGING_PATH is deprecated, please migrate to soong_config_set,lineage_health,charging_control_charging_path)
endif
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_DEADLINE_PATH),)
    $(error TARGET_HEALTH_CHARGING_CONTROL_DEADLINE_PATH is deprecated, please migrate to soong_config_set,lineage_health,charging_control_deadline_path)
endif
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED),)
    $(error TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED is deprecated, please migrate to soong_config_set,lineage_health,charging_control_charging_enabled)
endif
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED),)
    $(error TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED is deprecated, please migrate to soong_config_set,lineage_health,charging_control_charging_disabled)
endif
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS),)
    $(error TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS is deprecated, please migrate to soong_config_set,lineage_health,charging_control_supports_bypass)
endif
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE),)
    $(error TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE is deprecated, please migrate to soong_config_set,lineage_health,charging_control_supports_deadline)
endif
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_LIMIT),)
    $(error TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_LIMIT is deprecated, please migrate to soong_config_set,lineage_health,charging_control_supports_limit)
endif
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE),)
    $(error TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE is deprecated, please migrate to soong_config_set,lineage_health,charging_control_supports_toggle)
endif

# Surfaceflinger
ifneq ($(TARGET_SURFACEFLINGER_UDFPS_LIB),)
    $(error TARGET_SURFACEFLINGER_UDFPS_LIB is deprecated, please migrate to soong_config_set,surfaceflinger,udfps_lib)
endif

# Vendor init
ifneq ($(TARGET_INIT_VENDOR_LIB),)
    $(error TARGET_INIT_VENDOR_LIB is deprecated, please migrate to soong_config_set,libinit,vendor_init_lib)
endif
