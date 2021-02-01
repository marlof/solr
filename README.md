# Solr Installation & configuration

Installation and configuration of Apache Solr indexer.

Solr is a standalone enterprise search server with a REST-like API. You put documents in it (called "indexing") via JSON, XML, CSV or binary over HTTP. You query it via HTTP GET and receive JSON, XML, CSV or binary results.

| **Variable** | **SLS** | **Owner** | **Comments** | **Default** | **env1** | **env2** |
|----------|-----|-------|----------|---------|------|------|
| name | install | TBD | The name of the package | solr | |
| install_dir | install | TBD |Location of installation | C:/solr | |
| ver | install | TBD | The version of solr to install| 7.7.3 | |
| url | install | TBD | Download base URL of sip file| https://ftp.heanet.ie/mirrors/www.apache.org/dist/lucene/solr/ ||
| hash | install | TBD | The has value of the zip file| 45461fb86851f8615f02dbc89a942facdd13ab9ca0d984eaf35ec1ed2cef653af738320945749c3130d27d5581a1f0ede34bdaf1ca9afbd4f9a631432d6ada58 | |
| logs | install | TBD | Logs directory | C:/solr/logs/ | |
| data | install | TBD | Data diretcory | C:/solr/data/ | |
| home | install | TBD | Home diretcory | C:/solr | |
| user | install | TBD | Process owner of solr. Typically the jvm process owner | solr | |

| **Variable** | **SLS** | **Owner** | **Comments** | **Default** | **env1** | **env2** |
|----------|-----|-------|----------|---------|------|------|
| index | zookeeper | TBD | SolrCloud Setup | c:/solr/node1 | | |
| port | start | TDB | Index port solrcloud | 8983 | | |