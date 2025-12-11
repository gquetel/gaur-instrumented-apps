let
  inputs = import ../../npins;
  pkgs = import inputs.nixpkgs { };
  customMysql = import ./instrumented-mysql;

  init_db_sql = pkgs.writeTextFile {
    name = "init_db.sql";
    text = ''
      ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
      create database users;
      create database dataset;
      use users;

      CREATE USER 'tata'@'localhost' IDENTIFIED BY 'tata';
      GRANT ALL PRIVILEGES ON dataset.* TO 'tata'@'localhost';
      flush privileges;
    '';
  };

in
pkgs.writeScriptBin "run-server" ''
  #!/usr/bin/env bash

  shostname=$(hostname -s)
  base=~/tmp/$shostname/mistral

  port=61836
  datadir=$base/datadir
  socket=$base/socket

  # 1. First check that no process contains in their full command
  if pgrep -f "$base" >/dev/null 2>&1; then
    echo "Existing mysqld instance detected using filter: $base. Killing them..."
    pkill -f "$base"
    sleep 1

    # Ensure no leftover processes
    if pgrep -f "$base" >/dev/null 2>&1; then
      echo "Error: process is still alive"
      exit 1
    fi
  fi

  # 2. Then check that datadir is non existant, if so, delete it. 
  if [ -d "$base" ]; then
    echo "Removing existing datadir: $base"
    rm -rf "$base"
  fi

  # 3. Initialise server
  mkdir -p "$base"
  ${customMysql}/bin/mysqld --initialize-insecure  --datadir="$datadir" --basedir="${customMysql}/bin/"

  # 4. Start server
  ${customMysql}/bin/mysqld --log-error="$datadir/$shostname.err" --basedir="${customMysql}/bin/" --socket "$socket" --datadir "$datadir" --port "$port" --secure-file-priv="" --daemonize 
  echo "Waiting for server to start"
  sleep 2

  if pgrep -f "$base" >/dev/null 2>&1; then
    echo "Server has started. Initialising users..."
    ${pkgs.mysql84}/bin/mysql --user=root --socket "$socket" < ${init_db_sql}
    echo "Done. To kill the server, use: killall -r $base"
  else
    echo "Warning: MySQL server is not running! Check the logs for more information."
  fi
''
