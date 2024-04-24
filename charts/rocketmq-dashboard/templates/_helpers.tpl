{{- define "dashboard.image" -}}
    {{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{- define "dashboard.imagePullSecrets" -}}
    {{- include "common.images.pullSecrets" (dict "images" (list .Values.image) "global" .Values.global) -}}
{{- end -}}

{{- define "dashboard.dataPath" -}}
    {{ .Values.dataPath | default "/opt/rocketmq-dashboard/data" }}
{{- end -}}

{{- define "dashboard.auth.createConfigMap" -}}
    {{- if and (not .Values.auth.existingConfigMap) .Values.auth.enabled -}}
        {{- true -}}
    {{- end -}}
{{- end -}}

{{- define "dashboard.auth.configMapName" -}}
    {{- if .Values.auth.existingConfigMap -}}
        {{- printf "%s" .Values.auth.existingConfigMap | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
        {{- printf "%s-%s" (include "common.names.fullname" .) "auth" -}}
    {{- end -}}
{{- end -}}

{{- define "dashboard.app.configMapName" -}}
    {{- printf "%s-%s" (include "common.names.fullname" .) "app" -}}
{{- end -}}

{{- define "dashboard.rocketmq.namesrvAddrs" -}}
    {{- if .Values.rocketmq.namesrvAddrs -}}
         {{- join ";" .Values.rocketmq.namesrvAddrs }}
    {{- end -}}
{{- end -}}

{{- define "rocketmq.acl.createSecret" -}}
    {{- if and (not .Values.rocketmq.existingSecret) (and .Values.rocketmq.accessKey .Values.rocketmq.secretKey) -}}
        {{- true -}}
    {{- end -}}
{{- end -}}

{{- define "rocketmq.acl.secretExists" -}}
    {{- if or (.Values.rocketmq.existingSecret) (and .Values.rocketmq.accessKey .Values.rocketmq.secretKey) -}}
        {{- true -}}
    {{- end -}}
{{- end -}}

{{- define "rocketmq.acl.secretName" -}}
    {{- if .Values.rocketmq.existingSecret -}}
        {{- printf "%s" .Values.rocketmq.existingSecret | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
        {{- printf "%s-%s" (include "common.names.fullname" .) "acl" -}}
    {{- end -}}
{{- end -}}

