# Some packages. We could merge these but I like granular dependencies.
{% for package in ['zsh', 'git', 'composer', 'php7.0-fpm', 'libcap2'] %}
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

# Caddy webserver.
# This build has the following plugins:
# - http.cors
# - http.prometheus
# - http.ratelimit
caddy:
  archive.extracted:
    - name: /opt/caddy
    - user: root
    - group: root
    - source: salt://puyonexus/files/caddy_v0.10.3_linux_amd64_custom.tar.gz

caddy-setcap:
  cmd.run:
    - name: setcap 'cap_net_bind_service=+ep' /opt/caddy/caddy
    - unless: getcap /opt/caddy/caddy | grep -q 'cap_net_bind_service+ep'
    - require_in:
      - service: caddy

/etc/systemd/system/caddy.service:
  file.managed:
    - source: salt://puyonexus/files/caddy.service
    - user: root
    - group: root
    - mode: 644
    - require_in:
      - service: caddy

/etc/caddy/Caddyfile:
  file.managed:
    - source: salt://puyonexus/files/Caddyfile
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - require_in:
      - service: caddy

caddy:
  service.running:
    - enable: true
    - reload: true
