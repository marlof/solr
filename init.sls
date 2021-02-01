# Deploy the solr APP into windows
# Pillar at the CLI
# salt_minion_test: salt-call --local state.show_sls solr
# salt_minion_run:  salt-call --local state.apply solr

{% from "solr/map.jinja" import solr with context %}

include:
  - solr.install
  - solr.projectconfig

test_check_version:
  cmd.run:
    - name: echo "{{solr.install_dir}}/bin/solr.cmd version"
    - name: echo "Now run salt-call --local state.apply solr.start and check localhost"