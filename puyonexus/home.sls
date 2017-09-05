# App directory
/home/puyonexus/apps/home:
  file.directory:
    - user: puyonexus
    - group: www-data
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - require:
      - user: puyonexus

# App source code
home:
  git.latest:
    - name: https://github.com/puyonexus/home.git
    - user: puyonexus
    - target: /home/puyonexus/apps/home/home
    - require:
      - pkg: git
      - file: /home/puyonexus/apps/home

# Caddy configuration
/etc/caddy/sites/home.conf:
  file.managed:
    - source: salt://puyonexus/files/home/Caddyfile
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - require_in:
      - service: caddy
