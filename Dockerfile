# 1. Usa una imagen base oficial y segura
FROM python:3.10-slim

# 2. Define variables de entorno básicas (opcional)
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# 3. Instala dependencias del sistema necesarias
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    libpq-dev \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# 4. Crea un usuario seguro
RUN adduser --disabled-password appuser

# 5. Establece el directorio de trabajo
WORKDIR /app

# 6. Copia primero los archivos de dependencias para aprovechar la cache de Docker
COPY devsu-demo-devops-python/requirements.txt .

# 7. Instala las dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# 8. Copia el código de la aplicación
COPY devsu-demo-devops-python/ ./devsu-demo-devops-python/

# 9. Copia el archivo de entorno (.env.prod en producción real)
COPY devsu-demo-devops-python/.env ./devsu-demo-devops-python/.env

# 10. Prepara carpeta y permisos para la base de datos SQLite
RUN mkdir -p /app/devsu-demo-devops-python && chown -R appuser /app

# 11. HEALTHCHECK para verificar si el servidor Django responde
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s \
  CMD curl -f http://localhost:8000/api/ || exit 1

# 12. Usa el usuario seguro
USER appuser

# 13. Expone el puerto por defecto de Django
EXPOSE 8000

# 14. Comando por defecto para ejecutar el servidor
CMD ["python", "devsu-demo-devops-python/manage.py", "runserver", "0.0.0.0:8000"]