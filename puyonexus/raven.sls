# App source code
raven-loader:
  git.latest:
    - name: https://github.com/puyonexus/raven-loader.git
    - user: puyonexus
    - target: /home/puyonexus/libs/raven-loader
    - require:
      - pkg: git
      - file: /home/puyonexus/libs

# Run composer (after getting everything else)
raven-loader-composer:
  composer.installed:
    - name: /home/puyonexus/libs/raven-loader
    - no_dev: true
    - user: puyonexus
    - require:
      - pkg: composer
      - git: phpbb
