## NOTICE
#
# Due to the scope and complexity of this chart, all possible values are
# not documented in this file. Extensive documentation is available.
#
# Please read the docs: https://docs.gitlab.com/charts/
#
# Because properties are regularly added, updated, or relocated, it is
# _strongly suggest_ to not "copy and paste" this YAML. Please provide
# Helm only those properties you need, and allow the defaults to be
# provided by the version of this chart at the time of deployment.

## Advanced Configuration
## https://docs.gitlab.com/charts/advanced
#
# Documentation for advanced configuration, such as
# - External PostgreSQL
# - External Gitaly
# - External Redis
# - External NGINX
# - External Object Storage providers
# - PersistentVolume configuration

## The global properties are used to configure multiple charts at once.
## https://docs.gitlab.com/charts/charts/globals
global:
  common:
    labels: {}
  ## GitLab operator is DEPRECATED. DO NOT USE.
  operator:
    enabled: false
    rollout:
      autoPause: true

  ## Supplemental Pod labels. Will not be used for selectors.
  pod:
    labels: {}

  ## https://docs.gitlab.com/charts/installation/deployment#deploy-the-community-edition
  edition: ce

  ## https://docs.gitlab.com/charts/charts/globals#gitlab-version
  # gitlabVersion: master

  ## https://docs.gitlab.com/charts/charts/globals#application-resource
  application:
    create: false
    links: []
    allowClusterRoles: true
  ## https://docs.gitlab.com/charts/charts/globals#configure-host-settings
  hosts:
    domain: ${DOMAIN}
    hostSuffix:
    https: true
    externalIP: ${INGRESS_IP}
    ssh: ~
    gitlab: {}
    minio: {}
    registry: {}
    tls: {}
    smartcard: {}
    kas: {}
    pages: {}

  ## https://docs.gitlab.com/charts/charts/globals#configure-ingress-settings
  ingress:
    configureCertmanager: true
    annotations: {}
    enabled: true
    tls: {
      enabled: true
    }
    #   enabled: true
    #   secretName:
    path: /
    pathType: Prefix

  gitlab:
    ## Enterprise license for this GitLab installation
    ## Secret created according to https://docs.gitlab.com/charts/installation/secrets#initial-enterprise-license
    ## If allowing shared-secrets generation, this is OPTIONAL.
    license: {}
      # secret: RELEASE-gitlab-license
      # key: license

  ## Initial root password for this GitLab installation
  ## Secret created according to https://docs.gitlab.com/charts/installation/secrets#initial-root-password
  ## If allowing shared-secrets generation, this is OPTIONAL.
  initialRootPassword: {}
    # secret: RELEASE-gitlab-initial-root-password
    # key: password

  ## https://docs.gitlab.com/charts/charts/globals#configure-postgresql-settings
  psql:
    connectTimeout:
    password:
      secret: gitlab-pg
      key: password
      # useSecret:
      # secret:
      # key:
      # file:
      host: ${DB_PRIVATE_IP}
      port: 5432
      username: gitlab
      database: gitlabhq_production
    # host: postgresql.hostedsomewhere.else
    # port: 123
    # username: gitlab
    # database: gitlabhq_production
    # applicationName:
    # preparedStatements: false

  ## https://docs.gitlab.com/charts/charts/globals#configure-redis-settings
  redis:
    password:
      enabled: true
      # secret:
      # key:
    host: ${REDIS_PRIVATE_IP}
    # host: redis.hostedsomewhere.else
    # port: 6379
    # sentinels:
    #   - host:
    #     port:

  ## https://docs.gitlab.com/charts/charts/globals#configure-gitaly-settings
  gitaly:
    enabled: true
    authToken: {}
      # secret:
      # key:
    # serviceName:
    internal:
      names: ['default']
    external: []
    service:
      name: gitaly
      type: ClusterIP
      externalPort: 8075
      internalPort: 8075
      tls:
        externalPort: 8076
        internalPort: 8076
    tls:
      enabled: false
      # secretName:

  praefect:
    enabled: false
    replaceInternalGitaly: true
    authToken: {}
    autoMigrate: true
    dbSecret: {}
    virtualStorages:
      - name: default
        gitalyReplicas: 3
        maxUnavailable: 1
    psql:
      sslMode: 'disable'
    # serviceName:
    service:
      name: praefect
      type: ClusterIP
      externalPort: 8075
      internalPort: 8075
      tls:
        externalPort: 8076
        internalPort: 8076
    tls:
      enabled: false
      # secretName:

  ## https://docs.gitlab.com/charts/charts/globals#configure-minio-settings
  minio:
    enabled: true
    credentials: {}
      # secret:

  ## https://docs.gitlab.com/charts/charts/globals#configure-grafana-integration
  grafana:
    enabled: false

  ## https://docs.gitlab.com/charts/charts/globals#configure-appconfig-settings
  ## Rails based portions of this chart share many settings
  appConfig:
    ## https://docs.gitlab.com/charts/charts/globals#general-application-settings
    enableUsagePing: false
    enableSeatLink: true
    enableImpersonation:
    applicationSettingsCacheSeconds: 60
    defaultCanCreateGroup: true
    usernameChangingEnabled: true
    issueClosingPattern:
    defaultTheme:
    defaultProjectsFeatures:
      issues: true
      mergeRequests: true
      wiki: true
      snippets: true
      builds: true
    webhookTimeout:
    maxRequestDurationSeconds:

    ## https://docs.gitlab.com/charts/charts/globals#cron-jobs-related-settings
    cron_jobs: {}
      ## Flag stuck CI builds as failed
      # stuck_ci_jobs_worker:
      #   cron: "0 * * * *"
      ## Schedule pipelines in the near future
      # pipeline_schedule_worker:
      #   cron: "19 * * * *"
      ## Remove expired build artifacts
      # expire_build_artifacts_worker:
      #   cron: "*/7 * * * *"
      ## Periodically run 'git fsck' on all repositories.
      # repository_check_worker:
      #   cron: "20 * * * *"
      ## Send admin emails once a week
      # admin_email_worker:
      #   cron: "0 0 * * 0"
      ## Remove outdated repository archives
      # repository_archive_cache_worker:
      #   cron: "0 * * * *"
      ## Verify custom GitLab Pages domains
      # pages_domain_verification_cron_worker:
      #   cron: "*/15 * * * *"
      ## Export pseudonymized data
      # pseudonymizer_worker:
      #   cron: "0 * * * *"
      # schedule_migrate_external_diffs_worker:
      #   cron: "15 * * * *"
      ### GitLab Geo
      # Geo Primary only!
      # geo_prune_event_log_worker:
      #   cron: "*/5 * * * *"
      ## GitLab Geo repository sync worker
      # geo_repository_sync_worker:
      #   cron: "*/5 * * * *"
      ## GitLab Geo file download dispatch worker
      # geo_file_download_dispatch_worker:
      #  cron: "*/10 * * * *"
      ## GitLab Geo repository verification primary batch worker
      # geo_repository_verification_primary_batch_worker:
      #   cron: "*/5 * * * *"
      ## GitLab Geo repository verification secondary scheduler worker
      # geo_repository_verification_secondary_scheduler_worker:
      #   cron: "*/5 * * * *"
      ## GitLab Geo migrated local files clean up worker
      # geo_migrated_local_files_clean_up_worker:
      #   cron: "15 */6 * * *"
      ### LDAP
      # ldap_sync_worker:
      #   cron: "30 1 * * *"
      # ldap_group_sync_worker:
      #   cron: "0 * * * *"
      ### Snapshot active user statistics
      # historical_data_worker:
      #   cron: "0 12 * * *"

    ## https://docs.gitlab.com/charts/charts/globals#content-security-policy
    contentSecurityPolicy:
      enabled: false
      report_only: true
      # directives: {}

    ## https://docs.gitlab.com/charts/charts/globals#gravatarlibravatar-settings
    gravatar:
      plainUrl:
      sslUrl:

    ## https://docs.gitlab.com/charts/charts/globals#hooking-analytics-services-to-the-gitlab-instance
    extra:
      googleAnalyticsId:
      matomoUrl:
      matomoSiteId:
      matomoDisableCookies:

    ## https://docs.gitlab.com/charts/charts/globals#lfs-artifacts-uploads-packages-external-mr-diffs
    object_store:
      enabled: false
      proxy_download: true
      storage_options: {}
        # server_side_encryption:
        # server_side_encryption_kms_key_id
      connection: {}
        # secret:
        # key:
    lfs:
      enabled: true
      proxy_download: true
      bucket: ${PROJECT_ID}-git-lfs
      connection:
        secret: gitlab-rails-storage
        key: connection
        # secret:
        # key:
    artifacts:
      enabled: true
      proxy_download: true
      bucket: ${PROJECT_ID}-gitlab-artifacts
      connection:
        secret: gitlab-rails-storage
        key: connection
        # secret:
        # key:
    uploads:
      enabled: true
      proxy_download: true
      bucket: ${PROJECT_ID}-gitlab-uploads
      connection:
        secret: gitlab-rails-storage
        key: connection
        # secret:
        # key:
    packages:
      enabled: true
      proxy_download: true
      bucket: ${PROJECT_ID}-gitlab-packages
      connection:
        secret: gitlab-rails-storage
        key: connection
    externalDiffs:
      enabled: false
      when:
      proxy_download: true
      bucket: gitlab-mr-diffs
      connection:
    terraformState:
      enabled: false
      bucket: gitlab-terraform-state
      connection:
    dependencyProxy:
      enabled: false
      proxy_download: true
      bucket: gitlab-dependency-proxy
      connection:

    ## https://docs.gitlab.com/charts/charts/globals#pseudonymizer-settings
    pseudonymizer:
      configMap:
      bucket: ${PROJECT_ID}-gitlab-pseudo
      connection:
        secret: gitlab-rails-storage
        key: connection
        # secret:
        # key:
    backups:
      bucket: ${PROJECT_ID}-gitlab-backups
      tmpBucket: tmp

    ## https://docs.gitlab.com/charts/charts/globals#incoming-email-settings
    ## https://docs.gitlab.com/charts/installation/deployment#incoming-email
    incomingEmail:
      enabled: false
      address: ""
      host: "imap.gmail.com"
      port: 993
      ssl: true
      startTls: false
      user: ""
      password:
        secret: ""
        key: password
      expungeDeleted: false
      logger:
        logPath: "/dev/stdout"
      mailbox: inbox
      idleTimeout: 60
      inboxMethod: "imap"
      clientSecret:
        key: secret
      pollInterval: 60

    ## https://docs.gitlab.com/charts/charts/globals#service-desk-email-settings
    ## https://docs.gitlab.com/charts/installation/deployment#service-desk-email
    serviceDeskEmail:
      enabled: false
      address: ""
      host: "imap.gmail.com"
      port: 993
      ssl: true
      startTls: false
      user: ""
      password:
        secret: ""
        key: password
      expungeDeleted: false
      logger:
        logPath: "/dev/stdout"
      mailbox: inbox
      idleTimeout: 60
      inboxMethod: "imap"
      clientSecret:
        key: secret
      pollInterval: 60

    ## https://docs.gitlab.com/charts/charts/globals#ldap
    ldap:
      # prevent the use of LDAP for sign-in via web.
      preventSignin: false
      servers: {}
      ## 'main' is the GitLab 'provider ID' of this LDAP server
      # main:
      #   label: 'LDAP'
      #   host: '_your_ldap_server'
      #   port: 636
      #   uid: 'sAMAccountName'
      #   bind_dn: '_the_full_dn_of_the_user_you_will_bind_with'
      #   password:
      #     secret: _the_secret_containing_your_ldap_password
      #     key: _the_key_which_holds_your_ldap_password
      #   encryption: 'plain'

    ## https://docs.gitlab.com/charts/charts/globals#kas
    gitlab_kas: {}
      # secret:
      # key:
      # enabled:
      # externalUrl:
      # internalUrl:

    ## https://docs.gitlab.com/charts/charts/globals#omniauth
    omniauth:
      enabled: false
      autoSignInWithProvider:
      syncProfileFromProvider: []
      syncProfileAttributes: ['email']
      allowSingleSignOn: ['saml']
      blockAutoCreatedUsers: true
      autoLinkLdapUser: false
      autoLinkSamlUser: false
      autoLinkUser: []
      externalProviders: []
      allowBypassTwoFactor: []
      providers: []
      # - secret: gitlab-google-oauth2
      #   key: provider
    ## https://docs.gitlab.com/charts/charts/globals#configure-appconfig-settings
    sentry:
      enabled: false
      dsn:
      clientside_dsn:
      environment:

    smartcard:
      enabled: false
      CASecret:
      clientCertificateRequiredHost:
      sanExtensions: false
      requiredForGitAccess: false

    sidekiq:
      routingRules: []

    # Config that only applies to the defaults on initial install
    initialDefaults: {}
      # signupEnabled:
  ## End of global.appConfig

  oauth:
    gitlab-pages: {}
      # secret:
      # appIdKey:
      # appSecretKey:
      # redirectUri:

  ## https://docs.gitlab.com/charts/advanced/geo/
  geo:
    enabled: false
    # Valid values: primary, secondary
    role: primary
    ## Geo Secondary only
    # nodeName allows multiple instances behind a load balancer.
    nodeName: # defaults to `gitlab.gitlab.host`
    # PostgreSQL connection details only needed for `secondary`
    psql:
      password: {}
        # secret:
        # key:
      # host: postgresql.hostedsomewhere.else
      # port: 123
      # username: gitlab_replicator
      # database: gitlabhq_geo_production
      # ssl:
        # secret:
        # clientKey:
        # clientCertificate:
        # serverCA:
    registry:
      enabled: true
      replication:
        enabled: false
        primaryApiUrl:
        storage:
          secret: gitlab-registry-storage
          key: storage
          extraKey: gcs.json
        ## Consumes global.registry.notificationSecret

  ## https://docs.gitlab.com/charts/charts/gitlab/kas/
  kas:
    enabled: false

  ## https://docs.gitlab.com/charts/charts/globals#configure-gitlab-shell-settings
  shell:
    authToken: {}
      # secret:
      # key:
    hostKeys: {}
      # secret:
    ## https://docs.gitlab.com/charts/charts/globals#tcp-proxy-protocol
    tcp:
      proxyProtocol: false

  ## Rails application secrets
  ## Secret created according to https://docs.gitlab.com/charts/installation/secrets#gitlab-rails-secret
  ## If allowing shared-secrets generation, this is OPTIONAL.
  railsSecrets: {}
    # secret:

  ## Rails generic setting, applicable to all Rails-based containers
  rails:
    bootsnap: # Enable / disable Shopify/Bootsnap cache
      enabled: true

  ## https://docs.gitlab.com/charts/charts/globals#configure-registry-settings
  registry:
    bucket: registry
    certificate: {}
      # secret:
    httpSecret: {}
      # secret:
      # key:
    notificationSecret: {}
      # secret:
      # key:
    # https://docs.docker.com/registry/notifications/#configuration
    notifications: {}
      # endpoints:
      #   - name: FooListener
      #     url: https://foolistener.com/event
      #     timeout: 500ms
      #     threshold: 10
      #     backoff: 1s
      #     headers:
      #       FooBar: ['1', '2']
      #       Authorization:
      #         secret: gitlab-registry-authorization-header
      #       SpecificPassword:
      #         secret: gitlab-registry-specific-password
      #         key: password
      # events: {}
    storage:
      secret: gitlab-registry-storage
      key: storage
      extraKey: gcs.json

  pages:
    enabled: false
    accessControl: false
    path:
    host:
    port:
    https: # default true
    externalHttp: []
    externalHttps: []
    artifactsServer: true
    objectStore:
      enabled: true
      bucket: gitlab-pages
      # proxy_download: true
      connection: {}
        # secret:
        # key:
    apiSecret: {}
      # secret:
      # key:
    authSecret: {}
      # secret:
      # key:

  ## GitLab Runner
  ## Secret created according to https://docs.gitlab.com/charts/installation/secrets#gitlab-runner-secret
  ## If allowing shared-secrets generation, this is OPTIONAL.
  runner:
    registrationToken: {}
      # secret:

  ## https://docs.gitlab.com/charts/installation/deployment#outgoing-email
  ## Outgoing email server settings
  smtp:
    enabled: false
    address: smtp.mailgun.org
    port: 2525
    user_name: ""
    ## https://docs.gitlab.com/charts/installation/secrets#smtp-password
    password:
      secret: ""
      key: password
    # domain:
    authentication: "plain"
    starttls_auto: false
    openssl_verify_mode: "peer"
    pool: false

  ## https://docs.gitlab.com/charts/installation/deployment#outgoing-email
  ## Email persona used in email sent by GitLab
  email:
    from: ''
    display_name: GitLab
    reply_to: ''
    subject_suffix: ''
    smime:
      enabled: false
      secretName: ""
      keyName: "tls.key"
      certName: "tls.crt"

  ## Timezone for containers.
  time_zone: UTC

  ## Global Service Annotations and Labels
  service:
    labels: {}
    annotations: {}

  ## Global Deployment Annotations
  deployment:
    annotations: {}

  antiAffinity: soft

  ## https://docs.gitlab.com/charts/charts/globals#workhorse
  ## Global settings related to Workhorse
  workhorse:
    serviceName: webservice-default
    # scheme:
    # host:
    # port:
    ## https://docs.gitlab.com/charts/installation/secrets#gitlab-workhorse-secret
    # secret:
    # key:

  ## https://docs.gitlab.com/charts/charts/globals#configure-webservice
  webservice:
    workerTimeout: 60

  ## https://docs.gitlab.com/charts/charts/globals#custom-certificate-authorities
  # configuration of certificates container & custom CA injection
  certificates:
    image:
      repository: registry.gitlab.com/gitlab-org/build/cng/alpine-certificates
      tag: 20191127-r2
    customCAs: []
    # - secret: custom-CA
    # - secret: more-custom-CAs

  ## kubectl image used by hooks to carry out specific jobs
  kubectl:
    image:
      repository: registry.gitlab.com/gitlab-org/build/cng/kubectl
      tag: 1.13.12
      pullSecrets: []
    securityContext:
      # in most base images, this is `nobody:nogroup`
      runAsUser: 65534
      fsGroup: 65534
  busybox:
    image:
      repository: busybox
      tag: latest

  ## https://docs.gitlab.com/charts/charts/globals#service-accounts
  serviceAccount:
    enabled: false
    create: true
    annotations: {}
    ## Name to be used for serviceAccount, otherwise defaults to chart fullname
    # name:

  ## https://docs.gitlab.com/charts/charts/globals/tracing#tracing
  tracing:
    connection:
      string: ""
    urlTemplate: ""

  ## https://docs.gitlab.com/charts/charts/globals
  extraEnv: {}
   # SOME_KEY: some_value
   # SOME_OTHER_KEY: some_other_value

