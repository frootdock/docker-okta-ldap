# docker-okta-ldap
Okta LDAP Agent in Docker

## Configuration questions for configure_agent.sh

1. Enter the base URL for your Okta organization (e.g. https://acme.okta.com): https://froot.okta.com
2. Enter your LDAP server hostname: ldap.froot.io
3. Enter your LDAP admin DN: cn=admin,dc=ldap,dc=froot,dc=io
4. Enter your LDAP admin password (it will not be displayed):
5. Enter your base DN: ou=Users,dc=ldap,dc=froot,dc=io
6. Use SSL (y/n)? [n]: n
7. Enter your LDAP server port: 50389
8. Enable proxy (y/n)? [n]: n

Then watch log to visit URL and once finished you should see message:
Service can now be started by typing:
  service OktaLDAPAgent start
as root.

