FROM webhippie/python:2
MAINTAINER Junghwan Park <reserve.dev@gmail.com>

WORKDIR /srv/app
ENTRYPOINT ["/usr/bin/entrypoint"]
# CMD ["bash"]
CMD ["sphinx-build -b pdf /docs /docs/_build/pdf"]

RUN apk update && \
  apk add \
    texlive-full@testing \
    xz \
    git \
    zlib-dev \
    giflib-dev \
    jpeg-dev && \
  curl -sLo - \
    ftp://ftp.tug.org/historic/systems/texlive/2017/texlive-20170524-texmf.tar.xz | tar -Jxvf - --strip 1 -C /tmp && \
  cp -rf \
    /tmp/texmf-dist/* \
    /usr/share/texmf-dist/ && \
  rm -rf \
    /tmp/texmf-dist && \
  apk fix \
    texlive \
    texlive-full && \
  pip install \
    reportlab \
    git+https://github.com/rst2pdf/rst2pdf.git@14668d34523e21faf21ba6bca20e623aa3c33de6 \
    sphinxcontrib-phpdomain \
    sphinxcontrib-golangdomain \
    sphinxcontrib-disqus \
    sphinxcontrib-email \
    sphinxcontrib-fancybox \
    sphinxcontrib-gravatar \
    sphinxcontrib-httpdomain \
    sphinxcontrib-imagehelper \
    sphinxcontrib-images \
    sphinx==1.2.2 && \
  rm -rf /var/cache/apk/*

ADD rootfs /

ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.version=$VERSION
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.vcs-url="https://github.com/9bow/sphinx-cjk-pdf.git"
LABEL org.label-schema.name="Sphinx"
LABEL org.label-schema.vendor="Junghwan Park"
LABEL org.label-schema.schema-version="1.0"