## End of global

upgradeCheck:
  enabled: true
  image: {}
    # repository:
    # tag:
  securityContext:
    # in alpine/debian/busybox based images, this is `nobody:nogroup`
    runAsUser: 65534
    fsGroup: 65534
  tolerations: []
  resources:
    requests:
      cpu: 50m

## Settings to for the Let's Encrypt ACME Issuer
# certmanager-issuer:
#   # The email address to register certificates requested from Let's Encrypt.
#   # Required if using Let's Encrypt.
#   email: email@example.com
certmanager-issuer:
  email: ${CERT_MANAGER_EMAIL}

## Installation & configuration of jetstack/cert-manager
## See requirements.yaml for current version
certmanager:
  createCustomResource: true
  nameOverride: cert-manager
  # Install cert-manager chart. Set to false if you already have cert-manager
  # installed or if you are not using cert-manager.
  install: true
  # Other cert-manager configurations from upstream
  # See https://github.com/jetstack/cert-manager/blob/master/deploy/charts/cert-manager/README#configuration
  rbac:
    create: true
  webhook:
    enabled: false

## https://docs.gitlab.com/charts/charts/nginx/
## https://docs.gitlab.com/charts/architecture/decisions#nginx-ingress
## Installation & configuration of charts/ingress-nginx:
nginx-ingress:
  enabled: true
  tcpExternalConfig: "true"
  controller:
    addHeaders:
      Referrer-Policy: strict-origin-when-cross-origin
    config:
      hsts: "false"
      hsts-include-subdomains: "false"
      server-name-hash-bucket-size: "256"
      use-http2: "true"
      ssl-ciphers: "ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-SHA:AES256-GCM-SHA384:AES128-GCM-SHA256:AES256-SHA256:AES128-SHA256:AES256-SHA:AES128-SHA:!aNULL:!eNULL:!EXPORT:!DES:!MD5:!PSK:!RC4"
      ssl-protocols: "TLSv1.3 TLSv1.2"
      server-tokens: "false"
    service:
      externalTrafficPolicy: "Local"
    resources:
      requests:
        cpu: 100m
        memory: 100Mi
    publishService:
      enabled: true
    replicaCount: 2
    minAvailable: 1
    scope:
      enabled: true
    metrics:
      enabled: true
      service:
        annotations:
          gitlab.com/prometheus_scrape: "true"
          gitlab.com/prometheus_port: "10254"
          prometheus.io/scrape: "true"
          prometheus.io/port: "10254"
    admissionWebhooks:
      enabled: false
  defaultBackend:
    enabled: true
    minAvailable: 1
    replicaCount: 1
    resources:
      requests:
        cpu: 5m
        memory: 5Mi
  rbac:
    create: true
    scope: true
  serviceAccount:
    create: true

