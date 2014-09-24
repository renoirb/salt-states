udplog:
  pkg.installed

#/mnt:
#  mount.mounted:
#    - name: /mnt
#    - device: /dev/vdc1
#    - fstype: xfs
#    - mkmnt: True
#    - opts:
#      - defaults
#
#/mnt/logs/mw-logs:
#  file.directory:
#    - user: udp2log
#    - mode: 755
#    - makedirs: True
#    - require:
#      - mount: /mnt

/usr/local/bin/demux.py:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://logging/demux.py

/etc/udp2log:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://logging/udp2log
    - require:
      - pkg: udplog

udp2log:
  service.running:
    - watch:
      - file: /etc/udp2log
    - require:
      - file: /etc/udp2log
      - file: /usr/local/bin/demux.py
#      - file: /mnt/logs/mw-logs
