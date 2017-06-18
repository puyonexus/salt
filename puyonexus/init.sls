# Some packages. We could merge these but I like granular dependencies.
{% for package in ['zsh', 'git', 'composer', 'php7.0-fpm'] %}
{{ package }}:
  pkg.installed
{% endfor %}


# Puyo Nexus user.
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
