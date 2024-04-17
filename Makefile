## dcape-app-template Makefile
## This file extends Makefile.app from dcape
#:

SHELL               = /bin/bash
CFG                ?= .env
CFG_BAK            ?= $(CFG).bak

#- App name
APP_NAME           ?= ifdb

#- Docker image name
IMAGE              ?= influxdb

#- Docker image tag
IMAGE_VER          ?= 1.8.10

#- InfluxDB database name
DB_NAME            ?= influx

#- Grafana host name
GF_APP_SITE        ?= gf.dev.test
#- Grafana container id
GF_APP_TAG         ?= gf-dev-test

#- Grafana docker image name
GF_IMAGE           ?= grafana/grafana

#- Grafana docker image tag
GF_IMAGE_VER       ?= 10.2.3

#- Grafana plugins
GF_INSTALL_PLUGINS ?=

#- app root
APP_ROOT           ?= $(PWD)

# If you need user name and password, uncomment this var
ADD_USER            = yes

# Keep persistent dir on deploy
APP_ROOT_OPTS       = keep

# ------------------------------------------------------------------------------

# if exists - load old values
-include $(CFG_BAK)
export

-include $(CFG)
export

# This content will be added to .env
# define CONFIG_CUSTOM
# # ------------------------------------------------------------------------------
# # Sample config for .env
# #SOME_VAR=value
#
# endef

# ------------------------------------------------------------------------------
# Find and include DCAPE_ROOT/Makefile
DCAPE_COMPOSE   ?= dcape-compose
DCAPE_ROOT      ?= $(shell docker inspect -f "{{.Config.Labels.dcape_root}}" $(DCAPE_COMPOSE))

ifeq ($(shell test -e $(DCAPE_ROOT)/Makefile.app && echo -n yes),yes)
  include $(DCAPE_ROOT)/Makefile.app
else
  include /opt/dcape/Makefile.app
endif

# ------------------------------------------------------------------------------

## Template support code, used once
use-template:

.default-deploy: prep

prep: grafana
	@echo "Just to show we able to attach"

db/grafana:
	@mkdir -p $@ && chmod 777 $@
