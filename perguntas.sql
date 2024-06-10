SELECT 
    ano,
    id_cliente,
    nome_cliente,
    total_pedidos
FROM (
    SELECT
        YEAR(m.data_hora_entrada) AS ano,
        c.id_cliente,
        c.nome_cliente,
        COUNT(p.codigo_prato) AS total_pedidos,
        RANK() OVER (PARTITION BY YEAR(m.data_hora_entrada) ORDER BY COUNT(p.codigo_prato) DESC) AS rank_pedidos
    FROM
        tb_pedido p
    JOIN
        tb_mesa m ON p.codigo_mesa = m.codigo_mesa
    JOIN
        tb_cliente c ON m.id_cliente = c.id_cliente
    GROUP BY
        ano, c.id_cliente
) ranked_pedidos
WHERE rank_pedidos = 1;

-- dps mudar
SELECT
    c.id_cliente,
    c.nome_cliente,
    SUM(CAST(p.quantidade_pedido AS UNSIGNED) * pr.preco_unitario_prato) AS total_gasto
FROM
    tb_pedido p
JOIN
    tb_mesa m ON p.codigo_mesa = m.codigo_mesa
JOIN
    tb_cliente c ON m.id_cliente = c.id_cliente
JOIN
    tb_prato pr ON p.codigo_prato = pr.codigo_prato
GROUP BY
    c.id_cliente, c.nome_cliente
ORDER BY
    total_gasto DESC
LIMIT 1;

SELECT 
    ano,
    id_cliente,
    nome_cliente,
    total_pessoas
FROM (
    SELECT
        YEAR(m.data_hora_entrada) AS ano,
        m.id_cliente,
        c.nome_cliente,
        SUM(m.num_pessoa_mesa) AS total_pessoas,
        RANK() OVER (PARTITION BY YEAR(m.data_hora_entrada) ORDER BY SUM(m.num_pessoa_mesa) DESC) AS rank_pessoas
    FROM
        tb_mesa m
    JOIN
        tb_cliente c ON m.id_cliente = c.id_cliente
    GROUP BY
        ano, m.id_cliente
) ranked_pessoas
WHERE rank_pessoas = 1;

SELECT
    tb_empresa.nome_empresa AS empresa,
    COUNT(DISTINCT tb_beneficio.codigo_funcionario) AS total_funcionarios
FROM
    tb_beneficio
JOIN
    tb_empresa ON tb_beneficio.codigo_empresa = tb_empresa.codigo_empresa
JOIN
    tb_cliente ON tb_beneficio.email_funcionario = tb_cliente.email_cliente
JOIN
    tb_mesa ON tb_cliente.id_cliente = tb_mesa.id_cliente
GROUP BY
    tb_empresa.nome_empresa
ORDER BY
    total_funcionarios DESC
LIMIT 1;

SELECT
    ano,
    nome_empresa,
    total_funcionarios_sobremesa
FROM
    (
        SELECT
            YEAR(m.data_hora_entrada) AS ano,
            e.nome_empresa,
            COUNT(DISTINCT c.email_cliente) AS total_funcionarios_sobremesa,
            ROW_NUMBER() OVER (PARTITION BY YEAR(m.data_hora_entrada) ORDER BY COUNT(DISTINCT c.email_cliente) DESC) AS ranking
        FROM
            tb_mesa m
        JOIN
            tb_cliente c ON m.id_cliente = c.id_cliente
        JOIN
            tb_pedido p ON m.codigo_mesa = p.codigo_mesa
        JOIN
            tb_prato pr ON p.codigo_prato = pr.codigo_prato
        JOIN
            tb_tipo_prato tp ON pr.codigo_tipo_prato = tp.codigo_tipo_prato
        JOIN
            tb_beneficio b ON c.email_cliente = b.email_funcionario
        JOIN
            tb_empresa e ON b.codigo_empresa = e.codigo_empresa
        WHERE
            tp.nome_tipo_prato = 'Sobremesa'
        GROUP BY
            YEAR(m.data_hora_entrada), e.nome_empresa
    ) AS ranking
WHERE
    ranking = 1;


