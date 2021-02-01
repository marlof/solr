# Stop the solr cloud index
# Pillar at the CLI
# salt_minion_test: salt-call --local state.show_sls solr.stop
# salt_minion_run:  salt-call --local state.apply solr.stop

{% from "solr/map.jinja" import solr with context %}

{% set solr_install_dir=  salt['pillar.get']('solr:install_dir', "C:/solr") %}


solr_stop:
  cmd.run:
    - name: echo Stopping {{solr.install_dir}}/bin/solr.cmd
    - name: {{solr.install_dir}}/bin/solr.cmd stop -all