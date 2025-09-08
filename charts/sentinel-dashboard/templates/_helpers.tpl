{{- define "dashboard.image" -}}
    {{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{- define "dashboard.imagePullSecrets" -}}
    {{- include "common.images.pullSecrets" (dict "images" (list .Values.image) "global" .Values.global) -}}
{{- end -}}

{{- define "dashboard.config.createConfigMap" -}}
    {{- if not .Values.config.existingConfigMap -}}
        {{- true -}}
    {{- end -}}
{{- end -}}

{{- define "dashboard.config.configMapName" -}}
    {{- if .Values.config.existingConfigMap -}}
        {{- printf "%s" .Values.config.existingConfigMap | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
        {{- printf "%s-%s" (include "common.names.fullname" .) "config" -}}
    {{- end -}}
{{- end -}}

{{- define "dashboard.ingress.tlsSecretName" -}}
    {{- if .Values.ingress.existingSecret -}}
        {{- printf "%s" (tpl .Values.ingress.existingSecret $) -}}
    {{- else -}}
        {{- printf "%s-tls" .Values.ingress.hostname -}}
    {{- end -}}
{{- end -}}