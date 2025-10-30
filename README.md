![version](https://img.shields.io/badge/version-21%2B-3B69E9)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/4d-example-pdf-chunking)](LICENSE)

# 4d-example-pdf-chunking
Use llama.cpp to locally process PDF for semantic search


```mermaid
  graph TD;
  A[Start] --> |"File.getContent()"| B[Load PDF to BLOB];
  B --> |"Entity.save()"|C[Save BLOB to DocumentEntity];
  C --> D[DocumentEntity event afterSave];
  D --> |CALL WORKER| E[Extract Text of all pages];
  E --> |On Response| F[Save Text of all pages to PageEntitySelection];
  F --> |CALL WORKER| G[Split Text of all pages into Chunks];
  G --> |On Response| H[Save Chunks to ChunkEntitySelection];
  H --> |CALL WORKER| I[Generate Embeddings from Chunks];
  I --> |On Response| J[Save Embedding to ChunkEntity];
```


## Screenshots

* Catalog

<img width="1004" height="631" alt="Catalog" src="https://github.com/user-attachments/assets/f587a720-9693-425b-9c2d-9140e68859a6" />

* MSC > Information > Tables
  
<img width="931" height="662" alt="スクリーンショット Tables" src="https://github.com/user-attachments/assets/34e554d3-38c2-4d30-9535-92dd5adfa728" />

