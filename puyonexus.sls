zsh:
  pkg.installed

git:
  pkg.installed

composer:
  pkg.installed

php7.0-fpm:
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

oh-my-zsh:
  git.latest:
    - name: git://github.com/robbyrussell/oh-my-zsh.git
    - user: puyonexus
    - target: /home/puyonexus/.oh-my-zsh
    - require:
      - pkg: git
      - user: puyonexus

/home/puyonexus/.zshrc:
  file.managed:
    - user: puyonexus
    - group: puyonexus
    - contents:
      - 'export ZSH=$HOME/.oh-my-zsh'
      - 'ZSH_THEME="dieter"'
      - 'plugins=(git)'
      - 'source $ZSH/oh-my-zsh.sh'

/home/puyonexus/volumes/forum-avatars:
  file.directory:
    - user: puyonexus
    - group: www-data
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - require:
      - user: puyonexus

/home/puyonexus/volumes/forum-files:
  file.directory:
    - user: puyonexus
    - group: www-data
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - require:
      - user: puyonexus

/home/puyonexus/volumes/wiki-images:
  file.directory:
    - user: puyonexus
    - group: www-data
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - require:
      - user: puyonexus

/home/puyonexus/apps/chainsim:
  file.directory:
    - user: puyonexus
    - group: www-data
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - require:
      - user: puyonexus

/home/puyonexus/apps/forum:
  file.directory:
    - user: puyonexus
    - group: www-data
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - require:
      - user: puyonexus

/home/puyonexus/apps/home:
  file.directory:
    - user: puyonexus
    - group: www-data
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - require:
      - user: puyonexus

/home/puyonexus/apps/wiki:
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
      - pkg: git
      - file: /home/puyonexus/apps/forum

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

mediawiki:
  git.latest:
    - name: https://github.com/puyonexus/mediawiki.git
    - user: puyonexus
    - target: /home/puyonexus/apps/wiki/mediawiki
    - require:
      - pkg: git
      - file: /home/puyonexus/apps/wiki

mediawiki-skin-vectornexus:
  git.latest:
    - name: https://github.com/puyonexus/mediawiki-skin-vectornexus.git
    - user: puyonexus
    - target: /home/puyonexus/apps/wiki/mediawiki/skins/VectorNexus
    - require:
      - git: mediawiki

mediawiki-embedvideo:
  git.latest:
    - name: https://github.com/puyonexus/mediawiki-embedvideo.git
    - user: puyonexus
    - target: /home/puyonexus/apps/wiki/mediawiki/extensions/EmbedVideo
    - require:
      - git: mediawiki

mediawiki-extensions-math:
  git.latest:
    - name: https://github.com/puyonexus/mediawiki-extensions-math.git
    - user: puyonexus
    - target: /home/puyonexus/apps/wiki/mediawiki/extensions/Math
    - require:
      - git: mediawiki

/home/puyonexus/apps/wiki/mediawiki/images:
  mount.mounted:
    - device: /home/puyonexus/volumes/wiki-images
    - fstype: none
    - opts: bind
    - require:
      - git: phpbb
      - file: /home/puyonexus/volumes/wiki-images
