FROM ubuntu:trusty

ENV PROJECT_NAME optimor
ENV PACKAGE_NAME app
ENV PROJECT_PATH /app
ENV PACKAGE_PATH ${PROJECT_PATH}/${PACKAGE_NAME}

#########################
# System & Requirements #
#########################

RUN echo "deb http://ppa.launchpad.net/mozillateam/firefox-next/ubuntu trusty main" > /etc/apt/sources.list.d//mozillateam-firefox-next-trusty.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CE49EC21
RUN apt-get update
RUN apt-get install -y firefox xvfb python-pip
RUN pip install selenium


#######
# App #
#######

WORKDIR ${PROJECT_PATH}
COPY ./${PACKAGE_NAME} ./${PACKAGE_NAME}/

ADD xvfb.init /etc/init.d/xvfb
RUN chmod +x /etc/init.d/xvfb
RUN update-rc.d xvfb defaults
CMD (service xvfb start; export DISPLAY=:10; python /${PROJECT_PATH}/app.py)
