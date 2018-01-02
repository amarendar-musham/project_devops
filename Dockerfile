
FROM ubuntu
RUN apt-get update -y && apt-get install -y  git ssh default-jre default-jdk vim sudo wget tar
RUN cd ~ && wget http://redrockdigimark.com/apachemirror/tomcat/tomcat-7/v7.0.82/bin/apache-tomcat-7.0.82.tar.gz
RUN tar xvzf apache-tomcat-7.0.82.tar.gz
COPY tomcat-users.xml ~/apache-tomcat-7.0.82/conf/tomcat-users.xml
RUN useradd amar
RUN (echo reds ; echo reds) | passwd amar
RUN sed -i "/^PermitRootLogin/c\PermitRootLogin yes" /etc/ssh/sshd_config 
RUN sed -i "s/#PasswordAuthentication yes/PasswordAuthentication yes/g" /etc/ssh/sshd_config
RUN echo "amar    ALL=(ALL:ALL) ALL" >> /etc/sudoers
EXPOSE 8080
EXPOSE 22
ENTRYPOINT ./apache-tomcat-7.0.82/bin/startup.sh && service ssh start && bash 

