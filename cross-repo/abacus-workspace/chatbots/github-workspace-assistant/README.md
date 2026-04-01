# GitHub Workspace Assistant

## Osnovne informacije
- **Deployment ID:** *(koristi env var `ABACUS_DEPLOYMENT_ID_GH_ASSISTANT`)*
- **Deployment Token:** *(koristi env var `ABACUS_DEPLOYMENT_TOKEN_GH_ASSISTANT`)*
- **Model:** Claude V4.5 Sonnet
- **Status:** Active

## Namena
Specijalizovan za:
- Biznisoft MySQL ERP baza
- SQL upiti i seme tabela
- Git operacije

## DeepAgent protokol
Ovaj chatbot razume strukturirane poruke:

### [DEEP_AGENT_QUERY] - Pocetak sesije
Koristi za dobijanje konteksta pre rada.

### [DEEP_AGENT_REPORT] - Kraj sesije
Koristi za slanje izvestaja o zavrsenoj sesiji.

### [DEEP_AGENT_UPDATE] - Tokom sesije
Koristi za slanje znacajnih update-a.

## Primer koriscenja
```python
import os

response = client.get_chat_response(
    deployment_token=os.environ['ABACUS_DEPLOYMENT_TOKEN_GH_ASSISTANT'],
    deployment_id=os.environ['ABACUS_DEPLOYMENT_ID_GH_ASSISTANT'],
    messages=[{
        'is_user': True,
        'text': '[DEEP_AGENT_QUERY]\nKorisnik trazi: Analiza tabele FAKTURE'
    }]
)
```

## Ogranicenja
- Nema Knowledge Base / Document Retriever
- Ne moze trajno da cuva novo znanje (samo sesijska memorija)
