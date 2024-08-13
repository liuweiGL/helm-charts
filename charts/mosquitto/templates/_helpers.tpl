{{- define "mosquitto.image" -}}
    {{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{- define "mosquitto.imagePullSecrets" -}}
    {{- include "common.images.renderPullSecrets" (dict "images" (list .Values.image) "context" $) -}}
{{- end -}}

{{- define "mosquitto.pvcName" -}}
    {{ printf "%s-%s" (include "common.names.fullname" .) "pvc"}}
{{- end -}}

{{- define "mosquitto.createAuthSecret" -}}
    {{- if and .Values.auth.enabled (not .Values.auth.existingSecret) }}
        {{- true -}}
    {{- end -}}
{{- end -}}

{{- define "mosquitto.authSecretName" -}}
    {{- if .Values.auth.existingSecret -}}
        {{- printf "%s" (tpl .Values.auth.existingSecret $) -}}
    {{- else -}}
        {{- printf "%s-auth" (include "common.names.fullname" .) -}}
    {{- end -}}
{{- end -}}

{{- define "mosquitto.createTlsSecret" -}}
    {{- if and .Values.tls.enabled .Values.tls.autoGenerated (not .Values.tls.existingSecret) }}
        {{- true -}}
    {{- end -}}
{{- end -}}

{{- define "mosquitto.tlsSecretName" -}}
    {{- if .Values.tls.existingSecret -}}
        {{- printf "%s" (tpl .Values.tls.existingSecret $) -}}
    {{- else -}}
        {{- printf "%s-tls" (include "common.names.fullname" .) -}}
    {{- end -}}
{{- end -}}
