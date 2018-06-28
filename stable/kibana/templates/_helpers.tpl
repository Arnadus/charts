{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "kibana.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "kibana.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if ne $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "kibana.elasticsearch.fullname" -}}
{{- $nameOverride := .Values.elasticsearch.nameOverride -}}
{{- $name := default .Chart.Name $nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "kibana.env.all" -}}
- name: "ELASTICSEARCH_URL"
  value: "http://{{ template "kibana.elasticsearch.fullname" . }}:{{ .Values.elasticsearch.port }}"
- name: "ELASTICSEARCH_REQUESTTIMEOUT"
  value: "300000"
- name: "SERVER_PORT"
  value: "{{ .Values.service.internalPort }}"
- name: "LOGGING_VERBOSE"
  value: "true"
- name: "SERVER_DEFAULTROUTE"
  value: "/app/kibana"
- name: XPACK_MONITORING_ENABLED
  value: "false"
- name: XPACK_SECURITY_ENABLED
  value: "false"
{{- end -}}
