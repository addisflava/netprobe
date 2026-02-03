FROM python:3.11-slim-bookworm

# copy requirements and entrypoint into final image
COPY requirements.txt /netprobe_lite/requirements.txt
COPY entrypoint.sh /netprobe_lite/entrypoint.sh

ENV PYTHONUNBUFFERED=1
ENV PIP_DISABLE_PIP_VERSION_CHECK=on

RUN apt-get update \
    && apt-get install -y iputils-ping traceroute \
    && apt-get clean \
    && pip install -r /netprobe_lite/requirements.txt --break-system-packages \
    && chmod +x /netprobe_lite/entrypoint.sh

WORKDIR /netprobe_lite

# Use absolute path for clarity
ENTRYPOINT ["/bin/bash", "/netprobe_lite/entrypoint.sh"]