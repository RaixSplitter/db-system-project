# db-system-project

## Initialize Database order
Script run order, in order to create the dummy database

1. RUN [initialize.sql](db/initialize.sql)
This deletes the database and creates all relevant tables
2. RUN [populate_dummy_data.sql](db/populate_dummy_data.sql)
Populates the data with inserts
3. RUN [views.sql](db/views.sql)
Creates the different views
4. RUN [triggers.sql](db/triggers.sql)
Activates triggers
5. RUN [func_proc.sql](db/func_proc.sql)
Defines functions and procedures

## Examples of usage
The following utility files are for demonstration purposes and can be found in the [sql folder](sql).

* [DELETE](sql/example_delete.sql)
* [UPDATE](sql/example_update.sql)
* [QUERIES](sql/example_queries.sql)
* [FUNCTION](sql/example_function.sql)
* [PROCEDURE](sql/example_procedures.sql)

