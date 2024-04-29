{{- define "self-service-password.image" -}}
    {{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{- define "self-service-password.imagePullSecrets" -}}
    {{- include "common.images.pullSecrets" (dict "images" (list .Values.image) "global" .Values.global) }}
{{- end -}}

{{- define "self-service-password.createConfigMap" -}}
    {{- if not .Values.existingConfigMap -}}
        {{- true -}}
    {{- end -}}
{{- end -}}

{{- define "self-service-password.configMapName" -}}
    {{- if .Values.existingConfigMap -}}
        {{- printf "%s" .Values.existingConfigMap | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
        {{- include "common.names.fullname" . -}}
    {{- end -}}
{{- end -}}