## Installation & configuration of stable/prometheus
## See requirements.yaml for current version
prometheus:
  install: false
  # rbac:
  #   create: true
  # alertmanager:
  #   enabled: false
  # alertmanagerFiles:
  #   alertmanager.yml: {}
  # kubeStateMetrics:
  #   enabled: false
  # nodeExporter:
  #   enabled: false
  # pushgateway:
  #   enabled: false
  # server:
  #   retention: 15d
  #   strategy:
  #     type: Recreate
  #
  serverFiles:
    prometheus.yml:
      scrape_configs:
        - job_name: prometheus
          static_configs:
            - targets:
              - localhost:9090
        - job_name: 'kubernetes-apiservers'
          kubernetes_sd_configs:
            - role: endpoints
          scheme: https
          tls_config:
            ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
            insecure_skip_verify: true
          bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
          relabel_configs:
            - source_labels: [__meta_kubernetes_namespace, __meta_kubernetes_service_name, __meta_kubernetes_endpoint_port_name]
              action: keep
              regex: default;kubernetes;https
        - job_name: 'kubernetes-pods'
          kubernetes_sd_configs:
            - role: pod
          relabel_configs:
            - source_labels: [__meta_kubernetes_pod_annotation_gitlab_com_prometheus_scrape]
              action: keep
              regex: true
            - source_labels: [__meta_kubernetes_pod_annotation_gitlab_com_prometheus_path]
              action: replace
              target_label: __metrics_path__
              regex: (.+)
            - source_labels: [__address__, __meta_kubernetes_pod_annotation_gitlab_com_prometheus_port]
              action: replace
              regex: ([^:]+)(?::\d+)?;(\d+)
              replacement: $1:$2
              target_label: __address__
            - action: labelmap
              regex: __meta_kubernetes_pod_label_(.+)
            - source_labels: [__meta_kubernetes_namespace]
              action: replace
              target_label: kubernetes_namespace
            - source_labels: [__meta_kubernetes_pod_name]
              action: replace
              target_label: kubernetes_pod_name
        - job_name: 'kubernetes-service-endpoints'
          kubernetes_sd_configs:
            - role: endpoints
          relabel_configs:
            - action: keep
              regex: true
              source_labels:
                - __meta_kubernetes_service_annotation_gitlab_com_prometheus_scrape
            - action: replace
              regex: (https?)
              source_labels:
                - __meta_kubernetes_service_annotation_gitlab_com_prometheus_scheme
              target_label: __scheme__
            - action: replace
              regex: (.+)
              source_labels:
                - __meta_kubernetes_service_annotation_gitlab_com_prometheus_path
              target_label: __metrics_path__
            - action: replace
              regex: ([^:]+)(?::\d+)?;(\d+)
              replacement: $1:$2
              source_labels:
                - __address__
                - __meta_kubernetes_service_annotation_gitlab_com_prometheus_port
              target_label: __address__
            - action: labelmap
              regex: __meta_kubernetes_service_label_(.+)
            - action: replace
              source_labels:
                - __meta_kubernetes_namespace
              target_label: kubernetes_namespace
            - action: replace
              source_labels:
                - __meta_kubernetes_service_name
              target_label: kubernetes_name
            - action: replace
              source_labels:
                - __meta_kubernetes_pod_node_name
              target_label: kubernetes_node
        - job_name: 'kubernetes-services'
          metrics_path: /probe
          params:
            module: [http_2xx]
          kubernetes_sd_configs:
            - role: service
          relabel_configs:
            - source_labels: [__meta_kubernetes_service_annotation_gitlab_com_prometheus_probe]
              action: keep
              regex: true
            - source_labels: [__address__]
              target_label: __param_target
            - target_label: __address__
              replacement: blackbox
            - source_labels: [__param_target]
              target_label: instance
            - action: labelmap
              regex: __meta_kubernetes_service_label_(.+)
            - source_labels: [__meta_kubernetes_namespace]
              target_label: kubernetes_namespace
            - source_labels: [__meta_kubernetes_service_name]
              target_label: kubernetes_name

