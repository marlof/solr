# Deploy the solr APP into windows
# Pillar at the CLI
# salt_minion_test: salt-call --local state.show_sls solr.install
# salt_minion_run:  salt-call --local state.apply solr.install

{% from "solr/map.jinja" import solr with context %}


solr_temp_dir:
  file.directory:
    - name: {{solr.temp}}
    - makedirs: True
 

solr_extract:
  archive.extracted:
    - name:         "{{solr.temp}}"
    - source:       "{{solr.url}}{{solr.ver}}/{{solr.name}}-{{solr.ver}}.zip"
    - source_hash:  "{{solr.hash}}"


solr_rename_extracted:
  file.rename:
    - name:         "{{solr.install_dir}}"
    - source:       "{{solr.temp}}/{{solr.name}}-{{solr.ver}}"
    - force:        True


{% set solr_dir_list = [solr.home,solr.logs,solr.data,solr.index] %}
{% for d in solr_dir_list %}
solr_create_dirs{{loop.index0}}:
  file.directory:
    - name: {{d}}
    - makedirs: True
{% endfor %}


solr_check_version:
  cmd.run:
    - name: "{{solr.install_dir}}/bin/solr.cmd version"