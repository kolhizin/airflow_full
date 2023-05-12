FROM apache/airflow:2.6.0-python3.10

USER root

RUN apt-get update && apt-get install -y gcc git
RUN apt-get update && apt-get install -y --no-install-recommends alien libaio1 wget && \
    wget https://download.oracle.com/otn_software/linux/instantclient/185000/oracle-instantclient18.5-basiclite-18.5.0.0.0-3.x86_64.rpm && \
    wget https://download.oracle.com/otn_software/linux/instantclient/185000/oracle-instantclient18.5-devel-18.5.0.0.0-3.x86_64.rpm && \
    alien -i oracle-instantclient18.5-basiclite-18.5.0.0.0-3.x86_64.rpm && \
    alien -i oracle-instantclient18.5-devel-18.5.0.0.0-3.x86_64.rpm
ENV LD_LIBRARY_PATH="/usr/lib/oracle/18.5/client64/lib:${LD_LIBRARY_PATH}"

USER airflow

RUN pip install psycopg2-binary==2.9.6 pandas==1.5 cx_oracle==8.3.0 azure-storage-blob==12.16.0