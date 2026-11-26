{{- define "nacos.image" -}}
    {{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{- define "nacos.imagePullSecrets" -}}
    {{ include "common.images.pullSecrets" (dict (list .Values.image) "global" .Values.global) }}
{{- end -}}

{{- define "nacos.functionMode" -}}
    {{- $functionMode := .Values.functionMode | default "all" -}}
    {{- if not (has $functionMode (list "all" "config" "naming" "microservice" "ai")) -}}
        {{- fail (printf "functionMode: 不支持的取值 %q，可选 all/config/naming/microservice/ai" $functionMode) -}}
    {{- end -}}
    {{- $functionMode -}}
{{- end -}}

{{- define "nacos.ingress.tlsSecretName" -}}
    {{- if .Values.ingress.existingSecret -}}
        {{- printf "%s" (tpl .Values.ingress.existingSecret $) -}}
    {{- else -}}
        {{- printf "%s-tls" .Values.ingress.hostname -}}
    {{- end -}}
{{- end -}}
