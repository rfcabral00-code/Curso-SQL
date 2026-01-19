-- -- quantos produtos são de RPG?

-- SELECT COUNT(*)

-- FROM produtos

-- WHERE DescCategoriaProduto = 'rpg'

SELECT DescCategoriaProduto,
       count(*)

FROM produtos

GROUP by DescCategoriaProduto

