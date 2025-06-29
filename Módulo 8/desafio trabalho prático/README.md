
# Desafio - Cadastro e Consulta de Parceiros

Este projeto foi desenvolvido como parte da disciplina de Banco de Dados. O objetivo é simular o cadastro de parceiros (ex: pontos de venda) com suas localizações e áreas de cobertura, e permitir consultas a esses dados utilizando MySQL.

## 🧩 Funcionalidades implementadas

- Criação da tabela `parceiros` no MySQL
- Inserção de parceiros com os seguintes dados:
  - Nome da loja (`tradingName`)
  - Nome do dono (`ownerName`)
  - Documento (CNPJ)
  - Endereço em formato GeoJSON (`Point`)
  - Área de cobertura em formato GeoJSON (`MultiPolygon`)
- Consulta de parceiro por `id`
- Cálculo e consulta do parceiro mais próximo a partir de uma latitude e longitude (utilizando distância euclidiana simplificada)

## 📦 Estrutura da Tabela

```sql
CREATE TABLE parceiros (
    id INT PRIMARY KEY,
    tradingName VARCHAR(255),
    ownerName VARCHAR(255),
    document VARCHAR(50) UNIQUE,
    coverageArea LONGTEXT,
    address LONGTEXT,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6)
);
```

## 📌 Exemplo de inserção de parceiro

```sql
INSERT INTO parceiros (
    id, tradingName, ownerName, document, coverageArea, address
) VALUES (
    1,
    'Adega da Cerveja - Pinheiros',
    'Zé da Silva',
    '1432132123891/0001',
    '{
        "type": "MultiPolygon",
        "coordinates": [
            [[[30, 20], [45, 40], [10, 40], [30, 20]]],
            [[[15, 5], [40, 10], [10, 20], [5, 10], [15, 5]]]
        ]
    }',
    '{
        "type": "Point",
        "coordinates": [-46.57421, -21.785741]
    }'
);
```

Atualização da latitude e longitude separadas:

```sql
UPDATE parceiros
SET latitude = -21.785741,
    longitude = -46.57421
WHERE id = 1;
```

## 🔍 Consulta por ID

```sql
SELECT * FROM parceiros WHERE id = 1;
```

## 📍 Consulta do parceiro mais próximo

Consulta baseada em distância euclidiana simplificada:

```sql
SELECT *,
  SQRT(
    POW(latitude - (-21.786000), 2) +
    POW(longitude - (-46.574000), 2)
  ) AS distancia
FROM parceiros
ORDER BY distancia
LIMIT 1;
```

## ⚠️ Observações

- O projeto foi simplificado conforme orientação do professor.
- Os campos `coverageArea` e `address` estão armazenados como texto GeoJSON.
- A verificação se a posição está dentro da área de cobertura **não foi implementada**, pois exige recursos adicionais não abordados neste momento.

## 👨‍💻 Desenvolvido por

Fernando – Aluno do curso de programação básica.
