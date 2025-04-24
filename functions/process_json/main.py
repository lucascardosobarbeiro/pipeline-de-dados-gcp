import base64
import json
from google.cloud import storage
from datetime import datetime

def process_json(event, context):
    try:
        # Decodifica a mensagem do Pub/Sub
        pubsub_message = base64.b64decode(event['data']).decode('utf-8')
        data = json.loads(pubsub_message)

        # Cria o nome do arquivo com timestamp
        timestamp = datetime.utcnow().strftime("%Y%m%d%H%M%S")
        file_name = f"{data.get('id', 'unknown')}_{timestamp}.json"

        # Salva no bucket
        bucket_name = "pipeline-dados-gcp-data-bucket"
        client = storage.Client()
        bucket = client.bucket(bucket_name)
        blob = bucket.blob(file_name)
        blob.upload_from_string(json.dumps(data), content_type="application/json")

        print(f"Arquivo {file_name} salvo no bucket {bucket_name}")

    except Exception as e:
        print(f"Erro ao processar mensagem: {e}")
