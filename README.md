## Dockerfile for Cryptpad (cryptpad.fr)

This will pull code from the cryptpad source repo and install/configure
it on an alpine image. The configuration has all phone home and subscription/
donation turned off, but keeps user quotas at 50MB so folks still get the
same freemium option as cryptpad.fr.

The config file has been modified to look at two environment variables:

BASE_URL: This is the full url with scheme and trailing slash, e.g. https://example.com/
ADMIN_KEYS: This should be set to a json array of the user keys that you would
            like to have access to the administration area.

Example of admin keys environment variable:
```json
[
  "https://example.com/user/#/1/admin/adfdkahaklhgakljhdfgadfgljfgh="
]
```

Automated builds by docker are available at https://hub.docker.com/repository/docker/elerch/cryptpad


