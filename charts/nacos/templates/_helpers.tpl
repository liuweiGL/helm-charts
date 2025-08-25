{{- define "nacos.image" -}}
    {{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{- define "nacos.imagePullSecrets" -}}
    {{ include "common.images.pullSecrets" (dict (list .Values.image) "global" .Values.global) }}
{{- end -}}

{{- define "nacos.mode" -}}
    {{ .Values.mode | default "standalone" }}
{{- end -}}

{{- define "nacos.configMapNames.auth" -}}
    {{ printf "%s-%s" (include "common.names.fullname" .) "auth" }}
{{- end -}}

{{- define "nacos.configMapNames.db" -}}
    {{ printf "%s-%s" (include "common.names.fullname" .) "db" }}
{{- end -}}

{{- define "nacos.configMapNames.jvm" -}}
    {{ printf "%s-%s" (include "common.names.fullname" .) "jvm" }}
{{- end -}}

{{- define "nacos.configMapNames.app" -}}
    {{ printf "%s-%s" (include "common.names.fullname" .) "app" }}
{{- end -}}

{{- define "nacos.ingress.tlsSecretName" -}}
    {{- if .Values.ingress.existingSecret -}}
        {{- printf "%s" (tpl .Values.ingress.existingSecret $) -}}
    {{- else -}}
        {{- printf "%s-tls" .Values.ingress.hostname -}}
    {{- end -}}
{{- end -}}
