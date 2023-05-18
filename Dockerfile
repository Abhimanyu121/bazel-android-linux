FROM alpine:3.17.3

RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ bazel6
RUN apk add llvm g++ unzip zip curl git

# setting up android SDK
ENV ANDROID_HOME /opt/android-sdk
ENV API_LEVELS android-33
ENV BUILD_TOOLS_VERSIONS build-tools-34.0.1
ENV ANDROID_EXTRAS extra-android-m2repository,extra-android-support,extra-google-google_play_services,extra-google-m2repository
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

RUN apk update && apk add --no-cache bash unzip libstdc++

RUN mkdir -p /opt/android-sdk-linux && cd /opt 
RUN wget -q http://dl.google.com/android/repository/platform-tools-latest-linux.zip -O android-sdk-tools.zip
RUN unzip -q android-sdk-tools.zip -d ${ANDROID_HOME}
RUN rm -f android-sdk-tools.zip
RUN ls ${ANDROID_HOME}

COPY . /opt/build
WORKDIR /opt/buld

