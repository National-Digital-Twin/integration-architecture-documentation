# Code Repositories of IA Node

IA Node consists of the following main repositories:

* [secure-agent-graph](https://github.com/National-Digital-Twin/secure-agent-graph)
  - Provides mechanism to receive and hold RDF data, provides SPARQL access and integration points such as with ABAC components for security and control over data access. It makes use of Apache Jena and includes support for integration with Kafka.

* [ianode-access](https://github.com/National-Digital-Twin/ianode-access)
  - API and services to map identity to user attributes for ABAC purposes.

* [rdf-abac](https://github.com/National-Digital-Twin/rdf-abac)
  - Provides mechanism for fine-grained access control to data as a plug-in for use by secure-agent-graph. ABAC = "Attribute Based Access Control" authorisation.

* [jena-fuseki-kafka](https://github.com/National-Digital-Twin/jena-fuseki-kafka)
  - Provides integration with Kafka streams so that RDF data can receive and manipulated via messages on the streams.

* [graphql-jena](https://github.com/National-Digital-Twin/graphql-jena)
  - Provides GraphQL query capabilities as extensions to Apache Jena.

* [jwt-servlet-auth](https://github.com/National-Digital-Twin/jwt-servlet-auth)
  - This repository provides libraries that allow adding JSON Web Token (JWT) based Bearer authentication into Java Servlet applications.

* [secure-agents-lib](http://github.com/National-Digital-Twin/secure-agents-lib)
  - This provides libraries for building Secure Agent implementations in Java. It provides an API for defining pipelines as well as admin oriented APIs for invoking and running pipelines and API servers.


