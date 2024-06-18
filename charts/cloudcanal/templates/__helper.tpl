{{- define "cloudcanal.imagePullSecrets" -}}
    {{ include "common.images.pullSecrets" (dict (list .Values.console.image .Values.sidecar.image .Values.mysql.image) "global" .Values.global) }}
{{- end -}}


{{- define "cloudcanal.console.image" -}}
    {{- include "common.images.image" (dict "imageRoot" .Values.console.image "global" .Values.global) }}
{{- end -}}

{{- define "cloudcanal.console.fullname" -}}
    {{ printf "%s-%s" (include "common.names.fullname" .) "console" }}
{{- end }}

{{- define "cloudcanal.console.configMapName" -}}
    {{- printf "%s-%s" (include "common.names.fullname" .) "console-config" }}
{{- end -}}

{{- define "cloudcanal.console.serviceName" -}}
    {{- printf "%s-%s" (include "common.names.fullname" .) "console" }}
{{- end -}}

{{- define "cloudcanal.console.internalAddress" -}}
    {{- printf "%s:%d" (include "cloudcanal.console.serviceName" .) (int .Values.console.service.ports.console) -}}
{{- end -}}


{{- define "cloudcanal.sidecar.image" -}}
    {{- include "common.images.image" (dict "imageRoot" .Values.sidecar.image "global" .Values.global) }}
{{- end -}}

{{- define "cloudcanal.sidecar.fullname" -}}
    {{ printf "%s-%s" (include "common.names.fullname" .) "sidecar" }}
{{- end }}

{{- define "cloudcanal.sidecar.configMapName" -}}
    {{- printf "%s-%s" (include "common.names.fullname" .) "sidecar-config" }}
{{- end -}}

{{- define "cloudcanal.mysql.image" -}}
    {{- include "common.images.image" (dict "imageRoot" .Values.mysql.image "global" .Values.global) }}
{{- end -}}

{{- define "cloudcanal.mysql.fullname" -}}
    {{ printf "%s-%s" (include "common.names.fullname" .) "mysql" }}
{{- end }}

{{- define "cloudcanal.mysql.pvcName" -}}
    {{- if .Values.mysql.persistence.existingClaim }}
        {{- .Values.mysql.persistence.existingClaim }}
    {{- else }}
        {{- printf "%s-%s" (include "cloudcanal.mysql.fullname" .) "data" }}
    {{- end }}
{{- end -}}

{{- define "cloudcanal.mysql.serviceName" -}}
    {{- printf "%s-%s" (include "common.names.fullname" .) "mysql" }}
{{- end -}}

{{- define "cloudcanal.mysql.internalAddress" -}}
    {{- printf "%s:%d" (include "cloudcanal.mysql.serviceName" .) (int .Values.mysql.service.ports.mysql) }}
{{- end -}}


