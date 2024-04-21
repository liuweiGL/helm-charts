{{- define "nacos.image" -}}
    {{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{- define "nacos.createMysqlConfigmap" -}}
    {{- if and (not ) ( eq .Values.nacos.storage.type "mysql" ) -}}
{{- end -}}