# Kubernetes ist nicht wirklich Multi Tenant-Fähig

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
