FROM lsiobase/xenial
MAINTAINER andreas@froot.io

ARG OKTA_SUBDOMAIN=froot
ARG OKTA_LDAP_VERSION=05.02.05
ARG OKTA_LDAP_HOST=ldap.froot.io
ARG OKTA_LDAP_ADMIN_DN=cn=admin,dc=ldap,dc=froot,dc=io
ARG OKTA_LDAP_ADMIN_PASSWORD=admin
ARG OKTA_LDAP_BASE_DN=ou=Users,dc=ldap,dc=froot,dc=io
ARG OKTA_LDAP_USE_SSL=n
ARG OKTA_LDAP_PORT=50389
ARG OKTA_ENABLE_PROXY=n

ARG OKTA_CONFIG="https://${OKTA_SUBDOMAIN}.okta.com\n${OKTA_LDAP_HOST}\n${OKTA_LDAP_ADMIN_DN}\n${OKTA_LDAP_ADMIN_PASSWORD}\n${OKTA_LDAP_BASE_DN}\n${OKTA_LDAP_USE_SSL}\n${OKTA_LDAP_PORT}\n${OKTA_ENABLE_PROXY}\n\n"

# Install Okta LDAP Agent
RUN \
 apt-get update && \
 curl -o /tmp/okta-ldap.deb -L https://${OKTA_SUBDOMAIN}-admin.okta.com/static/ldap-agent/OktaLDAPAgent-${OKTA_LDAP_VERSION}_amd64.deb && \
 dpkg -i /tmp/okta-ldap.deb && \

# Cleanup
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

RUN echo ${OKTA_CONFIG}

RUN printf "${OKTA_CONFIG}" | /opt/Okta/OktaLDAPAgent/scripts/configure_agent.sh

CMD service OktaLDAPAgent restart && tail -F /opt/Okta/OktaLDAPAgent/logs/stdout.log /opt/Okta/OktaLDAPAgent/logs/agent.log /opt/Okta/OktaLDAPAgent/logs/stderr.log
