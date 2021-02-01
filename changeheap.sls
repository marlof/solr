# Configure the solr APP into windows
# Pillar at the CLI
# Set the SOLR HEAP
# salt_minion_test: salt-call --local state.show_sls solr
# salt_minion_run:  salt-call --local state.apply solr.projectconfig

{% from "solr/map.jinja" import solr with context %}



change_heap:
  cmd.run:
    - name: echo set SOLR_HEAP={{solr.heap}} and JAVA MEM of {{solr.java_mem}}


set_solr_heap:
  file.replace:
  - name:    {{solr.install_dir}}/bin/solr.cmd
  - pattern: 'set SOLR_HEAP=%~2'
  - repl:    'set SOLR_HEAP={{solr.heap}}'


set_solr_java:
  file.replace:
  - name:    {{solr.install_dir}}/bin/solr.cmd
  - pattern: 'SOLR_JAVA_MEM=-Xms512m -Xmx512m'
  - repl:    'SOLR_JAVA_MEM=-Xms{{solr.java_mem}} -Xmx{{solr.java_mem}}'


# SOLR_JAVA_MEM=-Xms512m -Xmx512m


test_changeheap_xml:
  cmd.run:
    - name: echo Configure the solrconfig.xml with document_cache_size {{solr.document_cache_size}} and document_cache_init {{solr.document_cache_init}} with autowarmCount {{solr.autowarm}}

{# 
 
solr_xml:
  file.managed:
    - name: {{solr.data}}/solrconfig.xml
    - source: salt://solr/files/solrconfig.xml
    - user: {{solr.user}}
{% if grains['os'] != "Windows" %}
    - group: {{solr.user}}
    - mode: 0644
{% endif %}    



#}