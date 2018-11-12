ARG CODE_VERSION=latest
FROM centos:${CODE_VERSION}

LABEL version="ansible-2.4"

ENV JENKINS_SWARM_VERSION 3.14
ENV HOME /home/jenkins-slave

#
# Ansible and misc tools setup
#

RUN yum install -y \
    ansible \
    epel-release \
    git \
    wget;

RUN yum install -y java-1.8.0-openjdk-headless

RUN useradd -c "Jenkins Slave user" -d $HOME -m jenkins-slave

RUN curl --create-dirs -sSLo /usr/share/jenkins/swarm-client-$JENKINS_SWARM_VERSION.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/$JENKINS_SWARM_VERSION/swarm-client-$JENKINS_SWARM_VERSION.jar \
  && chmod 755 /usr/share/jenkins

EXPOSE 22

COPY jenkins-slave.sh /usr/local/bin/jenkins-slave.sh

USER jenkins-slave

VOLUME /home/jenkins-slave

ENTRYPOINT ["/usr/local/bin/jenkins-slave.sh"]

CMD ["ansible","--version"]

