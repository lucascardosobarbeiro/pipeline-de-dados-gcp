import base64
import json
from google.cloud import storage

def process_pubsub(event, context):
    """
    Função disparada por mensagens no Pub/Sub.
    Espera uma string JSON codificada em base64.
    Salva o conteúdo no Cloud Storage em formato JSON.
    """
    # Decodifica a mensagem recebida
    if 'data' in event:
        message_data = base64.b64decode(event['data']).decode('utf-8')
        data = json.loads(message_data)
    else:
        print("Mensagem sem dados.")
        return

    # Nome do bucket e arquivo
    bucket_name = 'meu-bucket-processado'
    file_name = f"{data.get('id', 'sem_id')}.json"

    # Inicializa o cliente do Cloud Storage
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(file_name)

    # Escreve o JSON no arquivo no bucket
    blob.upload_from_string(json.dumps(data), content_type='application/json')
    print(f"Arquivo salvo como {file_name} no bucket {bucket_name}.")
