#!/bin/bash

sudo -u postgres -H sh -c "psql -c 'CREATE DATABASE pg_ds;'" -v

sudo -u postgres -H sh -c "psql -c '\c pg_ds'" -v

sudo -u postgres -H sh -c "psql -d pg_ds -c 'CREATE TABLE cellphones(
    id serial PRIMARY KEY,
    name VARCHAR (100) NOT NULL,
    brand VARCHAR (100) NOT NULL,
    capacity INTEGER NOT NULL
);'" -v

sudo -u postgres psql -c '\c pg_ds;' -c '\i .\insert.sql;' 



