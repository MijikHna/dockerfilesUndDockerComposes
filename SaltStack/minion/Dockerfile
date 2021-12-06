
FROM debian:testing

RUN apt update && \
  apt upgrade -y && \
  apt install -y vim 

RUN apt -y install salt-master salt-minion salt-api python3 python3-pip

RUN python3 -m pip install CherryPy

COPY ./entrypoint.sh /scripts/entrypoint.sh

CMD [ "/scripts/entrypoint.sh" ]