## Configuration of Redis
## https://docs.gitlab.com/charts/architecture/decisions#redis
## https://docs.gitlab.com/charts/installation/deployment.html#redis
redis:
  install: false
  existingSecret: gitlab-redis-secret
  existingSecretKey: redis-password
  usePasswordFile: true
  cluster:
   enabled: false
  metrics:
   enabled: true

## Installation & configuration of stable/prostgresql
## See requirements.yaml for current version
postgresql:
  # postgresqlUsername: gitlab
  # This just needs to be set. It will use a second entry in existingSecret for postgresql-postgres-password
  # postgresqlPostgresPassword: bogus
  install: false
  # postgresqlDatabase: gitlabhq_production
  # image:
  #   tag: 12.7.0
  # usePasswordFile: true
  # existingSecret: 'bogus'
  # initdbScriptsConfigMap: 'bogus'
  # master:
  #   extraVolumeMounts:
  #     - name: custom-init-scripts
  #       mountPath: /docker-entrypoint-preinitdb.d/init_revision.sh
  #       subPath: init_revision.sh
  #   podAnnotations:
  #     postgresql.gitlab/init-revision: "1"
  # metrics:
  #   enabled: true
    ## Optionally define additional custom metrics
    ## ref: https://github.com/wrouesnel/postgres_exporter#adding-new-metrics-via-a-config-file

