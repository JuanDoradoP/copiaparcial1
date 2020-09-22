postgresql:
  pkg.installed: 
    - pkg: postgresql

file:
  file.managed:
    - name: /home/vagrant/scriptdb.sh
    - source: salt://scriptdb.sh

Run myscript:
  cmd.run:
    - name: sudo sh /home/vagrant/scriptdb.sh

/etc/postgresql/10/main/postgresql.conf:
  file.append:
    - text: |
        listen_addresses = '*'   
remove db if exists:
  cmd.run:
    - name: sudo -u postgres -H -i sh -c "psql -c 'DROP DATABASE IF EXISTS ds_database;'"



create db:
  cmd.run:
    - name: sudo -u postgres -H -i sh -c "psql -c 'CREATE DATABASE ds_database OWNER=remote;'"



grant all privileges db:
  cmd.run:
    - name: sudo -u postgres -H -i sh -c "psql -c 'GRANT ALL PRIVILEGES ON DATABASE ds_database TO remote;'"


change password pguser:
  cmd.run:
    - name: sudo -u remote -H -i sh -c "psql -c 'ALTER USER ds_user PASSWORD '\'remote\'';'"

/etc/postgresql/10/main/pg_hba.conf:
  file.append:
    - text: |
        host    all             all             0.0.0.0/0               md5
        host    all             all             ::/0                    md5
restart postgres:
  cmd.run:
    - name: sudo systemctl restart postgresql
