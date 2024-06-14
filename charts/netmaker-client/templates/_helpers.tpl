{{- define "netmaker.client.image" -}}
    {{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{- define "netmaker.client.imagePullSecrets" -}}
    {{- include "common.images.renderPullSecrets" (dict "images" (list .Values.image) "context" $) -}}
{{- end -}}