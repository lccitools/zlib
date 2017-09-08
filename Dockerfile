# The MIT License
#
#  Copyright (c) 2017, Oleg Nenashev, Stefan Wallentowitz
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.

FROM lccitools/base:latest
LABEL Maintainer  Oleg Nenashev <o.v.nenashev@gmail.com>
LABEL Description "ZLib Builder"

ARG VERSION=1.2.11

RUN apt-get update && apt-get install -y \
    python3 pkg-config libreadline-dev libffi-dev wget

ENV ZLIB_BASE=/tools/generic/zlib
ENV ZLIB_MODULEFILES=/tools/modulefiles/generic/zlib
ENV ZLIB_VERSION=${VERSION}

WORKDIR /zlib
RUN wget -v http://zlib.net/zlib-${ZLIB_VERSION}.tar.gz
RUN tar zxf zlib-${ZLIB_VERSION}.tar.gz 
RUN mv zlib-${ZLIB_VERSION}/* .
RUN ls -la
RUN ./configure && make
RUN mkdir /zlib_dist && DESTDIR=/zlib_dist make install


COPY build.sh /zlib

ENTRYPOINT ["./build.sh"]
