FROM ubuntu:trusty
MAINTAINER Kazumichi Yamamoto <yamamoto.febc@gmail.com>

RUN apt-get update 
RUN apt-get install -y \
      open-jtalk \
      open-jtalk-mecab-naist-jdic curl \
      lame \
      unzip \
      && rm -rf /usr/share/doc/* && \
      rm -rf /usr/share/info/* && \
      rm -rf /tmp/* && \
      rm -rf /var/tmp/*


RUN mkdir -p /jtalk/hts-voice
WORKDIR /jtalk

RUN curl -L http://sourceforge.net/projects/mmdagent/files/MMDAgent_Example/MMDAgent_Example-1.6/MMDAgent_Example-1.6.zip/download > MMDAgent_Example.zip && \
      unzip -x MMDAgent_Example.zip && \
      rm -f MMDAgent_Example.zip && \
      mv /jtalk/MMDAgent_Example-1.6/Voice/mei/*.htsvoice /jtalk/hts-voice/ && \
      rm -rf /jtalk/MMDAgent_Example-1.6

COPY docker-entrypoint.sh /jtalk/entrypoint.sh

ENV JTALK_VOICE_FILE="" \
    JTALK_VOICE_TYPE=normal \
    JTALK_OPTION="" \
    JTALK_OUTPUT=""

ENTRYPOINT ["/jtalk/entrypoint.sh"]
CMD ["-h"]
