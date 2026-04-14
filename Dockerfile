FROM python:3.13-slim

WORKDIR /app

# Installa dipendenze di sistema (richieste da psycopg2 e git per justetf-scraping)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq-dev \
    gcc \
    git \
    && rm -rf /var/lib/apt/lists/*

# Installa dipendenze Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia tutto il codice dell'applicazione
COPY . .

# Crea directory dati (poi montate come volume)
RUN mkdir -p data/history

EXPOSE 5001

# Usa python main.py perché lo scheduler gira in thread background
CMD ["python", "main.py"]
