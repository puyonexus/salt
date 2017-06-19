# App directory
/home/puyonexus/apps/forum:
  file.directory:
    - user: puyonexus
    - group: www-data
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - require:
      - user: puyonexus


# App volumes
/home/puyonexus/volumes/forum-files:
  file.directory:
    - user: puyonexus
    - group: www-data
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - require:
      - user: puyonexus

/home/puyonexus/volumes/forum-avatars:
  file.directory:
    - user: puyonexus
    - group: www-data
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - require:
      - user: puyonexus


# Volume mounts
/home/puyonexus/apps/forum/phpbb/phpBB/files:
  mount.mounted:
    - device: /home/puyonexus/volumes/forum-files
    - fstype: none
    - opts: bind
    - require:
      - git: phpbb
      - file: /home/puyonexus/volumes/forum-files

/home/puyonexus/apps/forum/phpbb/phpBB/images/avatars/upload:
  mount.mounted:
    - device: /home/puyonexus/volumes/forum-avatars
    - fstype: none
    - opts: bind
    - require:
      - git: phpbb
      - file: /home/puyonexus/volumes/forum-avatars


# App source code
phpbb:
  git.latest:
    - name: https://github.com/puyonexus/phpbb.git
    - user: puyonexus
    - target: /home/puyonexus/apps/forum/phpbb
    - require:
      - pkg: git
      - file: /home/puyonexus/apps/forum


# Extensions
/home/puyonexus/apps/forum/phpbb/phpBB/ext/puyonexus:
  file.directory:
    - user: puyonexus
    - group: www-data
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - require:
      - git: phpbb
      - user: puyonexus

phpbb-ext-additions:
  git.latest:
    - name: https://github.com/puyonexus/phpbb-ext-additions.git
    - user: puyonexus
    - target: /home/puyonexus/apps/forum/phpbb/phpBB/ext/puyonexus/additions
    - require:
      - pkg: git
      - git: phpbb
      - file: /home/puyonexus/apps/forum/phpbb/phpBB/ext/puyonexus

phpbb-ext-textenhancements:
  git.latest:
    - name: https://github.com/puyonexus/phpbb-ext-textenhancements.git
    - user: puyonexus
    - target: /home/puyonexus/apps/forum/phpbb/phpBB/ext/puyonexus/textenhancements
    - require:
      - pkg: git
      - git: phpbb
      - file: /home/puyonexus/apps/forum/phpbb/phpBB/ext/puyonexus


# Run composer (after getting everything else)
phpbb-composer:
  composer.installed:
    - name: /home/puyonexus/apps/forum/phpbb/phpBB
    - no_dev: true
    - user: puyonexus
    - require:
      - pkg: composer
      - git: phpbb
      - git: phpbb-ext-additions
      - git: phpbb-ext-textenhancements