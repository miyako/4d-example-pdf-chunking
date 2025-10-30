![version](https://img.shields.io/badge/version-21%2B-3B69E9)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/4d-example-pdf-chunking)](LICENSE)

# 4d-example-pdf-chunking
Use `llama.cpp` to locally process PDF for semantic search


```mermaid
  graph TD;
  A[Start] --> |"File.getContent()"| B[Load PDF to BLOB];
  B --> |"Entity.save()"|C[Save BLOB to DocumentEntity];
  C --> C2[DocumentEntity event afterSave];
  C2 --> C3{"savedAttributes.includes(&quot;data&quot;)"};
  C3 -- Yes --> C4{"(This.data#Null) && (This.data.size#0)"};
  C3 -- No  --> Z((END));
  C4 -- Yes --> D[CALL WORKER];
  C4 -- No --> C5[Drop This.pages.chunks, This.pages];
  C5 --> Z[End];
  D --> E[Extract text from all pages];
  E --> |On Response| F[Save extracted text to PageEntitySelection];
  F --> F2[CALL WORKER];
  F2 --> G[Split Text of all pages into Chunks];
  G --> |On Response| H[Save Chunks to ChunkEntitySelection];
  H --> |"Entity.save()"| H2[ChunkEntity event afterSave];
  H2 --> H3{"savedAttributes.includes(&quot;embedding&quot;)"};
  H3 -- Yes --> H4[CALL WORKER];
  H3 -- No  --> Z((END));
  H4 --> J[Generate embeddings from chunks];
  J --> |On Response| K[Save embedding to ChunkEntity];
  K --> |"Entity.save()"| H2[ChunkEntity event afterSave];
```

## Screenshots

* Catalog

<img width="1004" height="631" alt="Catalog" src="https://github.com/user-attachments/assets/f587a720-9693-425b-9c2d-9140e68859a6" />

* MSC > Information > Tables
  
<img width="931" height="662" alt="スクリーンショット Tables" src="https://github.com/user-attachments/assets/34e554d3-38c2-4d30-9535-92dd5adfa728" />

