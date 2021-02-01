# Configure the solr APP into windows
# Pillar at the CLI
# salt_minion_test: salt-call --local state.show_sls solr
# salt_minion_run:  salt-call --local state.apply solr.projectconfig

{% from "solr/map.jinja" import solr with context %}

include:
  - solr.config
  - solr.changeheap

project_solr_check_version:
  cmd.run:
    - name: {{solr.install_dir}}/bin/solr.cmd version














{#

test:
  test.nop:
    - user: {{solr.user}}
    - solr_name: {{solr.name}}

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


{% for d in solr.dir_list %}
solr_create_dirs{{loop.index0}}:
  file.directory:
    - name: {{d}}
    - makedirs: True
{% endfor %}

{#

solr_init_file:
  file.managed:
    - name: /etc/init.d/{{solr_name}}
    - source: salt://solr/files/solr
    - template: jinja
    - user: root
    - mode: 0755

solr_include_file:
  file.managed:
    - name: /etc/default/solr.in.sh
    - source: salt://solr/files/solr.in.sh
    - template: jinja
    - user: root
    - mode: 0644

solr_xml:
  file.managed:
    - name: {{solr_data}}solr.xml
    - source: salt://solr/files/solr.xml
    - template: jinja
    - user: {{solr_user}}
    - group: {{solr_user}}
    - mode: 0644

solr_log4j:
  file.managed:
    - name: {{solr_home}}log4j.properties
    - source: salt://solr/files/log4j.properties
    - template: jinja
    - user: {{solr_user}}
    - group: {{solr_user}}
    - mode: 0644

solr_service:
  service.running:
    - name: {{solr_name}}
    - enable: True
    - provider: service
    - reload: True
    - watch:
      - file: {{solr_data}}solr.xml
      - file: {{solr_home}}log4j.properties
#}