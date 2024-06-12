{{- define "cloudcanal.imagePullSecrets" -}}
    {{ include "common.images.pullSecrets" (dict (list .Values.console.image .Values.sidecar.image .Values.mysql.image) "global" .Values.global) }}
{{- end -}}

{{- define "cloudcanal.console.image" -}}
    {{- include "common.images.image" (dict "imageRoot" .Values.console.image "global" .Values.global) }}
{{- end -}}

{{- define "cloudcanal.sidecar.image" -}}
    {{- include "common.images.image" (dict "imageRoot" .Values.sidecar.image "global" .Values.global) }}
{{- end -}}

{{- define "cloudcanal.mysql.image" -}}
    {{- include "common.images.image" (dict "imageRoot" .Values.mysql.image "global" .Values.global) }}
{{- end -}}