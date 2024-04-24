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


{{- define "rocketmq.broker.fullname" -}}
    {{- $name := .Values.broker.name | default "broker" -}}
    {{- printf "%s-%s" (include "common.names.fullname" .) $name  | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return true if a configMap object should be created for RocketMQ broker
*/}}
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




{{- define "rocketmq.broker.configVolumeMounts" -}}
    {{- $prefixPath := .path }}
    {{- with .context -}}
    {{- $name := include "rocketmq.broker.fullname" . }}
    {{- $replicaCount := .Values.broker.replicaCount | int }}
    {{- range $index := until $replicaCount -}}
        {{- $brokerName := printf "%s-%d" $name $index -}}
- name: config
  mountPath:  {{ printf "%s%s.conf" $prefixPath $brokerName }}
  subPath: {{ printf "%s.conf" $brokerName }}
    {{- end -}} 
    {{- end -}}
{{- end -}}