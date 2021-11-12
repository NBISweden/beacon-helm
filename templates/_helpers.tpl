{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "beacon.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "beacon.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "beacon.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "beacon.configPath" -}}
    {{- ternary "/app/conf/" .Values.config.path (empty .Values.config.path) -}}
{{- end -}}

{{- define "beacon.databaseSecretName" -}}
{{- if .Values.postgresql.enabled }}
    {{- if .Values.postgresql.existingSecret -}}
        {{- printf "%s" .Values.postgresql.existingSecret -}}
    {{- else -}}
        {{- printf "%s-%s" .Release.Name "postgresql" -}}
    {{- end -}}
    {{- printf "%s" .Values.postgresql.existingSecret  -}}
{{- else if .Values.externalDatabase.existingSecret -}}
    {{- printf "%s" .Values.externalDatabase.existingSecret -}}
{{- else -}}
    {{- printf "%s-externaldb" (include "beacon.fullname" .) -}}
{{- end -}}
{{- end -}}

{{- define "beacon.databaseHost" -}}
{{- if .Values.postgresql.enabled }}
    {{- printf "%s-%s" .Release.Name "postgresql" -}}
{{- else -}}
    {{- printf "%s" (required "A .Values.database.host entry is required!" .Values.externalDatabase.host) -}}
{{- end -}}
{{- end -}}

{{- define "beacon.databaseUser" -}}
{{- if .Values.postgresql.enabled }}
    {{- printf "%s" .Values.postgresql.postgresqlUsername -}}
{{- else -}}
    {{- printf "%s" (required "A .Values.database.user entry is required!" .Values.externalDatabase.user) -}}
{{- end -}}
{{- end -}}

{{- define "beacon.databaseName" -}}
{{- if .Values.postgresql.enabled }}
    {{- printf "%s" .Values.postgresql.postgresqlDatabase -}}
{{- else -}}
    {{- printf "%s" (required "A .Values.database.name entry is required!" .Values.externalDatabase.name) -}}
{{- end -}}
{{- end -}}

{{- define "beacon.databasePort" -}}
{{- if .Values.postgresql.enabled }}
    {{- printf "%d" 5432 -}}
{{- else -}}
    {{- printf "%s" .Values.externalDatabase.port -}}
{{- end -}}
{{- end -}}
