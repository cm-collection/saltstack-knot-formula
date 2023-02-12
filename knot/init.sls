{{ tpldot }}:
  pkgrepo.managed:
    - humanname: knot
    - file: /etc/apt/sources.list.d/knot.list
    - name: deb https://ppa.launchpadcontent.net/cz.nic-labs/knot-dns-latest/ubuntu {{ salt['grains.get']('oscodename')|string }}  main
    - keyid: F2331238F9C59A45
    - keyserver: keyserver.ubuntu.com
    - enabled: True
    - clean_file: True
  pkg.latest:
    - pkgs:
      - knot
      - knot-dnsutils
      - knot-host
      - knot-module-dnstap
      - knot-module-geoip
    - refresh: True
    - require:
      - pkgrepo: {{ tpldot }}

/etc/knot/conf.d:
  file.directory:
    - user: knot
    - group: knot
    - require:
      - pkg: {{ tpldot }}

/var/lib/knot/zones:
  file.directory:
    - user: knot
    - group: knot
    - require:
      - pkg: {{ tpldot }}
