{{/*
Expand the name of the chart.
*/}}
{{- define "rating.name" -}}
{{- default "rating" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "rating.fullname" -}}
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
{{- define "rating.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "rating.labels" -}}
chart: "{{ template "rating.chart" . }}"
release: "{{ .Release.Name }}"
{{- end }}

{{/* matchLabels */}}
{{- define "rating.matchLabels" -}}
chart: "{{ template "rating.chart" . }}"
release: "{{ .Release.Name }}"
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "rating.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "rating.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "rating.app" -}}
  {{- printf "%s" (include "rating.name" .) -}}
{{- end -}}

{{- define "rating.database" -}}
  {{- printf "%s-db" (include "rating.app" .) -}}
{{- end -}}

{{- define "rating.app.containerPort" -}}
  {{- printf "8080" -}}
{{- end -}}

{{- define "rating.app.servicePort" -}}
  {{- printf "8080" -}}
{{- end -}}

{{- define "rating.database.containerPort" -}}
  {{- printf "5432" -}}
{{- end -}}

{{- define "rating.database.servicePort" -}}
  {{- printf "5432" -}}
{{- end -}}

{{- define "rating.database.url" -}}
  {{- printf "jdbc:postgresql://%s:5432" (include "rating.database" .) -}}
{{- end -}}

{{- define "rating.database.username" -}}
  {{- printf "%s" "postgres" -}}
{{- end -}}

{{- define "rating.database.password" -}}
  {{- printf "%s" "password" -}}
{{- end -}}