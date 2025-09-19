create table alunos (
id serial primary key,
nome text not null, 
idade int not  null

);
insert into alunos (nome, idade) values ('joao', 21);
insert into alunos (nome, idade) values ('lucas', 20);
insert into alunos (nome, idade) values ('ana', 22);

