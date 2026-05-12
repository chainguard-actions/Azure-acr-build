FROM mcr.microsoft.com/azure-cli@sha256:925b5871029fe16b82650c8298201e5dd91ac8122c7af1d150b57edc8c9f316a as runtime # latest
LABEL "repository"="https://github.com/Azure/acr-build"
LABEL "maintainer"="Alessandro Vozza"

ADD entrypoint.sh /entrypoint.sh
RUN ["chmod", "+x", "/entrypoint.sh"]
ENTRYPOINT ["/entrypoint.sh"]

FROM runtime