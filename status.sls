# Query the solr cloud index status
# Pillar at the CLI
# salt_minion_test: salt-call --local state.show_sls solr.status
# salt_minion_run:  salt-call --local state.apply solr.status

{% from "solr/map.jinja" import solr with context %}


solr_start:
  cmd.run:
    - name: {{solr.install_dir}}/bin/solr.cmd status
