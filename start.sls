# Setup the solr cloud index
# salt_test: salt-call --local pillar.data
# Pillar at the CLI
# salt_minion_test: salt-call --local state.show_sls solr.start
# salt_minion_run:  salt-call --local state.apply solr.start

{% from "solr/map.jinja" import solr with context %}


solr_start:
  cmd.run:
  {% if salt['file.directory_exists'](solr.install_dir) and salt['file.directory_exists'](solr.data)    %}
    - name: echo Starting {{solr.install_dir}}/bin/solr.cmd on port {{solr.port}} try http://localhost:{{solr.port}}
    - name: echo {{solr.install_dir}}/bin/solr.cmd start -cloud -p {{solr.port}} -s {{solr.index}}
  {% else %}
    - name: echo Not sure that {{ solr.name }} has been installed yet. Make sure the {{solr.install_dir}} and {{solr.data}} directories exsist.
{% endif %}