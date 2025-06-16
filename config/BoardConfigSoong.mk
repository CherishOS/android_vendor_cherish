PATH_OVERRIDE_SOONG := $(shell echo $(TOOLS_PATH_OVERRIDE))

# Add variables that we wish to make available to soong here.
EXPORT_TO_SOONG := \
    KERNEL_ARCH \
    KERNEL_BUILD_OUT_PREFIX \
    KERNEL_CROSS_COMPILE \
    KERNEL_MAKE_CMD \
    KERNEL_MAKE_FLAGS \
    PATH_OVERRIDE_SOONG \
    TARGET_KERNEL_CONFIG \
    TARGET_KERNEL_SOURCE

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

# Camera
ifneq ($(TARGET_CAMERA_OVERRIDE_FORMAT_FROM_RESERVED),)
    $(warning TARGET_CAMERA_OVERRIDE_FORMAT_FROM_RESERVED is deprecated, please migrate to soong_config_set,camera,override_format_from_reserved)
    $(call soong_config_set,camera,override_format_from_reserved,$(TARGET_CAMERA_OVERRIDE_FORMAT_FROM_RESERVED))
endif

# Libui
ifneq ($(TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS),)
    $(call soong_config_set,libui,additional_gralloc_10_usage_bits,$(TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS))
endif

# Lineage Health HAL
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_PATH),)
    $(warning TARGET_HEALTH_CHARGING_CONTROL_CHARGING_PATH is deprecated, please migrate to soong_config_set,lineage_health,charging_control_charging_path)
    $(call soong_config_set,lineage_health,charging_control_charging_path,$(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_PATH))
endif
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_DEADLINE_PATH),)
    $(warning TARGET_HEALTH_CHARGING_CONTROL_DEADLINE_PATH is deprecated, please migrate to soong_config_set,lineage_health,charging_control_deadline_path)
    $(call soong_config_set,lineage_health,charging_control_deadline_path,$(TARGET_HEALTH_CHARGING_CONTROL_DEADLINE_PATH))
endif
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED),)
    $(warning TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED is deprecated, please migrate to soong_config_set,lineage_health,charging_control_charging_enabled)
    $(call soong_config_set,lineage_health,charging_control_charging_enabled,$(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED))
endif
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED),)
    $(warning TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED is deprecated, please migrate to soong_config_set,lineage_health,charging_control_charging_disabled)
    $(call soong_config_set,lineage_health,charging_control_charging_disabled,$(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED))
endif
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS),)
    $(warning TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS is deprecated, please migrate to soong_config_set,lineage_health,charging_control_supports_bypass)
    $(call soong_config_set,lineage_health,charging_control_supports_bypass,$(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS))
endif
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE),)
    $(warning TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE is deprecated, please migrate to soong_config_set,lineage_health,charging_control_supports_deadline)
    $(call soong_config_set,lineage_health,charging_control_supports_deadline,$(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE))
endif
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_LIMIT),)
    $(warning TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_LIMIT is deprecated, please migrate to soong_config_set,lineage_health,charging_control_supports_limit)
    $(call soong_config_set,lineage_health,charging_control_supports_limit,$(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_LIMIT))
endif
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE),)
    $(warning TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE is deprecated, please migrate to soong_config_set,lineage_health,charging_control_supports_toggle)
    $(call soong_config_set,lineage_health,charging_control_supports_toggle,$(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE))
endif

# Surfaceflinger
ifneq ($(TARGET_SURFACEFLINGER_UDFPS_LIB),)
    $(warning TARGET_SURFACEFLINGER_UDFPS_LIB is deprecated, please migrate to soong_config_set,surfaceflinger,udfps_lib)
    $(call soong_config_set,surfaceflinger,udfps_lib,$(TARGET_SURFACEFLINGER_UDFPS_LIB))
endif

# Vendor init
ifneq ($(TARGET_INIT_VENDOR_LIB),)
    $(warning TARGET_INIT_VENDOR_LIB is deprecated, please migrate to soong_config_set,libinit,vendor_init_lib)
    $(call soong_config_set,libinit,vendor_init_lib,$(TARGET_INIT_VENDOR_LIB))
endif
