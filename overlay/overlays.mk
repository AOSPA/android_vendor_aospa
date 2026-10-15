#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

# Overlays
PRODUCT_PACKAGES += \
    AOSPABlackThemeOverlay \
    AOSPAFrameworksOverlay \
    AOSPAImmersiveNavigationOverlay \
    AOSPANetworkStackOverlay \
    AOSPANetworkStackMainlineOverlay \
    AOSPASettingsOverlay \
    AOSPASettingsProviderOverlay \
    AOSPASystemUIOverlay \
    FontGoogleSansOverlay \
    FontHarmonySansOverlay \
    FontInterOverlay \
    FontLinotteSourceOverlay \
    FontManropeOverlay \
    FontOnePlusSansOverlay  \
    FontOppoSansOverlay \
    FontUrbanistOverlay \
    ParanoidLauncherOverlay \
    PixelThemesStub

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/aospa/overlay/static
PRODUCT_PACKAGE_OVERLAYS += vendor/aospa/overlay/static
