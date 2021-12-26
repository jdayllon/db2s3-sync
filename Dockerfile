FROM apache/nifi-minifi:1.15.2
COPY ./libs/* /opt/minifi/minifi-current/lib/
