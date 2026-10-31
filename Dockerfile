# upgrade: github Wei-Shaw/sub2api
FROM weishaw/sub2api:0.2.19
RUN apk add --no-cache curl
COPY railway-start /railway-start
ENTRYPOINT ["/railway-start"]
CMD ["/app/sub2api"]
