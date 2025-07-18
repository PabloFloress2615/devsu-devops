# DevOps Demo – Python (Django REST)

Este proyecto forma parte de una prueba técnica con enfoque en la creación de un pipeline CI/CD, el despliegue en Kubernetes y la aplicación de buenas prácticas DevOps.

---

## Contenido del Repositorio

```bash
.
├── devsu-demo-devops-python   # Aplicación Django con API REST
├── infra                      # Infraestructura (Kubernetes + Terraform)
│   ├── manifests              # ConfigMaps, Secrets, HPA, Deployment, Service
│   └── terraform              # Código IaC para GKE
├── Dockerfile                 # Imagen Docker de la aplicación
├── sonar-project.properties   # Configuración para SonarCloud
└── README.md

CI/CD Pipeline

Se utilizó GitHub Actions como sistema de CI/CD, compuesto por dos flujos de trabajo:

CI – Build & Test
	•	Instalación de dependencias
	•	Creación del archivo .env
	•	Migraciones de base de datos y ejecución de pruebas unitarias
	•	Linter (flake8)
	•	Cobertura de código
	•	Análisis estático con SonarCloud

Se alcanzó una cobertura del 90.5% y no se detectaron issues críticos de calidad.
Se dejó visible un SECRET_KEY de prueba para validar el correcto funcionamiento de SonarCloud.

CD – Deploy a GKE
	•	Autenticación con GCP usando Service Account
	•	Obtención de credenciales de GKE
	•	Render de plantillas (envsubst) y aplicación de manifiestos Kubernetes
	•	Verificación del rollout con kubectl rollout status

Los secretos y variables de configuración se obtienen dinámicamente de los GitHub Secrets.

⸻

Despliegue en Kubernetes

La aplicación se desplegó en un clúster GKE con escalamiento automático (HPA).
Recursos aplicados:
	•	ConfigMap para variables de configuración (DEBUG, ALLOWED_HOSTS)
	•	Secret para la clave de Django (DJANGO_SECRET_KEY)
	•	Deployment con 2 réplicas y recursos CPU/memoria definidos
	•	Service tipo LoadBalancer para exponer la aplicación
	•	HorizontalPodAutoscaler basado en CPU

Requisitos Cumplidos
	•	Dockerización completa
	•	Pipeline CI/CD funcional con análisis estático
	•	Despliegue en Kubernetes con HPA
	•	IaC con Terraform
	•	Documentación de arquitectura y despliegue
	•	API funcional y accesible públicamente

Recursos
	•	Repositorio: https://github.com/pablodfflores34/devsu-demo-devops-python
	•	URL pública de la API: http://34.59.222.136/api/


