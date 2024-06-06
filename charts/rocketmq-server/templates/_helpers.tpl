{{- define "rocketmq.image" -}}
    {{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{- define "rocketmq.imagePullSecrets" -}}
    {{- include "common.images.pullSecrets" (dict "images" (list .Values.image) "global" .Values.global) }}
{{- end -}}

{{- define "rocketmq.namesrv.fullname" -}}
    {{- $name := default "namesrv" .Values.namesrv.name -}}
    {{- printf "%s-%s" (include "common.names.fullname" .) $name  | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "rocketmq.namesrv.createConfigMap" -}}
    {{- if .Values.namesrv.existingConfigMap }}
        {{- false -}}
    {{- else -}}
        {{- true -}}
    {{- end -}}
{{- end -}}

{{- define "rocketmq.namesrv.configMapName" -}}
    {{- if .Values.namesrv.existingConfigMap -}}
        {{- printf "%s" (tpl .Values.namesrv.existingConfigMap $) -}}
    {{- else -}}
        {{- printf "%s" (include "rocketmq.namesrv.fullname" .) -}}
    {{- end -}}
{{- end -}}

{{- define "rocketmq.namesrv.addr" -}}
    {{- printf "%s:%g"  (include "rocketmq.namesrv.fullname" .) .Values.namesrv.service.ports.namesrv }}
{{- end -}}


{{- define "rocketmq.broker.home" -}}
/opt/rocketmq
{{- end -}}

{{- define "rocketmq.broker.fullname" -}}
    {{- $name := .Values.broker.name | default "broker" -}}
    {{- printf "%s-%s" (include "common.names.fullname" .) $name  | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "rocketmq.broker.createConfigMap" -}}
    {{- if .Values.namesrv.existingConfigMap }}
        {{- false -}}
    {{- else -}}
        {{- true -}}
    {{- end -}}
{{- end -}}

{{- define "rocketmq.broker.configMapName" -}}
    {{- if .Values.broker.existingConfigMap -}}
        {{- printf "%s" (tpl .Values.broker.existingConfigMap $) -}}
    {{- else -}}
        {{- printf "%s" (include "rocketmq.broker.fullname" .) -}}
    {{- end -}}
{{- end -}}


{{- define "rocketmq.broker.plainAclFile" -}}
    {{- if .Values.broker.acl.enabled -}}
        {{- if not (empty .Values.broker.globalWhiteRemoteAddresses) -}}
globalWhiteRemoteAddresses:
            {{- range .Values.broker.globalWhiteRemoteAddresses -}}
  - {{- . | indent 2 }}
            {{- end -}}        
        {{- end -}}
accounts:
  - accessKey: {{- .Values.broker.acl.accessKey | indent 2 }}
    secretKey: {{- .Values.broker.acl.secretKey | indent 2 }}
    admin: true
    {{- end -}}
{{- end -}}

{{- define "rocketmq.broker.toolsFile" -}}
    {{- if .Values.broker.acl.enabled -}}
accessKey: {{ .Values.broker.acl.accessKey }}
secretKey: {{ .Values.broker.acl.secretKey }}
    {{- end -}}
{{- end -}}

{{- define "rocketmq.broker.listenPort" -}}
    {{- if eq .Values.namesrv.service.type "NodePort" }}
        {{- add .Values.namesrv.service.nodePorts.namesrv 1 }}
    {{- else -}}
        {{- 10911 -}}
    {{- end -}}
{{- end -}}

{{- define "rocketmq.broker.haListenPort" -}}
    {{-  add (include "rocketmq.broker.listenPort" .) 1 }}
{{- end -}}

{{- define "rocketmq.broker.fastListenPort" -}}
    {{- sub (include "rocketmq.broker.listenPort" .) 2 }}
{{- end -}}
