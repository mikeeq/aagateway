FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# https://developer.android.com/studio/index.html#command-tools

WORKDIR /opt/android

RUN apt-get update \
    && apt-get install -y \
      curl \
      unzip \
      openjdk-8-jdk

# jdk 8, 11, 13 ,16
#     && apt-get install -y android-sdk

ENV ANDROID_HOME=/opt/android
ENV PATH=$ANDROID_HOME/cmdline-tools/tools/bin/:$PATH
ENV PATH=$ANDROID_HOME/emulator/:$PATH
ENV PATH=$ANDROID_HOME/platform-tools/:$PATH

RUN curl -L $(curl -sL https://developer.android.com/studio/index.html\#command-tools | grep "zip" | grep "linux" | grep "commandline" | grep "href" | cut -d'"' -f2) -O \
    && unzip $(ls | grep zip) \
    && rm -rf $(ls | grep zip) \
    && mkdir tools \
    && mv cmdline-tools/* tools \
    && mv tools cmdline-tools/ \
    && yes | sdkmanager --licenses

# ENV GRADLE_OPTS=-Djava.io.tmpdir=/repo/
# export GRADLE_OPTS=-Djava.io.tmpdir=/repo/

# ./gradlew assemble
