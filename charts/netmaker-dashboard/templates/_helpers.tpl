{{- define "netmaker.dashboard.image" -}}
    {{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{- define "netmaker.dashboard.imagePullSecrets" -}}
    {{- include "common.images.renderPullSecrets" (dict "images" (list .Values.image) "context" $) -}}
{{- end -}}
