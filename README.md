# Brazilian E-commerce

Data warehousing project, based on Olist's Brazilian E-commerce [dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).

Execution steps:

1. Inserting data from the dataset into the [OLTP](https://www.ibm.com/topics/oltp) database ([MariaDB](https://mariadb.org/) used for storing purposes).
2. [OLAP](https://www.ibm.com/topics/olap) solution - [Data Mart](https://www.ibm.com/topics/data-mart) design and creation ([OracleDB](https://www.oracle.com/database/) used for storing purposes).
3. [ETL](https://www.ibm.com/topics/etl) (OLTP->OLAP) using [Apache Nifi](https://nifi.apache.org/).
4. Report/s creation using [Power BI](https://app.powerbi.com/home).
