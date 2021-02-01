# Set the colrconfig file
# <documentCache size initialSize and autowarmcount
# 
# Pillar at the CLI
# salt_minion_test: salt-call --local state.show_sls solr
# salt_minion_run:  salt-call --local state.apply solr.config

{% from "solr/map.jinja" import solr with context %}


test_solrconfig_xml:
  cmd.run:
    - name: echo Configure the solrconfig.xml with document_cache_size {{solr.document_cache_size}} and document_cache_init {{solr.document_cache_init}} with autowarmCount {{solr.autowarm}}

 
solr_xml:
  file.managed:
    - name: {{solr.data}}/solrconfig.xml
    - source: salt://solr/files/solrconfig.xml
    - user: {{solr.user}}
{% if grains['os'] != "Windows" %}
    - group: {{solr_user}}
    - mode: 0644
{% endif %}    


set_solr_xml:
  file.replace:
  - name: {{solr.data}}/solrconfig.xml
  - pattern: '<documentCache jinja>'
  - repl: '<documentCache class="solr.LRUCache" autowarmCount="{{solr.autowarm}}" initialSize="{{solr.document_cache_init}}" size="{{solr.document_cache_size}}"/>'

{#
# Shoul
#    - user: {{solr.user}}
#    - group: {{solr.user}}
#    - mode: 0644
#}