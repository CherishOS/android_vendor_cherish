# cherishOS packages
PRODUCT_PACKAGES += \
    ThemePicker \
    AvatarPicker \
    FaceUnlock \
    ThemesStub \
    GameSpace \
    OmniStyle

ifneq ($(PRODUCT_NO_CAMERA),true)
PRODUCT_PACKAGES += \
    Aperture
endif

# Extra tools in cherish
PRODUCT_PACKAGES += \
    awk \
    bzip2 \
    curl \
    getcap \
    libsepol \
    setcap \

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    mke2fs \
    mkfs.exfat