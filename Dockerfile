FROM dfdsdk/prime-pipeline:1.0.0

# ========================================
# Atlantis
# ========================================



# Dependencies for entrypoint script from atlantis base
RUN apt-get update \
    && apt-get install -y dumb-init gosu \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/dumb-init /bin/dumb-init

# Finally actually atlantis
ENV ATLANTIS_VERSION=0.27.2

RUN curl -L https://github.com/runatlantis/atlantis/releases/download/v${ATLANTIS_VERSION}/atlantis_linux_amd64.zip -o atlantis.zip \
    && unzip atlantis.zip \
    && rm atlantis.zip \
    && mv atlantis /usr/local/bin/

# Fetch the entrypoint script from source
RUN curl -L https://github.com/runatlantis/atlantis/archive/v${ATLANTIS_VERSION}.zip -o atlantis-${ATLANTIS_VERSION}.zip \
    && unzip atlantis-${ATLANTIS_VERSION}.zip \
    && rm atlantis-${ATLANTIS_VERSION}.zip \
    && mv atlantis-${ATLANTIS_VERSION}/docker-entrypoint.sh /usr/local/bin/ \
    && rm -rf atlantis-${ATLANTIS_VERSION}



# Create home dir and assign permissions
RUN useradd -u 200 --create-home --user-group --shell /bin/bash atlantis && \
    chown atlantis:root /home/atlantis/ && \
    chmod u+rwx /home/atlantis/

# ========================================
# END
# ========================================
USER atlantis
ENTRYPOINT [ "bash", "docker-entrypoint.sh" ]
