################################################################################
#
# monero-ots
#
################################################################################

MONERO_OTS_VERSION = 0.1.0
MONERO_OTS_SITE = $(call github,DiosDelRayo,monero,otslib)
MONERO_OTS_LICENSE = BipCot-1.3
MONERO_OTS_LICENSE_FILES = LICENSE
MONERO_OTS_DEPENDENCIES = boost openssl
MONERO_OTS_SUBDIR = ots

# We need to include the Monero source directory
MONERO_OTS_CONF_OPTS = -DMONERO_SOURCE_DIR=$(MONERO_OTS_SRCDIR)

# Options
MONERO_OTS_CONF_OPTS += -DBUILD_SHARED_LIBS=OFF
MONERO_OTS_CONF_OPTS += -DBUILD_TESTS=OFF
MONERO_OTS_CONF_OPTS += -DBUILD_DOCS=OFF
MONERO_OTS_CONF_OPTS += -DBUILD_V1SIGN=OFF
MONERO_OTS_CONF_OPTS += -DBUILD_BLOCKTIME=OFF
MONERO_OTS_CONF_OPTS += -DBUILD_BIN_HEADER_MACRO=OFF

# Use ccache if enabled
ifeq ($(BR2_CCACHE),y)
MONERO_OTS_CONF_OPTS += -DCCACHE_PROGRAM=$(CCACHE)
endif

# Debug build
ifeq ($(BR2_ENABLE_DEBUG),y)
MONERO_OTS_CONF_OPTS += -DDEBUG=ON
else
MONERO_OTS_CONF_OPTS += -DDEBUG=OFF
endif

$(eval $(cmake-package))
