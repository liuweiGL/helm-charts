{{- define "netmaker.server.image" -}}
    {{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{- define "netmaker.server.imagePullSecrets" -}}
    {{- include "common.images.renderPullSecrets" (dict "images" (list .Values.image) "context" $) -}}
{{- end -}}

{{- define "netmaker.server.envConfigMapName" -}}
    {{ printf "%s-env" (include "common.names.fullname" .) }}
{{- end -}}

{{- define "netmaker.server.hostname" -}}
    {{- .Values.core.apiDomain }}
{{- end -}}

{{- define "netmaker.mosquitto.hostname" -}}
    {{- .Values.core.mqDomain }}
{{- end -}}

{{- define "netmaker.dashboard.hostname" -}}
    {{- index .Values "netmaker-dashboard" "ingress.hostname" }}
{{- end -}}

{{- define "netmaker.dashboard.fullname" -}}
    {{- if index .Values "netmaker-dashboard" "fullnameOverride" }}
        {{- index .Values "netmaker-dashboard" "fullnameOverride" }}
    {{- else -}}
       {{- printf "%s-%s" (include "common.names.fullname" .) (default "netmaker-dashboard" (index .Values "netmaker-dashboard" "fullname")) }}
    {{- end -}}
{{- end -}}

{{- define "netmaker.mosquitto.fullname" -}}
    {{- if .Values.mosquitto.fullnameOverride }}
        {{- .Values.mosquitto.fullnameOverride }}
    {{- else -}}
       {{- printf "%s-%s" (include "common.names.fullname" .) (default "mosquitto" .Values.mosquitto.nameOverride) }}
    {{- end -}}
{{- end -}}

{{- define "netmaker.postgresql.fullname" -}}
    {{- if .Values.postgresql.fullnameOverride }}
        {{- .Values.postgresql.fullnameOverride }}
    {{- else -}}
        {{- printf "%s-%s" (include "common.names.fullname" .) (default "postgresql" .Values.postgresql.nameOverride) }}
    {{- end -}}
{{- end -}}

{{- define "netmaker.dashboard.dns" -}}
    {{- printf "%s.%s.svc.cluster.local" (include "netmaker.dashboard.fullname" .) (include "common.names.namespace" .) }}
{{- end -}}

{{- define "netmaker.mosquitto.dns" -}}
    {{- printf "%s-mqtt.%s.svc.cluster.local" (include "netmaker.mosquitto.fullname" .) (include "common.names.namespace" .) }}
{{- end -}}

{{- define "netmaker.postgresql.dns" -}}
    {{- printf "%s.%s.svc.cluster.local" (include "netmaker.postgresql.fullname" .) (include "common.names.namespace" .) }}
{{- end -}}

{{- define "netmaker.dashboard.address" -}}
    {{- $ingress := index .Values "netmaker-dashboard" "ingress" }}
    {{- $service := index .Values "netmaker-dashboard" "service" }}
    {{- if $ingress.enabled -}}
        {{- printf "%s://%s"  ($ingress.tls | ternary "https" "http") (include "netmaker.dashboard.hostname" .) }}
    {{- else if eq .Values.service.type "NodePort" -}}
        {{- printf "http://%s:%s" (include "netmaker.dashboard.hostname" .) $service.nodePorts.http }}
    {{- else -}}
        {{- printf "http://%s:%s" (include "netmaker.dashboard.dns" .)  $service.ports.http }}
    {{- end -}}
{{- end -}}

{{- define "netmaker.server.database" -}}
    {{- if .Values.global.postgresqlEnabled -}}
DATABASE: "postgres"
SQL_HOST: {{ include "netmaker.postgresql.dns" . }}
SQL_PORT: {{ (default 5432 .Values.postgresql.primary.service.ports.postgresql) | quote}}
SQL_DB: {{  .Values.postgresql.auth.database | quote }}
SQL_USER: {{ .Values.postgresql.auth.username | quote }}
SQL_PASS: {{ .Values.postgresql.auth.password | quote }}
    {{- else -}}
DATABASE: {{ .Values.externalDatabase.type | quote }}
SQL_HOST: {{ .Values.externalDatabase.host | quote }}
SQL_PORT: {{ .Values.externalDatabase.port | quote }}
SQL_DB: {{  .Values.externalDatabase.database | quote }}
SQL_USER: {{ .Values.externalDatabase.username | quote }}
SQL_PASS: {{ .Values.externalDatabase.password | quote }}
    {{- end -}}
{{- end -}}


{{- define "netmaker.server.configuration" -}}
SERVER_NAME: {{ required "A valid .Values.baseDomain entry required!" .Values.core.baseDomain | quote }}
SERVER_API_CONN_STRING: {{ printf "%s:%s" (include "netmaker.server.hostname" .) "443" | quote }}
SERVER_HTTP_HOST: {{ include "netmaker.server.hostname" . | quote }}
API_PORT: {{ .Values.containerPorts.http | quote }}
FRONTEND_URL: {{ include "netmaker.dashboard.address" . | quote }}

# 客户端使用的 mq 地址
BROKER_ENDPOINT: "mqtt://{{ include "netmaker.mosquitto.hostname" . }}:{{ .Values.mosquitto.service.nodePorts.mqtt }}"
# 服务端使用的 mq 地址
SERVER_BROKER_ENDPOINT: "mqtt://{{ include "netmaker.mosquitto.dns" . }}:{{ default 1883 .Values.mosquitto.service.ports.mqtt }}"
MQ_USERNAME: {{ .Values.mosquitto.auth.username | quote }}
MQ_PASSWORD: {{ .Values.mosquitto.auth.password | quote }}
MASTER_KEY: {{ default (randAlphaNum 16)  .Values.core.masterKey | quote }}
STUN_LIST: {{ join "," .Values.core.stunList | quote }}

DNS_MODE: "off"
DISPLAY_KEYS: "off"
CORS_ALLOWED_ORIGIN: "*"

JWT_VALIDITY_DURATION: {{ .Values.core.jwtDuration | quote }}
RAC_AUTO_DISABLE: {{ .Values.core.racAutoDisable | quote }}
CACHING_ENABLED: "false"
AUTH_PROVIDER: {{ .Values.core.authProvider | quote }}
CLIENT_ID: {{ .Values.core.oAuthClientID | quote }}
CLIENT_SECRET: {{ .Values.core.oAuthClientSecret | quote }}
AZURE_TENANT: {{ .Values.core.azureTenant | quote }}
OIDC_ISSUER: {{ .Values.core.oidcIssuer | quote }}
VERBOSITY: {{ .Values.image.debug | ternary "1" "0" | quote }}

LICENSE_KEY: {{ .Values.core.ee.licensekey | quote }}
NETMAKER_TENANT_ID: {{ .Values.core.ee.tenantId | quote }}

{{ include "netmaker.server.database" . }}
{{- end -}}