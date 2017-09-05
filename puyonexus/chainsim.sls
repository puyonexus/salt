# App directory
/home/puyonexus/apps/chainsim:
  file.directory:
    - user: puyonexus
    - group: www-data
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - require:
      - user: puyonexus

# App source code
puyosim:
  git.latest:
    - name: https://github.com/puyonexus/puyosim.git
    - user: puyonexus
    - target: /home/puyonexus/apps/chainsim/puyosim
    - require:
      - pkg: git
      - file: /home/puyonexus/apps/chainsim

# Run composer
puyosim-composer:
  composer.installed:
    - name: /home/puyonexus/apps/chainsim/puyosim
    - no_dev: true
    - user: puyonexus
    - require:
      - pkg: composer
      - git: puyosim

# Caddy configuration
/etc/caddy/sites/chainsim.conf:
  file.managed:
    - source: salt://puyonexus/files/chainsim/Caddyfile
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - require_in:
      - service: caddy
