{{- define "rocketmq.dashboard.fullname" -}}
{{- $name := default "dashboard" .Values.dashboard.name -}}
{{- printf "%s-%s" (include "common.names.fullname" .) $name  | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "rocketmq.nameserver.fullname" -}}
{{- $name := default "nameserver" .Values.nameserver.name -}}
{{- printf "%s-%s" (include "common.names.fullname" .) $name  | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return true if a configmap object should be created for RocketMQ nameserver
*/}}
{{- define "rocketmq.nameserver.createConfigmap" -}}
{{- if .Values.nameserver.existingConfigmap }}
    {{- false -}}
{{- else -}}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return the configmap with the RocketMQ nameserver configuration
*/}}
{{- define "rocketmq.nameserver.configmapName" -}}
{{- if .Values.nameserver.existingConfigmap -}}
    {{- printf "%s" (tpl .Values.nameserver.existingConfigmap $) -}}
{{- else -}}
    {{- printf "%s" (include "rocketmq.nameserver.fullname" .) -}}
{{- end -}}
{{- end -}}

{{- define "rocketmq.nameserver.addr" -}}
{{- printf "%s:%g"  (include "rocketmq.nameserver.fullname" .) .Values.nameserver.service.ports.nameserver }}
{{- end -}}


{{- define "rocketmq.broker.fullname" -}}
{{- $name := default "broker" .Values.broker.name -}}
{{- printf "%s-%s" (include "common.names.fullname" .) $name  | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return true if a configmap object should be created for RocketMQ broker
*/}}
{{- define "rocketmq.broker.createConfigmap" -}}
{{- if .Values.nameserver.existingConfigmap }}
    {{- false -}}
{{- else -}}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return the configmap with the RocketMQ broker configuration
*/}}
{{- define "rocketmq.broker.configmapName" -}}
{{- if .Values.broker.existingConfigmap -}}
    {{- printf "%s" (tpl .Values.broker.existingConfigmap $) -}}
{{- else -}}
    {{- printf "%s" (include "rocketmq.broker.fullname" .) -}}
{{- end -}}
{{- end -}}


{{/*
Return the proper RocketMQ image name
*/}}
{{- define "rocketmq.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "rocketmq.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.image) "global" .Values.global) }}
{{- end -}}