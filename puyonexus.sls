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
    - group: www-data
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

mediawiki-skin-VectorNexus:
  git.latest:
    - name: https://github.com/puyonexus/mediawiki-skin-VectorNexus.git
    - user: puyonexus
    - target: /home/puyonexus/apps/wiki/mediawiki/skins/VectorNexus
    - require:
      - git: mediawiki

{% for ext in salt['pillar.get']('mediawiki:extensions') %}
mediawiki-extensions-{{ ext }}:
  git.latest:
    - name: https://github.com/puyonexus/mediawiki-extensions-{{ ext }}.git
    - user: puyonexus
    - target: /home/puyonexus/apps/wiki/mediawiki/extensions/{{ ext }}
    - require:
      - git: mediawiki
{% endfor %}

{% for skin in salt['pillar.get']('mediawiki:skins') %}
mediawiki-skins-{{ skin }}:
  git.latest:
    - name: https://github.com/puyonexus/mediawiki-skins-{{ skin }}.git
    - user: puyonexus
    - target: /home/puyonexus/apps/wiki/mediawiki/skins/{{ skin }}
    - require:
      - git: mediawiki
{% endfor %}

/home/puyonexus/apps/wiki/mediawiki/LocalSettings.php:
  file.managed:
    - user: puyonexus
    - group: www-data
    - contents:
      - "<?php"
      - "# AUTOGENERATED BY SALT - see puyonexus/salt on GitHub."
      - "if (!defined('MEDIAWIKI')) { exit; }"
      - "# Configuration"
      - "$wgSitename = '{{ salt['pillar.get']('mediawiki:sitename') }}';"
      - "$wgMetaNamespace = '{{ salt['pillar.get']('mediawiki:namespace') }}';"
      - "$wgLanguageCode = 'en';"
      - "$wgSecretKey = '{{ salt['pillar.get']('mediawiki:secretkey') }}';"
      - "$wgUpgradeKey = '{{ salt['pillar.get']('mediawiki:upgradekey') }}';"
      - "$wgScriptPath = '/mediawiki';"
      - "$wgScriptExtension  = '.php';"
      - "$wgArticlePath = '/wiki/$1';"
      - "$wgServer = 'https://puyonexus.com';"
      - "$wgStylePath = '$wgScriptPath/skins';"
      - "$wgLogo = '/images/wiki/logo.png';"
      - "$wgEnableEmail = true;"
      - "$wgEnableUserEmail = true;"
      - "$wgEmergencyContact = '{{ salt['pillar.get']('mediawiki:contact') }}';"
      - "$wgPasswordSender = '{{ salt['pillar.get']('mediawiki:contact') }}';"
      - "$wgEnotifUserTalk = false;"
      - "$wgEnotifWatchlist = false;"
      - "$wgEmailAuthentication = true;"
      - "$wgEnableUploads = true;"
      - "$wgAllowExternalImages = true;"
      - "$wgAllowCopyUploads = true;"
      - "$wgCopyUploadsFromSpecialUpload = true;"
      - "$wgUseInstantCommons = false;"
      - "$wgShellLocale = 'en_US.utf8';"
      - "$wgSpamBlacklistFiles = array(); # Don't use WikiMedia blacklist"
      - "# Permissions"
      - "$wgGroupPermissions['*']['edit'] = false; # Disable anon editing"
      - "$wgGroupPermissions['*']['createaccount'] = false; # Disable account creation"
      - "$wgGroupPermissions['sysop']['upload_by_url'] = true;"
      - "# Database"
      - "$wgDBtype = 'mysql';"
      - "$wgDBserver = '{{ salt['pillar.get']('mysql:hostname') }}:3306';"
      - "$wgDBname = '{{ salt['pillar.get']('mysql:database') }}';"
      - "$wgDBuser = '{{ salt['pillar.get']('mysql:username') }}';"
      - "$wgDBpassword = '{{ salt['pillar.get']('mysql:password') }}';"
      - "$wgDBprefix = 'mw_';"
      - "$wgDBTableOptions = 'ENGINE=InnoDB, DEFAULT CHARSET=utf8';"
      - "$wgDBmysql5 = false;"
      - "# Caching"
      - "$wgMainCacheType = CACHE_NONE; # TODO"
      - "$wgMemCachedServers = array();"
      - "$wgCacheDirectory = '$IP/cache';"
      - "# Extensions"
      - "require_once('./PN_LoadExtensions.php');"
      - "# Skins"
      - "require_once('./PN_LoadSkins.php');"
      - "$wgVectorUseSimpleSearch = true;"
      - "$wgDefaultUserOptions['usebetatoolbar'] = 1;"
      - "$wgDefaultUserOptions['usebetatoolbar-cgd'] = 1;"
      - "$wgDefaultUserOptions['wikieditor-preview'] = 1;"
      - "$wgDefaultUserOptions['vector-collapsiblenav'] = 1;"
      - "# CAPTCHA"
      - "$wgCaptchaClass = 'QuestyCaptcha';"
      - "$wgCaptchaQuestions[] = array('question' => 'What is the name (in English) of the protagonist\\'s pet/sidekick in the video game Puyo Puyo?', 'answer' => 'Carbuncle');"
    - require:
      - git: mediawiki

/home/puyonexus/apps/wiki/mediawiki/PN_LoadSkins.php:
  file.managed:
    - user: puyonexus
    - group: www-data
    - contents:
      - "<?php"
      - "# AUTOGENERATED BY SALT - see puyonexus/salt on GitHub."
      - "if (!defined('MEDIAWIKI')) { exit; }"
{% for skin in mwskins %}
      - "wfLoadSkin('{{ skin }}');"
{% endfor %}
    - require:
      - git: mediawiki

/home/puyonexus/apps/wiki/mediawiki/PN_LoadExtensions.php:
  file.managed:
    - user: puyonexus
    - group: www-data
    - contents:
      - "<?php"
      - "# AUTOGENERATED BY SALT - see puyonexus/salt on GitHub."
      - "if (!defined('MEDIAWIKI')) { exit; }"
{% for ext in mwexts %}
      - "wfLoadExtension('{{ ext }}');"
{% endfor %}
      - "wfLoadExtension('ConfirmEdit/QuestyCaptcha');"
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
