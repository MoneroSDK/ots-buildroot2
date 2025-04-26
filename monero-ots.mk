################################################################################
#
# monero-ots
#
################################################################################

MONERO_OTS_VERSION = 0.1.0
MONERO_OTS_SOURCE = ots-$(MONERO_OTS_VERSION).tar.gz
MONERO_OTS_SITE = https://github.com/DiosDelRayo/monero/archive/refs/tags
MONERO_OTS_LICENSE = BipCot-1.3
MONERO_OTS_LICENSE_FILES = LICENSE
MONERO_OTS_DEPENDENCIES = boost openssl
MONERO_OTS_DEPENDENCIES += $(if $(BR2_PACKAGE_BOOST_FILESYSTEM),boost-filesystem)
MONERO_OTS_DEPENDENCIES += $(if $(BR2_PACKAGE_BOOST_THREAD),boost-thread)
MONERO_OTS_DEPENDENCIES += $(if $(BR2_PACKAGE_BOOST_SYSTEM),boost-system)
MONERO_OTS_DEPENDENCIES += $(if $(BR2_PACKAGE_BOOST_CHRONO),boost-chrono)
MONERO_OTS_DEPENDENCIES += $(if $(BR2_PACKAGE_BOOST_SERIALIZATION),boost-serialization)
MONERO_OTS_SUBDIR = ots

# We need to include the Monero source directory
MONERO_OTS_CONF_OPTS = -DMONERO_SOURCE_DIR=$(MONERO_OTS_SRCDIR)

# Options
MONERO_OTS_CONF_OPTS += -DBoost_FILESYSTEM_LIBRARY=$(STAGING_DIR)/usr/lib/libboost_filesystem.a
MONERO_OTS_CONF_OPTS += -DBoost_THREAD_LIBRARY=$(STAGING_DIR)/usr/lib/libboost_thread.a
MONERO_OTS_CONF_OPTS += -DBoost_SYSTEM_LIBRARY=$(STAGING_DIR)/usr/lib/libboost_system.a
MONERO_OTS_CONF_OPTS += -DBoost_CHRONO_LIBRARY=$(STAGING_DIR)/usr/lib/libboost_chrono.a
MONERO_OTS_CONF_OPTS += -DBoost_SERIALIZATION_LIBRARY=$(STAGING_DIR)/usr/lib/libboost_serialization.a
MONERO_OTS_CONF_OPTS += -DBoost_INCLUDE_DIR=$(STAGING_DIR)/usr/include

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
