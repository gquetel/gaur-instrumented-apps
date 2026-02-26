# gaur-instrumented-apps

A collection of applications instrumented with [**gaur**](https://github.com/gquetel/gaur).  

**Gaur** is a tool that automatically instruments Bison-generated parsers to provide **lexical, syntactic, and semantic information** for Intrusion Detection Systems (IDS). 

All instrumented applications are built using **Nix** and the patch mechanism. This repository contains the patches needed to reproduce the instrumented builds (no invocation of **gaur** is required).

## Quick Start (using mysql-mistral)

1. Install [Nix](https://nixos.org/download.html) if not already installed.  
2. Clone this repository:  
   ```bash
   git clone https://github.com/gquetel/gaur-instrumented-apps.git
   cd gaur-instrumented-apps
   ```
3. Build the instrumented MySQL server producing semantic tags defined by Mistral.
    ```
    cd apps/mysql-mistral
    nix-build default.nix
    ```
4. Run the resulting instrumented server:
    ```
    ./result/bin/run-server
    ```

## MySQL servers
This repository provides several instrumented MySQL server builds, used in our research (TODO: add paper reference). Each build differs in the semantic tags it produces.  The semantic models defined are as follows: 

| Model Name    | Semantic Tags                                                                                                                                                                                                                                                                                                                                                                                       |
| ------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| mysql-chatgpt | DDL_ALTER, DDL_CREATE, DDL_DROP, DML_DELETE_TRUNCATE, DML_INSERT_REPLACE, DML_MAINTENANCE, DML_SELECT, DML_UPDATE, EXPRESSION_LOGIC, PARTITIONING_STORAGE, PRIVILEGES_SECURITY, PROCEDURAL_LOGIC, REPLICATION_MANAGEMENT, SERVER_ADMIN, SHOW_DESCRIBE_EXPLAIN, STATEMENT_CONTROL, STATEMENT_HELP, STATEMENT_MANAGEMENT, TRANSACTION_CONTROL, WINDOW_ANALYTICS                                       |
| mysql-claude | ADMINISTRATIVE, CLAUSE_COMPONENT, CONSTRAINT_DEFINITION, DATA_IMPORT_EXPORT, DATA_TYPE, DDL_STATEMENT, DML_STATEMENT, ENTRY_POINT, EXPRESSION, FUNCTION_CALL, IDENTIFIER, LITERAL_VALUE, OPTIONAL_MODIFIER, QUERY_STRUCTURE, REPLICATION_CLUSTER, STORED_PROCEDURE, SYNTAX_ELEMENT, TABLE_REFERENCE, TRANSACTION_CONTROL, USER_MANAGEMENT                                                           |
| mysql-expert  | _actions_: CREATE, DELETE, EXECUTE, MODIFY, READ;  _objects_: TABLESPACE, TABLE, INDEX, VIEW, USER, PROCEDURE, DATABASE, FUNCTION, INSTANCE, LOGFILE, SERVER, TRIGGER                                                                                                                                                                                                                               |
| mysql-gpt-oss | CLAUSE_MODIFIER, CONSTRAINT, DDL_STATEMENT, DML_STATEMENT, DATA_TYPE, EVENT_SCHEDULING, EXPRESSION, IDENTIFIER, INDEX_DEFINITION, JOIN_CLAUSE, LITERAL, OPTIONS_LIST, PARTITION_CLAUSE, PREDICATE, PRIVILEGE_CONTROL, REPLICATION_CONTROL, STORED_PROGRAM, TRANSACTION_CONTROL, UTILITY_STATEMENT, WINDOW_FUNCTION                                                                                  |
| mysql-llama   | DCL, DDL, DML, DATABASE, EVENT, FUNCTION, INDEXING, LOCKING, PROCEDURE, QUERY, ROLE, SECURITY, SERVER, TABLE, TABLESPACE, TRANSACTION, TRIGGER, USER, UTILITY, VIEW                                                                                                                                                                                                                                 |
| mysql-mistral | DATA_DEFINITION, DATA_IMPORT_EXPORT, DATA_MANIPULATION, DATA_QUERY, DATABASE_MANAGEMENT, LOCKING_CONCURRENCY, MISCELLANEOUS_OPERATIONS, REPLICATION_CLUSTERING, RESOURCE_MANAGEMENT, SECURITY_PRIVILEGES, STATEMENT_CONTROL, STORED_PROCEDURES_FUNCTIONS, SYSTEM_INFORMATION, SYSTEM_MAINTENANCE, SYSTEM_VARIABLES, TEMPORARY_OBJECTS, TRANSACTION_CONTROL, TRIGGERS_EVENTS, USER_MANAGEMENT, VIEWS |


