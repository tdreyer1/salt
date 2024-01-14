# Salt state for gitlab
gitlab_repo:
  pkgrepo.managed:
    - name: gitlab_gitlab-ce
    - humanname: Gitlab CE
    - baseurl: https://packages.gitlab.com/gitlab/gitlab-ce/el/$releasever/$basearch
    - gpgkey: 
      - https://packages.gitlab.com/gitlab/gitlab-ce/gpgkey
      - https://packages.gitlab.com/gitlab/gitlab-ce/gpgkey/gitlab-gitlab-ce-3D645A26AB9FBD22.pub.gpg
    - gpgcheck: 1
    - repo_gpgcheck: 1
    - enabled: 1
    - metadata_expire: 300
    - sslverify: 1
    - sslcacert: /etc/pki/tls/certs/ca-bundle.crt

gitlab_pkgs:
  pkg.installed:
    - pkgs:
      - tar
      - gitlab-ce
    - require:
      - pkgrepo: gitlab_repo

gitlab_config:
  file.managed:
    - name: /etc/gitlab/gitlab.rb
    - source: salt://gitlab/files/gitlab.rb
    - template: jinja 
