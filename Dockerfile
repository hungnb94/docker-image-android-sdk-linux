FROM --platform=linux/amd64 ubuntu:22.04

ARG TARGETARCH
ARG JDK_VERSION=17
ARG PLATFORM_VERSION=android-33
ARG BUILD_TOOLS_VERSION=30.0.3

ENV ANDROID_HOME    /opt/android-sdk

ENV PATH "${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin"
ENV PATH "${PATH}:${ANDROID_HOME}/cmdline-tools/tools/bin"
ENV PATH "${PATH}:${ANDROID_HOME}/tools/bin"
ENV PATH "${PATH}:${ANDROID_HOME}/build-tools/${BUILD_TOOLS_VERSION}"
ENV PATH "${PATH}:${ANDROID_HOME}/platform-tools"
ENV PATH "${PATH}:${ANDROID_HOME}/emulator"
ENV PATH "${PATH}:${ANDROID_HOME}/bin"

RUN apt-get update \
 && apt-get install -y openjdk-${JDK_VERSION}-jdk wget unzip

COPY tools /opt/tools
RUN chmod +x /opt/tools/*.sh

RUN mkdir -p $ANDROID_HOME
RUN chmod -R 777 $ANDROID_HOME

# Install Android Commandline-Tools
RUN /opt/tools/cmdline_tools.sh

RUN yes | sdkmanager --licenses

# RUN sdkmanager "cmdline-tools;latest"
RUN sdkmanager "platforms;${PLATFORM_VERSION}"
RUN sdkmanager "platform-tools"

# Install Android Emulator
RUN sdkmanager "emulator"

RUN sdkmanager "build-tools;${BUILD_TOOLS_VERSION}"