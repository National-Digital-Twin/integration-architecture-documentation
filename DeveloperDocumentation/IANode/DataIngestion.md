# **Data Ingestion into the Integration Architecture Node (IA Node)**

The **IA Node** components related to data ingestion include:  
- [Secure Agent Graph](https://github.com/National-Digital-Twin/secure-agent-graph) – the primary component supporting **Apache Jena Fuseki SPARQL** queries.  
- [Jena Fuseki Kafka extension module](https://github.com/National-Digital-Twin/jena-fuseki-kafka) – enables data ingestion from **Kafka topics**.  

For details on deploying **Secure Agent Graph** locally, refer to the [Running an IA Node Locally](../Deployment/DeploymentLocal.md) document.  

---

## Data Ingestion Methods

### 1. Ingesting Data via SPARQL Queries

Secure Agent Graph runs its own **Apache Jena** server, allowing data ingestion via **SPARQL endpoints** accessible over **HTTP**.  

> **Note:**  
> Example SPARQL queries, including data ingestion, are provided in the [Running an IA Node Locally](../Deployment/DeploymentLocal.md) document:
> ```
> curl -X POST -T <path-to>/secure-agent-graph/sag-docker/Test/data1.trig \
>      --header "Content-type: text/trig" http://localhost:3030/ds/upload
>```
---

### 2. Ingesting Data via Kafka Topics

Data can also be ingested from **Kafka topics** using the [Jena Fuseki Kafka extension module](https://github.com/National-Digital-Twin/jena-fuseki-kafka).  

> **Note:**  
> The process for data ingestion via Kafka topics is described in the [Running an IA Node Locally](../Deployment/DeploymentLocal.md) document:
>```
> ./fk send --topic RDF <path-to>/secure-agent-graph/sag-docker/Test/data1.trig
>```
---

### 3. Ingesting Data via the Tuple Database (TDB) Command-Line Interface (CLI)

TDB is a native storage component of Apache Jena for RDF (Resource Description Framework) data, optimized for efficient disk-based indexing and querying.  

**TDB2** is recommended over **TDB1**, as it offers:  
- Better concurrency control
- Improved performance
- Enhanced scalability

Secure Agent Graph can be ran using in-memory or filesystem datasets. Here we assume that the dataset is filesystem based.

In many examples, e.g. https://github.com/National-Digital-Twin/secure-agent-graph/blob/pre/sag-docker/mnt/config/config-abac-local.ttl an in-memory option is used.

```
# fragment of old config-abac-local.ttl

# Transactional in-memory dataset (do not use, here it is commented out):
# :datasetBase rdf:type ja:MemoryDataset .
```

The above however needs to be replaced with filestystem setup:
```
# fragment of new config-abac-local.ttl

## Storage of data on filesystem (use this instead, the path is the container path)
:datasetBase rdf:type tdb2:DatasetTDB2 ;
    tdb2:location "/fuseki/databases/knowledge" ;
```

In order to use TDB CLI, Apache Jena binaries are needed. They can be downloaded from: https://downloads.apache.org/jena/binaries/, e.g.:
```
curl -O https://downloads.apache.org/jena/binaries/apache-jena-5.3.0.zip 
```

Using TDB CLI does not require running Secure Agent Graph as it operates directly on the database store. To load data into TDB, use the following command:

```
apache-jena-5.3.0/bin/tdbloader --loc=<path-to>/secure-agent-graph/scg-docker/mnt/databases/knowledge dataset.ttl
```  

The above is a valid exaple assuming that: 
* the Docker container was started in `<path-to>/secure-agent-graph` folder as:
    ```
    docker run -d --rm -p 3030:3030 --name secure-agent-graph \
    -v ./scg-docker/mnt/config/:/fuseki/config \
    -v ./scg-docker/mnt/databases/:/fuseki/databases \
    -e JWKS_URL=$JWKS_URL \
    -e USER_ATTRIBUTES_URL=http://localhost:8091 secure-agent-graph:latest \
    --config config/config-abac-local.ttl 
    ```
* the environment variable JWKS_URL is set set to point at local Cognito emulator or alternatively an AWS equivalent. For example using a local setup as in [Running an IA Node Locally](../Deployment/DeploymentLocal.md) document, this will be:
    ```
    export JWKS_URL=http://localhost:9229/local_6GLuhxhD/.well-known/jwks.json
    ```
* `config-abac-local.ttl` file is modified to use storage of data on filesystem as described above.
---

