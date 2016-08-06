FROM zhulinpinyu/java:oracle-jdk8

RUN apt-get update
RUN apt-get -y install rsyslog cron
RUN apt-get -y install curl

#创建脚本路径
RUN mkdir /code
WORKDIR /code

#复制要运行的代码到镜像中，包括cron配置文件
ADD code /code

#设置cron脚本
RUN crontab /code/crontabfile

#复制crontabfile到/etc/crontab
RUN cp /code/crontabfile /etc/crontab
RUN touch /var/log/cron.log

#将run.sh设置为可执行
RUN chmod +x /code/run.sh

WORKDIR /code

CMD ["bash","/code/run.sh"]