# Setup the solr cloud index
# Pillar at the CLI
# salt_minion_test: salt-call --local state.show_sls solr.zookeeper
# salt_minion_run:  salt-call --local state.apply solr.zookeeper

{% from "solr/map.jinja" import solr with context %}


solr_create_index:
  cmd.run:
    - name: echo Create a index directory
  file.directory:
    - name: {{solr.index_dir}}
    - makedirs: True
    

{% set solr_index_list =  ['solr.xml','zoo.cfg'] %}
{% for f in solr_index_list %}
solr_copy_config{{loop.index0}}:
  file.copy:
    - name:         "{{solr.index_dir}}{{f}}"
    - source:       salt://solr/files/{{f}}
{% endfor %}







{#
solr_copy_solr_xml:
  cmd.run:
    - name: echo copy solr.xml
  file.copy:
    - name:         "{{solr_index_dir}}solr.xml"
    - source:       "{{solr_install_dir}}/server/solr/solr.xml"
solr_copy_zoo_cfg:
  cmd.run:
    - name: echo copy zoo.cfg
  file.copy:
    - name:         "{{solr_index_dir}}zoo.cfg"
    - source:       "{{solr_install_dir}}/server/solr/zoo.cfg"


{% set zoo_data= salt['pillar.get']('solr:zoo_data', "c:/zookeeper/data/") %}
{% set zoo_logs= salt['pillar.get']('solr:zoo_logs', "c:/zookeeper/logs/") %}
{% set zoo_url= salt['pillar.get']('solr:zoo_url', "http://www.eu.apache.org/dist/zookeeper/") %}
{% set zoo_ver= salt['pillar.get']('solr:zoo_ver', "3.4.7") %}
{% set zoo_name= salt['pillar.get']('solr:zoo_name', "zookeeper") %}
{% set zoo_conf_dir= salt['pillar.get']('solr:zoo_conf_dir', "c:/zookeeper/conf/") %}
{% set zk1= salt['pillar.get']('solr:zoo_cluster:servers:zk1:ip', '') %}
{% set zk2= salt['pillar.get']('solr:zoo_cluster:servers:zk2:ip', '') %}
{% set zk3= salt['pillar.get']('solr:zoo_cluster:servers:zk3:ip', '') %}
{% set zk1_id= salt['pillar.get']('solr:zoo_cluster:servers:zk1:id', '') %}
{% set zk2_id= salt['pillar.get']('solr:zoo_cluster:servers:zk2:id', '') %}
{% set zk3_id= salt['pillar.get']('solr:zoo_cluster:servers:zk3:id', '') %}
{% set host_ip = salt['grains.get']('ipv4')[1] %}

{% if "zookeeper" in grains.get('roles', []) %}
zk_data_disk:
  mount.mounted:
    - name: {{zoo_data}}
    - device: /dev/xvdb1
    - mkmnt: True
    - fstype: ext4
zk_logs_disk:
  mount.mounted:
    - name: {{zoo_logs}}
    - device: /dev/xvdc1
    - mkmnt: True
    - fstype: ext4
{% endif %}

zookeeper:
  archive.extracted:
    - name: /opt/
    - source: {{zoo_url}}{{zoo_name}}-{{zoo_ver}}/{{zoo_name}}-{{zoo_ver}}.tar.gz
    - source_hash: {{zoo_url}}{{zoo_name}}-{{zoo_ver}}/{{zoo_name}}-{{zoo_ver}}.tar.gz.md5
    - archive_format: tar
    - user: root
    - if_missing: /opt/{{zoo_name}}-{{zoo_ver}}/

zookeeper_symlink:
  file.symlink:
    - name: /opt/{{zoo_name}}
    - target: /opt/{{zoo_name}}-{{zoo_ver}}/
    - user: root
    - mode: 0755
    - recurse:
      - user
      - mode

zookeeper_data_dir:
  file.directory:
    - name: {{zoo_data}}
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - recurse:
      - user
      - group
      - mode
    - makedirs: True

zookeeper_logs_dir:
  file.directory:
    - name: {{zoo_logs}}
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - recurse:
      - user
      - group
      - mode

zookeeper_config_file:
  file.managed:
    - name: {{zoo_conf_dir}}zoo.cfg
    - source: salt://solrcloud/files/zoo.cfg
    - template: jinja
    - user: root
    - mode: 0644

zookeeper_log4j_file:
  file.managed:
    - name: {{zoo_conf_dir}}log4j.properties
    - source: salt://solrcloud/files/log4j.properties.zookeeper
    - template: jinja
    - user: root
    - mode: 0744
    - makedirs: True

{% if host_ip == zk1 %}
{% set zk_id = zk1_id%}
{% elif host_ip == zk2 %}
{% set zk_id = zk2_id%}
{% elif host_ip == zk3 %}
{% set zk_id = zk3_id%}
{%endif%}
myid:
  file.managed:
    - name: {{zoo_data}}myid
    - source: salt://solrcloud/files/myid
    - defaults:
      myid: {{zk_id}}
    - template: jinja
    - user: root
    - mode: 0644
    - makedirs: True

zookeeper_run:
  cmd.run:
    - name: /opt/zookeeper/bin/zkServer.sh start
    - env:
      - ZOO_LOG_DIR: /var/log/
      - ZOO_LOG4J_PROP: 'INFO,ROLLINGFILE'

#}