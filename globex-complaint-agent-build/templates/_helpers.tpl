{{/*
Expand the name of the chart.
*/}}
{{- define "globex-complaint-agent-build.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "globex-complaint-agent-build.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "globex-complaint-agent-build.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "globex-complaint-agent-build.labels" -}}
helm.sh/chart: {{ include "globex-complaint-agent-build.chart" . }}
{{ include "globex-complaint-agent-build.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "globex-complaint-agent-build.selectorLabels" -}}
app.kubernetes.io/name: {{ include "globex-complaint-agent-build.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "globex-complaint-agent-build.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "globex-complaint-agent-build.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Image Url image will be pushed to defaults to internal registry
*/}}
{{- define "image.dev-url" -}}
{{- if eq .registry "Quay" }}
{{- printf "%s/%s/%s" .Values.image.host .Values.image.organization .Values.image.name }}
{{- else }}
{{- printf "%s/%s/%s" .Values.image.host .Release.Namespace .Values.image.name }}
{{- end }}
{{- end }}
