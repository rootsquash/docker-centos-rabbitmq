FROM docker.io/centos
MAINTAINER root squash (nathan@rootsquash.com)

RUN rm -f /etc/localtime && \
    ln -s /usr/share/zoneinfo/US/Central /etc/localtime && \
    yum -y install wget && \
    wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm && \
    rpm -ivh epel-release-7-9.noarch.rpm && \
    yum clean all && \
    yum -y update && \
    groupadd rabbitmq -g 1000 && \
    useradd rabbitmq -u 1000 -g 1000 && \
    yum -y install rabbitmq-server && \
    yum -y remove wget && \
    rm -rf /var/cache/yum && \
    rabbitmq-plugins enable rabbitmq_management

RUN chown -R rabbitmq.rabbitmq /var/lib/rabbitmq /usr/lib/rabbitmq /var/log/rabbitmq

EXPOSE 5672 15672

USER rabbitmq

CMD ["/usr/lib/rabbitmq/bin/rabbitmq-server"]
