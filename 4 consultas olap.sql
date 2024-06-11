SELECT
    c.nome_cliente,
    SUM(fp.valor_total_pedido) AS valor_total_pedidos
FROM
    Fato_Pedido fp
JOIN
    Dim_Cliente c ON fp.codigo_cliente = c.codigo_cliente
GROUP BY
    c.nome_cliente
ORDER BY
    valor_total_pedidos DESC;


SELECT
    p.nome_prato,
    SUM(fp.valor_total_pedido) AS valor_total_pedidos
FROM
    Fato_Pedido fp
JOIN
    Dim_Prato p ON fp.codigo_prato = p.codigo_prato
GROUP BY
    p.nome_prato
ORDER BY
    valor_total_pedidos DESC;

 
SELECT
    sp.nome_situacao_pedido,
    SUM(fp.valor_total_pedido) AS valor_total_pedidos
FROM
    Fato_Pedido fp
JOIN
    Dim_Situacao_Pedido sp ON fp.codigo_situacao_pedido = sp.codigo_situacao_pedido
GROUP BY
    sp.nome_situacao_pedido
ORDER BY
    valor_total_pedidos DESC;


SELECT
    a.ano,
    a.mes,
    a.dia,
    SUM(fp.valor_total_pedido) AS valor_total_pedidos
FROM
    Fato_Pedido fp
JOIN
    Dim_Ano_Mes_Dia a ON fp.data_pedido = a.data
GROUP BY
    a.ano, a.mes, a.dia
ORDER BY
    a.ano, a.mes, a.dia;
