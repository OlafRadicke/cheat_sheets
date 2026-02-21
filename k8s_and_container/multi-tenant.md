# Kubernetes ist nicht wirklich Multi Tenant-Fähig

- [Kubernetes ist nicht wirklich Multi Tenant-Fähig](#kubernetes-ist-nicht-wirklich-multi-tenant-fähig)
  - [ArgoCD](#argocd)
  - [Tekton](#tekton)
  - [Tekton Pipeline as code (Pac)](#tekton-pipeline-as-code-pac)
  - [Cert‑Manager](#certmanager)
  - [OpenBao](#openbao)
  - [External Secrets](#external-secrets)
  - [Monitoring‑Stacks (Prometheus, Grafana, Loki, Tempo)](#monitoringstacks-prometheus-grafana-loki-tempo)
  - [Logging‑Stacks (ELK/EFK, OpenSearch)](#loggingstacks-elkefk-opensearch)
  - [Backup‑Tools (Velero, Kasten)](#backuptools-velero-kasten)
  - [Storage‑Systeme (Rook‑Ceph, Longhorn, OpenEBS)](#storagesysteme-rookceph-longhorn-openebs)
  - [Netzwerk‑Plugins (CNI) wie Calico, Cilium, Flannel](#netzwerkplugins-cni-wie-calico-cilium-flannel)
  - [Admission Controller / Mutating Webhooks](#admission-controller--mutating-webhooks)
  - [Fazit](#fazit)

SUSE Rancher und OpenShift versuchen zwar Multi‑Tenancy zu unterstützen, doch viele zentrale Tools im Kubernetes‑Ökosystem bereiten dabei strukturelle Probleme.

## ArgoCD

Grund: ArgoCD ist darauf ausgelegt, einen Kubernetes‑Cluster als Ganzes zu verwalten. Zwar lässt sich ArgoCD in einem einzelnen Namespace installieren, doch in diesem Modus kann es ausschließlich Ressourcen in genau diesem Namespace verwalten. Eine echte Mandanten‑Trennung ist damit nicht möglich.

## Tekton

Grund: Wie ArgoCD ist auch Tekton konzeptionell für clusterweite Automatisierung ausgelegt. Die zentrale Tekton‑Konfiguration kann im Cluster nur einmal existieren und gilt dann für alle Namespaces. Eine saubere Trennung zwischen Tenants ist damit nicht realisierbar.

## Tekton Pipeline as code (Pac)

Hat ähnliche Probleme wie Tekton

## Cert‑Manager

Grund: Der Cert‑Manager arbeitet effektiv nur in einem einzigen Namespace, in dem sämtliche Konfigurationen abgelegt werden müssen. Wenn mehrere Tenants Zugriff auf diesen Namespace hätten, könnten sie gegenseitig Konfigurationen einsehen oder verändern — ein klarer Verstoß gegen Multi‑Tenancy‑Prinzipien.

## OpenBao

Grund: OpenBao ist darauf ausgelegt, den gesamten Cluster zentral zu verwalten. Dafür legt es unter anderem ClusterRoleBindings an. Nur mit diesen weitreichenden Rechten kann OpenBao Funktionen wie den (Pod‑)Agent‑Injector bereitstellen. Eine tenant‑spezifische Isolation ist damit nicht vorgesehen.

## External Secrets

Grund: Ohne ClusterSecretStore wird die Nutzung schnell aufwendig und redundant. Wenn jeder Tenant nur SecretStore‑Ressourcen verwenden kann, müssen Konfigurationen mehrfach gepflegt werden, was sowohl unübersichtlich als auch fehleranfällig ist.

## Monitoring‑Stacks (Prometheus, Grafana, Loki, Tempo)

Problem:
Prometheus ist per Design clusterweit:

- ein globaler Scrape‑Konfigurationsraum
- gemeinsame Metrik‑Labels
- Tenants können theoretisch Metriken anderer Tenants sehen
- Multi‑Tenancy ist nur über komplizierte Filter oder zusätzliche Proxies möglich

Grafana ist ebenfalls nicht tenant‑sicher, wenn man nicht Enterprise‑Features nutzt.

## Logging‑Stacks (ELK/EFK, OpenSearch)

Problem:
Auch hier gilt:

- zentrale Indizes
- gemeinsame Pipelines
- Tenants können Logs anderer Tenants sehen, wenn RBAC nicht perfekt konfiguriert ist
- Multi‑Tenancy ist oft ein Enterprise‑Feature

## Backup‑Tools (Velero, Kasten)

Problem:
Backup‑Tools benötigen clusterweite Rechte:

- Lesen aller Namespaces
- Wiederherstellen von Ressourcen clusterweit
- CRDs, die global gelten

Damit ist eine tenant‑spezifische Isolation kaum möglich.

## Storage‑Systeme (Rook‑Ceph, Longhorn, OpenEBS)

Problem:
Storage‑Systeme arbeiten naturgemäß clusterweit:

- globale StorageClasses
- gemeinsame Volumes und Pools
- fehlende Tenant‑Isolation auf Storage‑Ebene

Ein Tenant könnte theoretisch Storage anderer Tenants beeinflussen.

## Netzwerk‑Plugins (CNI) wie Calico, Cilium, Flannel

Problem:
Viele CNIs bieten keine echte Mandanten‑Isolation:

gemeinsame Routing‑Tabellen

- Policies müssen manuell gepflegt werden
- Fehlerhafte NetworkPolicies können Tenant‑Grenzen aufheben
- Cilium bietet zwar eBPF‑basierte Isolation, aber auch das ist nicht trivial.

## Admission Controller / Mutating Webhooks

Problem:
Viele Tools, die Admission Webhooks nutzen, arbeiten clusterweit:

- PodSecurityPolicies (veraltet)
- Kyverno
- Gatekeeper (OPA)

Sie greifen in alle Namespaces ein und sind nicht tenant‑spezifisch konfigurierbar.

## Fazit

Der Kern des Problems ist:
Kubernetes wurde nie als Multi‑Tenant‑Plattform entworfen.
Es ist ein Cluster‑Betriebssystem, kein Mandanten‑Betriebssystem.

Viele Tools setzen voraus, dass sie den gesamten Cluster kontrollieren dürfen — und genau das macht Multi‑Tenancy so schwierig.
