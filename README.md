# db2s3-sync

This repo contains a PoC to sync a DBMS (MariaDB) with a S3 bucket (Minio) using a MiNiFi Dataflow. 

## Elements

* Dockerfile. Contains a modified version of MiNiFi official image adding several dependencies (libs folder) needed to run de PoC.
* docker-compose.yaml . PoC Enviorement with all elements needed to standalone PoC.
* Allserver.xml . Nifi Flow previous to MiNiFi conversion
* dbsync.yaml . MiNiFi Flow converted from Nifi Flow (Allserver.xml) with adaptations to run in docker-compose.yaml env.
* database-create.sql . Init a MariaDB database with a simple schema an 3 triggers to record activity like Create, Update and Delete operations over items table.
* swagger. Folder with Swagger-UI with a Rest definition.