## Installation & configuration charts/registry
## https://docs.gitlab.com/charts/architecture/decisions#registry
## https://docs.gitlab.com/charts/charts/registry/
# registry:
#   enabled: false


## Automatic shared secret generation
## https://docs.gitlab.com/charts/installation/secrets
## https://docs.gitlab.com/charts/charts/shared-secrets
shared-secrets:
  enabled: true
  rbac:
    create: true
  selfsign:
    image:
      repository: registry.gitlab.com/gitlab-org/build/cng/cfssl-self-sign
      tag: 1.2
    keyAlgorithm: "rsa"
    keySize: "4096"
    expiry: "365d"
    caSubject: "GitLab Helm Chart"
    pullSecrets: []
  env: production
  serviceAccount:
    create: true
    name: # Specify a pre-existing ServiceAccount name
  resources:
    requests:
      cpu: 50m
  securityContext:
    # in debian/alpine based images, this is `nobody:nogroup`
    runAsUser: 65534
    fsGroup: 65534
  tolerations: []
  podLabels: {}
  annotations: {}

## Installation & configuration of gitlab/gitlab-runner
## See requirements.yaml for current version
gitlab-runner:
  install: ${GITLAB_RUNNER_INSTALL}
  rbac:
    create: true
  runners:
    locked: false
    cache:
      cacheType: gcs
      gcsBucketname: ${PROJECT_ID}-runner-cache
      secretName: google-application-credentials
      cacheShared: true
    # config: |
    #   [[runners]]
    #     [runners.kubernetes]
    #     image = "ubuntu:18.04"
    #     {{- if .Values.global.minio.enabled }}
    #     [runners.cache]
    #       Type = "s3"
    #       Path = "gitlab-runner"
    #       Shared = true
    #       [runners.cache.s3]
    #         ServerAddress = {{ include "gitlab-runner.cache-tpl.s3ServerAddress" . }}
    #         BucketName = "runner-cache"
    #         BucketLocation = "us-east-1"
    #         Insecure = false
    #     {{ end }}
  podAnnotations:
    gitlab.com/prometheus_scrape: "true"
    gitlab.com/prometheus_port: 9252

