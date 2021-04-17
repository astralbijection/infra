#!/bin/sh

inputs=$1
outfile=$2

# Write in regular input files
cat $inputs/* > $outfile

# Add in the database secrets
cat >> $outfile <<-EOF
database:
  name: psycopg2
  args:
    user: $username
    password: $password
    database: postgresql
    host: synapse-db
    cp_min: 5
    cp_max: 10
EOF