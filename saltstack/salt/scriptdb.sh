#!/bin/bash

sudo -u postgres -H sh -c "psql -c 'CREATE DATABASE pg_ds;'" -v

sudo -u postgres -H sh -c "psql -c '\c pg_ds'" -v

sudo -u postgres -H sh -c "psql -d pg_ds -c 'CREATE TABLE cellphones(
    id serial PRIMARY KEY,
    name VARCHAR (100) NOT NULL,
    brand VARCHAR (100) NOT NULL,
    capacity INTEGER NOT NULL
);'" -v

sudo -u postgres -H sh -c "psql -d pg_ds -c 'INSERT INTO cellphones(
    (id, name, brand, capacity) VALUES (1, 'note8', 'xiaomi', 128);'" -v

sudo -u postgres -H sh -c "psql -d pg_ds -c 'INSERT INTO cellphones(
    (id, name, brand, capacity) VALUES (2, 'p20', 'huawei', 128);'" -v 

sudo -u postgres -H sh -c "psql -d pg_ds -c 'INSERT INTO cellphones(
    (id, name, brand, capacity) VALUES (3, 'a71', 'samsung', 128);'" -v


