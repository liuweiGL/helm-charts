{{- define "rocketmq.acl.createSecret" -}}
    {{- if and (not .Values.rocketmq.existingAccessSecret) (and .Values.rocketmq.accessKey .Values.rocketmq.secretKey) -}}
        {{- true -}}
    {{- end -}}
{{- end -}}

{{- define "rocketmq.acl.secretExisted" -}}
    {{- if or (.Values.rocketmq.existingAccessSecret) (and .Values.rocketmq.accessKey .Values.rocketmq.secretKey) -}}
        {{- true -}}
    {{- end -}}
{{- end -}}

{{- define "rocketmq.acl.secretName" -}}
    {{- if .Values.rocketmq.existingAccessSecret -}}
        {{- printf "%s" .Values.rocketmq.existingAccessSecret | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
        {{- printf "%s-%s" (include "common.names.fullname" .) "acl" -}}
    {{- end -}}
{{- end -}}