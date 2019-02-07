# Sphinx-CJK-PDF

## Description
* This is a docker image for building PDF based on [Sphinx](http://www.sphinx-doc.org/en/stable/) reST files in CJK(Chinese, Japanese, Korean) fonts.
* Since [rst2pdf](https://github.com/rst2pdf/rst2pdf) does not supports Python3, I created this docker image to avoid using virtualenv every time.
* In this image, only Korean fonts and settings are provided. (If you want to use other fonts, please read [the section](#Add-fonts) below.)
* This docker image is running on the [webhippie](https://hub.docker.com/u/webhippie)'s [Sphinx container](https://github.com/dockhippie/sphinx) based on a [Python container](https://registry.hub.docker.com/u/webhippie/python/).


## Prerequisite
* Could get/run docker image/container.
* Should have sphinx documents to build.


## Quick Start
* Setup Sphinx's configurations in `conf.py`.
  ```python
    # Add rst2pdf extension
    extensions = ['rst2pdf.pdfbuilder']
    # A comma-separated list of each document.
    # - index document name(index.rst)
    # - filename of the pdf
    # - document title, this will show on first page of pdf
    # - author name, this also show on first page
    pdf_documents = [('index', u'PDF-Filename', u'Document Title', u'Author'),]
    # A comma-separated list of custom styles
    pdf_stylesheets = ['sphinx', 'kerning', 'a4', 'ko']
    # Language to be used for hyphenation support
    pdf_language = "ko"
  ```
* Copy this repo's language config file(`samples/ko.json`) to Sphinx's root directory. (Sphinx's `conf.py` should be located same directory.)
* Get docker image && Run container using Sphinx document.
  ```sh
    docker pull 9bow/sphinx-cjk-pdf:latest
    docker run -it -v /somehwere/sphinx/root:/docs 9bow/sphinx-cjk-pdf
  ```
* Done. You can find pdf file on `_build/pdf/` under Sphinx's document root directory.


## Add fonts
* Add new fonts to `rootfs/usr/share/fonts`. Then, modify language config file (eg. `samples/ko.json`) to use those fonts.
* OR, use other fonts by attaching volume. Add `-v /somewhere/fonts/located:/usr/share/fonts`. (`/somewhere/fonts/located` should be replaced.)
  ```sh
    docker run -it -v /somehwere/sphinx/root:/docs -v /somewhere/fonts/located:/usr/share/fonts 9bow/sphinx-cjk-pdf
  ```


## Install Sphinx dependencies
* If you have any dependencies for Sphinx, just modify `Dockerfile` to build new image.
* OR, just adding `/bin/bash` for installing dependencies once on the container. (not applied on image)
  ```sh
    docker run -it -v /somehwere/sphinx/root:/docs 9bow/sphinx /bin/bash
  ```


## Base Docker images
* [webhippie/sphinx](https://github.com/dockhippie/sphinx)
* [webhippie/python](https://github.com/dockhippie/python)
* [webhippie/alpine](https://github.com/dockhippie/alpine)


## Contributing
* Fork -> Patch -> Push -> [Pull Request](https://github.com/9bow/sphinx-cjk-pdf/pulls)
* If you have any free fonts, feel free to add them in `rootfs/usr/share/fonts` and add language config.


## Authors
* [Junghwan Park](https://github.com/9bow)


## License
* MIT
* [OFL](https://scripts.sil.org/OFL) ([Naver Nanum fonts]((https://hangeul.naver.com/2017/nanum)))


## References
* [Language specific configuration on Sphinx](https://tk0miya.hatenablog.com/entry/20111208/p1)
* [Korean Nanum fonts by Naver corp.](https://hangeul.naver.com/2017/nanum)
