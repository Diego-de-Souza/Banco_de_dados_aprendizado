/*exercicios da apostila*/

/*1)selecione o maior e menor código de funcionários*/

select MAX(f.func_id) MaxId, MIN(f.func_id) MinId from funcionarios f

--2)Selecione a media salárial

select AVG(f.func_salario) as "Media Salarial" from funcionarios f

--3) Selecione todos os campos apenas dos 5 primeiros funcionários ordenados por ordem decrescente de salário

select TOP 5 * 
from funcionarios f
order by f.func_salario desc

--4) Selecione todos os setores que terminam com a letra ‘a’.

select s.setor_nome 
from funcionarios f
inner join setores s on s.setor_id = f.func_id
where s.setor_nome like '%a'

--5)Selecione o setor_id da tabela funcionários, de forma distinta

select distinct funcionarios.func_id from funcionarios

--6) Selecione a média salarial dos funcionários que são gerentes.

select AVG(f.func_salario) "Média salarial"
from funcionarios f
where f.gerente_id is not Null 

--7) Selecione o código do gerente e a quantidade de funcionários que trabalham para ele

select f.gerente_id as codigo_gerente, count(*) as quantidade_de_funcionarios  
from funcionarios f
where f.gerente_id is not null
group by f.gerente_id

--8) Selecione todos os funcionários que nasceram antes de 1974 e que ganham mais de 4000,00 OU aqueles que
--trabalham no setor 1 e que ganham mais de 1000,00.

select * 
from funcionarios f
where f.func_dataNasc < 1974 and f.func_salario > 4000
or f.setor_id = 1 and f.func_salario > 1000
