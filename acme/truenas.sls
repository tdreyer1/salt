{% from "acme/map.jinja" import acme with context %}
{% from "common/map.jinja" import common with context %}
# Set up and configure the deploy-freenas script
# https://github.com/danb35/deploy-freenas.git

deploy_freenas_git:
  git.latest:
    - name: https://github.com/danb35/deploy-freenas.git
    - target: "/home/{{ common.primary_user.username }}/deploy_freenas/"
    - runas: {{ common.primary_user.username }}
    - force_fetch: True
    - depth: 1

deploy_freenas_config:
  file.managed:
    - name: /home/{{ common.primary_user.username }}/deploy_freenas/deploy_config
    - source: salt://acme/files/deploy_config
    - user: {{ common.primary_user.username }}
    - group: {{ common.primary_user.username }}
    - mode: "0640"
    - template: jinja
    - context:
        acme: {{ acme }}
        common: {{ common }ss