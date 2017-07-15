# App directory
/home/puyonexus/apps/wiki:
  file.directory:
    - user: puyonexus
    - group: www-data
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - require:
      - user: puyonexus


# App volumes
/home/puyonexus/volumes/wiki-images:
  file.directory:
    - user: puyonexus
    - group: www-data
    - dir_mode: 775
    - file_mode: 664
    - makedirs: True
    - require:
      - user: puyonexus
    - recurse:
      - user
      - group
      - mode


# Volume mounts
/home/puyonexus/apps/wiki/mediawiki/images:
  mount.mounted:
    - device: /home/puyonexus/volumes/wiki-images
    - fstype: none
    - opts: bind
    - require:
      - git: phpbb
      - file: /home/puyonexus/volumes/wiki-images


# Cache directory
/home/puyonexus/apps/wiki/mediawiki/cache:
  file.directory:
    - user: puyonexus
    - group: www-data
    - dir_mode: 775
    - file_mode: 664
    - makedirs: True
    - require:
      - git: phpbb
    - recurse:
      - user
      - group
      - mode


# Caddy configuration
/etc/caddy/sites/wiki.conf:
  file.managed:
    - source: salt://puyonexus/files/wiki/Caddyfile
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - require_in:
      - service: caddy


# App source code
mediawiki:
  git.latest:
    - name: https://github.com/puyonexus/mediawiki.git
    - user: puyonexus
    - target: /home/puyonexus/apps/wiki/mediawiki
    - require:
      - pkg: git
      - file: /home/puyonexus/apps/wiki


# Extension source code
{% for ext in salt['pillar.get']('mediawiki:extensions') %}
mediawiki-extensions-{{ ext }}:
  git.latest:
    - name: https://github.com/puyonexus/mediawiki-extensions-{{ ext }}.git
    - user: puyonexus
    - target: /home/puyonexus/apps/wiki/mediawiki/extensions/{{ ext }}
    - require:
      - git: mediawiki
{% endfor %}


# Skin source code
{% for skin in salt['pillar.get']('mediawiki:skins') %}
mediawiki-skins-{{ skin }}:
  git.latest:
    - name: https://github.com/puyonexus/mediawiki-skins-{{ skin }}.git
    - user: puyonexus
    - target: /home/puyonexus/apps/wiki/mediawiki/skins/{{ skin }}
    - require:
      - git: mediawiki
{% endfor %}


# Settings
/home/puyonexus/apps/wiki/mediawiki/LocalSettings.php:
  file.managed:
    - user: puyonexus
    - group: www-data
    - source: salt://puyonexus/files/wiki/LocalSettings.php
    - template: jinja
    - require:
      - git: mediawiki


# Skin settings
/home/puyonexus/apps/wiki/mediawiki/LocalSettings.Skins.php:
  file.managed:
    - user: puyonexus
    - group: www-data
    - source: salt://puyonexus/files/wiki/LocalSettings.Skins.php
    - template: jinja
    - require:
      - git: mediawiki


# Extension settings
/home/puyonexus/apps/wiki/mediawiki/LocalSettings.Extensions.php:
  file.managed:
    - user: puyonexus
    - group: www-data
    - source: salt://puyonexus/files/wiki/LocalSettings.Extensions.php
    - template: jinja
    - require:
      - git: mediawiki
