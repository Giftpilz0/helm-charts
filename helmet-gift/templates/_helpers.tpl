{{/*
Create the name of the service account to use
*/}}
{{- define "helmet-gift.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the httproute
*/}}
{{- define "helmet-gift.httpRouteName" -}}
{{- if .Values.httpRoute.create }}
{{- default (include "common.names.fullname" .) .Values.httpRoute.name }}
{{- else }}
{{- default "default" .Values.httpRoute.name }}
{{- end }}
{{- end }}

{{/*
Render an array of env variables. The input can be a map or a slice.
Values can be templates using the "common.tplvalues.render" helper, but changes to scope are not processed.
Usage:
{{ include "helmet-gift.toEnvArray" ( dict "envVars" .Values.envVars "context" $ ) }}
*/}}
{{- define "helmet-gift.toEnvArray" -}}
{{- if kindIs "map" .envVars }}
{{- range $key, $val := .envVars }}
- name: {{ $key }}
{{- if kindIs "string" $val }}
  value: {{ include "common.tplvalues.render" (dict "value" $val "context" $.context) }}
{{- else if kindIs "map" $val }}
{{ include "common.tplvalues.render" (dict "value" (omit $val "name") "context" $.context) | indent 2 }}
{{- end -}}
{{- end -}}
{{- else if kindIs "slice" .envVars }}
{{ include "common.tplvalues.render" (dict "value" .envVars "context" $.context) }}
{{- end }}
{{- end -}}
