FROM ubuntu:22.04
RUN apt-get update
RUN apt upgrade -y
RUN apt-get install -y git
RUN apt-get install -y vim
RUN apt-get install -y wget
RUN apt-get install -y curl
RUN apt-get install -y unzip
RUN apt-get install -y apt-transport-https
RUN apt-get install -y gnupg
RUN apt-get install -y gpg
RUN apt-get install -y zip
RUN apt-get install -y cmake


RUN apt-get install -y lsb-release
RUN apt-get install -y software-properties-common
# Install coverage dependencies: java and lcov
RUN apt-get -y install --no-install-recommends openjdk-11-jdk lcov
# install ffmpeg for webcam?
RUN apt-get install -y ffmpeg
# install flatbuffer
RUN apt-get install -y flatbuffers-compiler

RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone
RUN apt-get install -y tzdata
RUN apt-get install -y libopencv-dev python3-opencv

RUN curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg
RUN mv bazel-archive-keyring.gpg /usr/share/keyrings
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
RUN apt -y update 
RUN apt-get install -y bazel
#install ccache and configure it
RUN apt-get install -y ccache
RUN /usr/sbin/update-ccache-symlinks
RUN echo 'export PATH="/usr/lib/ccache:$PATH"' | tee -a ~/.bashrc
RUN ln -s /usr/lib/ccache ~/.ccache
# install python-dev
RUN apt-get install -y python3-pip python3 python3-setuptools python3-dev
# install llvm
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

#setting up android SDK
ENV ANDROID_HOME /opt/android-sdk
ENV ANDROID_NDK_HOME /opt/android-ndk/android-ndk-r21

ENV API_LEVELS android-33
ENV BUILD_TOOLS_VERSIONS build-tools-34.0.1
ENV ANDROID_EXTRAS extra-android-m2repository,extra-android-support,extra-google-google_play_services,extra-google-m2repository
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

RUN mkdir -p /opt/android-sdk-linux && cd /opt 
RUN wget -q http://dl.google.com/android/repository/platform-tools-latest-linux.zip -O android-sdk-tools.zip
RUN unzip -q android-sdk-tools.zip -d ${ANDROID_HOME}
RUN rm -f android-sdk-tools.zip
RUN ls ${ANDROID_HOME}
RUN mkdir -p /opt/android-ndk 
RUN wget -q https://dl.google.com/android/repository/android-ndk-r21-linux-x86_64.zip -O /opt/android-ndk-tools.zip
RUN unzip -q opt/android-ndk-tools.zip -d /opt/android-ndk
RUN rm -f opt/android-ndk-tools.zip
RUN apt-get clean
RUN apt-get autoremove
RUN apt-get autoclean

# COPY . /opt/build
WORKDIR /opt/build
WORKDIR /opt/

