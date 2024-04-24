{{- define "dashboard.image" -}}
    {{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{- define "dashboard.imagePullSecrets" -}}
    {{- include "common.images.pullSecrets" (dict "images" (list .Values.image) "global" .Values.global) -}}
{{- end -}}


{{- define "dashboard.dataPath" -}}
    {{ .Values.dataPath | default "/opt/rocketmq-dashboard/data" }}
{{- end -}}

{{- define "dashboard.app.configMapName" -}}
    {{- printf "%s-%s" (include "common.names.fullname" .) "app" -}}
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

