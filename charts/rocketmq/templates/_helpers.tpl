
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

{{- define "rocketmq.namesrv.fullname" -}}
{{- $name := default "namesrv" .Values.namesrv.name -}}
{{- printf "%s-%s" (include "common.names.fullname" .) $name  | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return true if a configmap object should be created for RocketMQ namesrv
*/}}
{{- define "rocketmq.namesrv.createConfigmap" -}}
{{- if .Values.namesrv.existingConfigmap }}
    {{- false -}}
{{- else -}}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return the configmap with the RocketMQ namesrv configuration
*/}}
{{- define "rocketmq.namesrv.configmapName" -}}
{{- if .Values.namesrv.existingConfigmap -}}
    {{- printf "%s" (tpl .Values.namesrv.existingConfigmap $) -}}
{{- else -}}
    {{- printf "%s" (include "rocketmq.namesrv.fullname" .) -}}
{{- end -}}
{{- end -}}

{{- define "rocketmq.namesrv.addr" -}}
{{- printf "%s:%g"  (include "rocketmq.namesrv.fullname" .) .Values.namesrv.service.ports.namesrv }}
{{- end -}}


{{- define "rocketmq.broker.fullname" -}}
{{- $name := default "broker" .Values.broker.name -}}
{{- printf "%s-%s" (include "common.names.fullname" .) $name  | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return true if a configmap object should be created for RocketMQ broker
*/}}
{{- define "rocketmq.broker.createConfigmap" -}}
{{- if .Values.namesrv.existingConfigmap }}
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
