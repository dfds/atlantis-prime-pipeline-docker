FROM dfdsdk/prime-pipeline:0.5.4

# ========================================
# Atlantis
# ========================================

ENV ATLANTIS_VERSION=0.16.0

RUN curl -L https://github.com/runatlantis/atlantis/releases/download/v${ATLANTIS_VERSION}/atlantis_linux_amd64.zip -o atlantis.zip \
    && unzip atlantis.zip \
    && rm atlantis.zip \
    && mv atlantis /usr/local/bin/

# ========================================
# END
# ========================================

CMD [ "bash" ]
