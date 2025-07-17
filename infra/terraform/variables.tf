variable "project_id" {
  description = "ID del proyecto GCP donde crearemos los recursos"
  type        = string
}

variable "region" {
  description = "Región GCP"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zona GCP"
  type        = string
  default     = "us-central1-a"
}

variable "credentials_file" {
  description = "Ruta al JSON de la Service Account de Terraform"
  type        = string
}