Apartment Gem:

It provides tools to manage multi-tenancy in rails applications.

It also provides the flexibility to have common data between different tenants.

Multi-tenancy:

Segregate data into separate independent schemas for different user accounts.

Can be implemented on several different levels:

Database-Row Level:

You can put a tennat_id column into every DB table and filter by tenant_id in every query. 

Schema-Level: 

For every tenant, you create a separate namespaced set of tables inside one database.

Database level - you set up a whole new DB for every tenant.

How to get it work:

Apartment gem supports tenets on the basis of subdomains, domains and hosts etc

To use tenets via subdomain we need to use subdomains middleware in application.rb

config.middleware.use Apartment::Elevators::Subdomain

Apartment gem creates separate tenants based on subdomains. For example, we want to achieve multi-tenancy for every registered user we need to:

Store an extra column with an arbitrary name 'subdomain'

The apartment will create a new schema for every subdomain and store data independently associated with that user's subdomain (We don’t need to add model-level associations to it).

For example, we have a rails application hosted on ' '

For every user, the apartment will create a separate tenant which will be accessible at this url 'subdomain.domain.com' which will be independent of other tenants.

There are different configurations available on the GitHub repo.

Data that needs to be available across tenants have to be included in the global tenant only. You can do this by adding the ActiveRecord models in config.excluded_models in apartment.rb initializer file.

You can manually switch tenants using the switch or switch! command or Apartment gem also provides a middleware that automatically switches to the appropriate tenant based on the request's subdomain.

Project Management Via Apartment: 

I created a new project with 2 models User and Project. A user can have multiple projects and I’m going to handle this via Multi-tenancy.

Created 2 users with subdomains as kmp and kcp.



Added subdomain field in the users table to act as a tenant. 



The tenant will be updated when the subdomain gets updated.



A new DB is created against every subdomain.



I created projects against both of these tenets.

Whenever I go to http://kmp.appartment.localhost:3000/projects It will display all projects belonging to the user(haziq@devsinc.com) and vice versa.
