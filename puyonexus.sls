zsh:
  pkg.installed

git:
  pkg.installed

puyonexus:
  user.present:
    - fullname: Puyo Nexus
    - shell: /bin/zsh
    - home: /home/puyonexus
    - uid: 1000
    - gid: www-data
    - require:
      - pkg: zsh

/home/puyonexus/apps/forum/phpbb:
  file.directory:
    - user: puyonexus
    - group: www-data
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - require:
      - user: puyonexus

/home/puyonexus/apps/forum/phpbb/ext/puyonexus/additions:
  file.directory:
    - user: puyonexus
    - group: www-data
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - require:
      - user: puyonexus

/home/puyonexus/apps/forum/phpbb/ext/puyonexus/textenhancements:
  file.directory:
    - user: puyonexus
    - group: www-data
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - require:
      - user: puyonexus

phpbb:
  git.latest:
    - name: https://github.com/puyonexus/phpbb.git
    - user: puyonexus
    - target: /home/puyonexus/apps/forum/phpbb
    - require:
      - file: /home/puyonexus/apps/forum/phpbb
    - require:
      - pkg: git
      - file: /home/puyonexus/apps/forum/phpbb

phpbb-ext-additions:
  git.latest:
    - name: https://github.com/puyonexus/phpbb-ext-additions.git
    - user: puyonexus
    - target: /home/puyonexus/apps/forum/phpbb/ext/puyonexus/additions
    - require:
      - file: /home/puyonexus/apps/forum/phpbb/ext/puyonexus/additions
    - require:
      - pkg: git
      - git: phpbb
      - file: /home/puyonexus/apps/forum/phpbb/ext/puyonexus/additions

phpbb-ext-textenhancements:
  git.latest:
    - name: https://github.com/puyonexus/phpbb-ext-textenhancements.git
    - user: puyonexus
    - target: /home/puyonexus/apps/forum/phpbb/ext/puyonexus/textenhancements
    - require:
      - file: /home/puyonexus/apps/forum/phpbb/ext/puyonexus/textenhancements
    - require:
      - pkg: git
      - git: phpbb
      - file: /home/puyonexus/apps/forum/phpbb/ext/puyonexus/textenhancements
