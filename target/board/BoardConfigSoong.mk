# Setup SOONG_CONFIG_* vars to export the vars listed above.
# Documentation here:
# https://github.com/LineageOS/android_build_soong/commit/8328367c44085b948c003116c0ed74a047237a69

# PA Variables

SOONG_CONFIG_NAMESPACES += aospaVarsPlugin

SOONG_CONFIG_aospaVarsPlugin :=

define addVar
  SOONG_CONFIG_aospaVarsPlugin += $(1)
  SOONG_CONFIG_aospaVarsPlugin_$(1) := $$(subst ",\",$$($1))
endef

$(foreach v,$(EXPORT_TO_SOONG),$(eval $(call addVar,$(v))))

SOONG_CONFIG_NAMESPACES += aospaGlobalVars
SOONG_CONFIG_aospaGlobalVars += \
    needs_camera_boottime \
    powershare_node \
    target_camera_package_name \
    target_health_charging_control_charging_path \
    target_health_charging_control_charging_enabled \
    target_health_charging_control_charging_disabled \
    target_health_charging_control_deadline_path \
    target_health_charging_control_supports_bypass \
    target_health_charging_control_supports_deadline \
    target_health_charging_control_supports_toggle \
    target_init_vendor_lib \
    target_ld_shim_libs \
    target_process_sdk_version_override \
    target_surfaceflinger_udfps_lib

SOONG_CONFIG_NAMESPACES += aospaQcomVars
SOONG_CONFIG_aospaQcomVars += \
    supports_extended_compress_format

# Set default values
TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED ?= 1
TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED ?= 0
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS ?= true
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE ?= false
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE ?= true
TARGET_INIT_VENDOR_LIB ?= vendor_init
TARGET_SURFACEFLINGER_UDFPS_LIB ?= surfaceflinger_udfps_lib

# Soong value variables
SOONG_CONFIG_aospaGlobalVars_needs_camera_boottime := $(TARGET_CAMERA_BOOTTIME_TIMESTAMP)
SOONG_CONFIG_aospaGlobalVars_powershare_node := $(TARGET_POWERSHARE_NODE)
SOONG_CONFIG_aospaGlobalVars_target_camera_package_name := $(TARGET_CAMERA_PACKAGE_NAME)
SOONG_CONFIG_aospaGlobalVars_target_init_vendor_lib := $(TARGET_INIT_VENDOR_LIB)
SOONG_CONFIG_aospaGlobalVars_target_ld_shim_libs := $(subst $(space),:,$(TARGET_LD_SHIM_LIBS))
SOONG_CONFIG_aospaGlobalVars_target_process_sdk_version_override := $(TARGET_PROCESS_SDK_VERSION_OVERRIDE)
SOONG_CONFIG_aospaGlobalVars_target_surfaceflinger_udfps_lib := $(TARGET_SURFACEFLINGER_UDFPS_LIB)
SOONG_CONFIG_aospaGlobalVars_target_health_charging_control_charging_path := $(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_PATH)
SOONG_CONFIG_aospaGlobalVars_target_health_charging_control_charging_enabled := $(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED)
SOONG_CONFIG_aospaGlobalVars_target_health_charging_control_charging_disabled := $(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED)
SOONG_CONFIG_aospaGlobalVars_target_health_charging_control_deadline_path := $(TARGET_HEALTH_CHARGING_CONTROL_DEADLINE_PATH)
SOONG_CONFIG_aospaGlobalVars_target_health_charging_control_supports_bypass := $(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS)
SOONG_CONFIG_aospaGlobalVars_target_health_charging_control_supports_deadline := $(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE)
SOONG_CONFIG_aospaGlobalVars_target_health_charging_control_supports_toggle := $(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE)
SOONG_CONFIG_aospaQcomVars_supports_extended_compress_format := $(AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT)

# Gestures
define add-gesturevar-if-exist
$(eval vn := $(shell echo $(1) | tr '[:upper:]' '[:lower:]'))
$(if $($(1)), \
  $(eval SOONG_CONFIG_aospaGestureVars += $(vn)) \
  $(eval SOONG_CONFIG_aospaGestureVars_$(vn) := $(patsubst "%",%,$($(1)))) \
)
endef

SOONG_CONFIG_NAMESPACES += aospaGestureVars
SOONG_CONFIG_aospaGestureVars :=
GESTURE_SOONG_VARS := \
    TARGET_GESTURES_NODE \
    TARGET_TAP_TO_WAKE_NODE \
    TARGET_TAP_TO_WAKE_EVENT_NODE \
    TARGET_DRAW_V_NODE \
    TARGET_DRAW_INVERSE_V_NODE \
    TARGET_DRAW_O_NODE \
    TARGET_DRAW_M_NODE \
    TARGET_DRAW_W_NODE \
    TARGET_DRAW_ARROW_LEFT_NODE \
    TARGET_DRAW_ARROW_RIGHT_NODE \
    TARGET_ONE_FINGER_SWIPE_UP_NODE \
    TARGET_ONE_FINGER_SWIPE_RIGHT_NODE \
    TARGET_ONE_FINGER_SWIPE_DOWN_NODE \
    TARGET_ONE_FINGER_SWIPE_LEFT_NODE \
    TARGET_TWO_FINGER_SWIPE_NODE \
    TARGET_DRAW_S_NODE \
    TARGET_SINGLE_TAP_TO_WAKE_NODE \
    TARGET_POWER_FEATURE_EXT_LIB

$(foreach v,$(GESTURE_SOONG_VARS),$(eval $(call add-gesturevar-if-exist,$(v))))

# Qualcomm variables
SOONG_CONFIG_NAMESPACES += aosp_vs_qva
SOONG_CONFIG_aosp_vs_qva += aosp_or_qva
SOONG_CONFIG_aosp_vs_qva_aosp_or_qva := qva
