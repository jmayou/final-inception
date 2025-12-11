FROM debian:12

RUN apt-get update

RUN apt-get install -y mariadb-server

RUN mkdir -p /run/mysqld

RUN chown -R mysql:mysql /run/mysqld

COPY ./tools/run.sh /usr/local/bin/run.sh

RUN chmod +x /usr/local/bin/run.sh

COPY ./conf/my.cnf /etc/mysql/my.cnf

RUN chown -R mysql:mysql /var/lib/mysql

CMD ["/usr/local/bin/run.sh"]
