create user lucas with encrypted password '123';
alter user lucas with createdb;
create database uvv with owner lucas template template0 encoding 'UTF8' lc_collate 'pt_BR.UTF-8' lc_ctype 'pt_BR.UTF-8' allow_connections true;

\c uvv lucas 