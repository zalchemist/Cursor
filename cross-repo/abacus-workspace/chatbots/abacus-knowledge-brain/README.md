# Abacus Knowledge Brain

## Osnovne informacije
- **Deployment ID:** *(koristi env var `ABACUS_DEPLOYMENT_ID_KNOWLEDGE_BRAIN`)*
- **Deployment Token:** *(koristi env var `ABACUS_DEPLOYMENT_TOKEN_KNOWLEDGE_BRAIN`)*
- **Model:** Claude V4.5 Sonnet
- **Document Retriever ID:** *(koristi env var `ABACUS_DOC_RETRIEVER_ID_KNOWLEDGE_BRAIN`)*
- **Status:** Active

## Namena
Ekspert za:
- Abacus.AI platforma
- API dokumentacija
- Chatbot konfiguracija
- Document Retrieveri i Feature Groups
- Deployment i integracije

## Knowledge Base
Da — ima Document Retriever sa Abacus.AI dokumentacijom

## Primer koriscenja
```python
import os

response = client.get_chat_response(
    deployment_token=os.environ['ABACUS_DEPLOYMENT_TOKEN_KNOWLEDGE_BRAIN'],
    deployment_id=os.environ['ABACUS_DEPLOYMENT_ID_KNOWLEDGE_BRAIN'],
    messages=[{
        'is_user': True,
        'text': 'Kako da programatski dodam dokument u Feature Group?'
    }]
)
```

## Ogranicenja
- Nema DeepAgent protokol ([DEEP_AGENT_QUERY] itd.)
- Moze se dodati u buducnosti
