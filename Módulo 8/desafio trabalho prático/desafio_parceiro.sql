-- Criação da tabela
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

-- Inserção de dados
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

-- Atualização da latitude e longitude
UPDATE parceiros
SET latitude = -21.785741,
    longitude = -46.57421
WHERE id = 1;

-- Consulta por ID
SELECT * FROM parceiros WHERE id = 1;

-- Consulta do parceiro mais próximo
SELECT *,
  SQRT(
    POW(latitude - (-21.786000), 2) +
    POW(longitude - (-46.574000), 2)
  ) AS distancia
FROM parceiros
ORDER BY distancia
LIMIT 1;
