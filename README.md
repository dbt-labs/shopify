# shopify
dbt data models for Shopify.


[Here](https://help.shopify.com/en/api/reference) is Shopify's API documentation.

[Here](https://www.stitchdata.com/docs/integrations/saas/shopify/v15-10-2015#schema) 
is info about Stitch's Shopify connector. 

[Here](https://docs.getdbt.com/docs/package-management) is some additional 
information about packages in dbt. If you haven't already, you will need to create
a `packages.yml` file in your project and supply the git link from this repository.

You should then copy the shopify package structure from the `dbt_project.yml` in
this repository into your project's `dbt_project.yml` file and replace the `#`
values with the shopify table names from your warehouse.

This package is compatible with Snowflake and Redshift with data synced through
Stitch. Because Stitch deconstructs nested values when replicating data to
Redshift, there are several vars in the `dbt_project.yml` file that are not
necessary for Snowflake projects (notes in the project file)