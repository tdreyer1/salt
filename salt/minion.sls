salt_minion_config:
  file.managed:
    - name: /etc/salt/minion
    - source: salt://salt/files/minion

salt_minion_service:
  service.running:
    - name: salt-minion
    - enable: true
    - require:
      - cmd: salt_minion_systemd_reload

salt_minion_service_override:
  file.managed:
    - name: /etc/systemd/system/salt-minion.service.d/override.conf
    - source: salt://salt/files/salt-minion.service
    - makedirs: true

salt_minion_systemd_reload:
  cmd.run:
    - name: systemctl daemon-reload
    - onchanges:
      - file: salt_minion_service_override

salt_minion_restart:
  cmd.run:
    - name: salt-call --local service.restart salt-minion
    - bg: true
    - require: 
      - cmd: salt_minion_systemd_reload
    - onchanges:
      - file: salt_minion_config
      - file: salt_minion_service_override
   