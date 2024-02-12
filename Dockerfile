FROM alpine
RUN apk add --no-cache bind-tools bash
COPY update-domains.sh /update-domains.sh
ENTRYPOINT [ "/update-domains.sh" ]