## Installation & configuration of stable/grafana
## See requirements.yaml for current version
## Controlled by `global.grafana.enabled`
grafana:
  ## Override and provide "bogus" administation secrets
  ## gitlab/gitlab-grafana provides overrides via shared-secrets
  nameOverride: grafana-app
  admin:
    existingSecret: bogus
  env:
    GF_SECURITY_ADMIN_USER: bogus
    GF_SECURITY_ADMIN_PASSWORD: bogus
  ## This override allows gitlab/gitlab-grafana to completely override the secret
  ##   handling behavior of the upstream chart in combination with the above.
  command: [ "sh", "-x", "/tmp/scripts/import-secret.sh" ]
  ## The following settings allow Grafana to dynamically create
  ## dashboards and datasources from configmaps. See
  ## https://artifacthub.io/packages/helm/grafana/grafana#sidecar-for-dashboards
  sidecar:
    dashboards:
      enabled: true
      label: gitlab_grafana_dashboard
    datasources:
      enabled: true
      label: gitlab_grafana_datasource
  ## We host Grafana as a sub-url of GitLab
  grafana.ini:
    server:
      serve_from_sub_path: true
      root_url: http://localhost/-/grafana/
    auth:
      login_cookie_name: gitlab_grafana_session
  ## We generate and provide random passwords
  ## NOTE: the Secret & ConfigMap names are hard coded!
  extraSecretMounts:
    - name: initial-password
      mountPath: /tmp/initial
      readOnly: true
      secretName: gitlab-grafana-initial-password
      defaultMode: 400
  extraConfigmapMounts:
    - name: import-secret
      mountPath: /tmp/scripts
      configMap: gitlab-grafana-import-secret
      readOnly: true
  testFramework:
    enabled: false

## Settings for individual sub-charts under GitLab
## Note: Many of these settings are configurable via globals
gitlab:
  ## https://docs.gitlab.com/charts/charts/gitlab/task-runner
  task-runner:
    replicas: 1
    antiAffinityLabels:
      matchLabels:
        app: 'gitaly'
## https://docs.gitlab.com/charts/charts/gitlab/migrations
  migrations:
    enabled: true
## https://docs.gitlab.com/charts/charts/gitlab/webservice
#  webservice:
#    enabled: true
## https://docs.gitlab.com/charts/charts/gitlab/sidekiq
#  sidekiq:
#    enabled: true
## https://docs.gitlab.com/charts/charts/gitlab/gitaly
  gitaly:
    persistence:
      size: 200Gi
      storageClass: "pd-ssd"
## https://docs.gitlab.com/charts/charts/gitlab/gitlab-shell
  gitlab-shell:
    enabled: true
## https://docs.gitlab.com/charts/charts/gitlab/gitlab-grafana
  gitlab-grafana:
