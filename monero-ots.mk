################################################################################
#
# monero-ots
#
################################################################################

MONERO_OTS_VERSION = 0.5.0
MONERO_OTS_SOURCE = otslib-$(MONERO_OTS_VERSION).tar.gz
MONERO_OTS_SITE = https://github.com/MoneroSDK/monero-ots/releases/download/otslib-$(MONERO_OTS_VERSION)
MONERO_OTS_LICENSE = BipCot-1.3
MONERO_OTS_LICENSE_FILES = LICENSE
MONERO_OTS_DEPENDENCIES = boost openssl libsodium libunwind unbound zeromq
MONERO_OTS_SUBDIR = ots

# Options
MONERO_OTS_CONF_OPTS = -DBUILD_SHARED_LIBS=ON

# Use ccache if enabled
ifeq ($(BR2_CCACHE),y)
MONERO_OTS_CONF_OPTS += -DCCACHE_PROGRAM=$(CCACHE)
endif

# Debug build
ifeq ($(BR2_ENABLE_DEBUG),y)
MONERO_OTS_CONF_OPTS += -DDEBUG=ON
endif

$(eval $(cmake-package))
