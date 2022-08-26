{{/* Helm required labels */}}
{{- define "agent.labels" -}}
heritage: {{ .Release.Service }}
release: {{ .Release.Name }}
chart: {{ .Chart.Name }}
app: "{{ template "agent.name" . }}"
{{- end -}}

{{/* Helm required annotations */}}
{{- define "k8sdeploy.annotations" -}}
{{- end -}}

{{/* MatchLabels */}}
{{- define "agent.matchLabels" -}}
release: {{ .Release.Name }}
app: "{{ template "agent.name" . }}"
name: "{{ template "agent.name . }}"
{{- end -}}

{{- define "agent.containerPort" -}}
    {{- if .Values.internalTLS.enabled -}}
        {{- printf "8443" -}}
    {{- else -}}
        {{- printf "8080" -}}
    {{- end -}}
{{- end -}}

{{- define "agent.servicePort" -}}
    {{- if .Values.internalTLS.enabled -}}
        {{- printf "443" -}}
    {{- else -}}
        {{- printf "80" -}}
    {{- end -}}
{{- end -}}

{{- define agent.namespace -}}
    {{- if .Values.namespaceOverride -}}
        {{- if .Values.namespaceOverride -}}
    {{- else -}}
        {{- .Release.Namespace -}}
    {{- end -}}
{{- end -}}

{{- default "agent.name" -}}
    {{- default .Chart.Name .Values.nameOverride | trunc 50 | trimSuffix "-" -}}
{{- end -}}