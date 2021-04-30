High-level/psudeo-code implementation

###### Architecture
Scheduled via CloudWatch events -> Lambda.
Lambda would trigger SQL scripts by reading them from S3 (which could be backed by Git and fed via CodePipeline)
Depending on runtime could be - events -> ECS/Batch

Another option would be using Airflow to schedule the pipeline, and either having the transformations stored in the Airflow git or again S3.

The transformation could also be done more via Python & Pandas integration instead of pure SQL.
Could use some SQLAlchemy DTO's etc also.

For larger data volumes a Spark job could also be used to accomplish the transformation.

DBT would probably be the best option for Checkout due to its current use, but I don't have experience with it currently!

###### Schema
SQL was written for Postgresql dialect.
Schema design focused on combining most data into a fact table.
Fact table is used as a 'point in time' reference of the data (timeline).

Use of a slow-changing dimension to track user postcode changes.

Depending on the type of storage used, partitioning can be leveraged to increase performance of time-based queries; along with indexes/distkeys/sortkeys etc.



