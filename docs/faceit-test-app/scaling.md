## Scaling up FaceIT Test App for Large Scale User Base

As this application resides within serverless the two biggest bottleknecks of this app are the VM instances which handle the VPC peering connection for private SQL communication as well as the SQL database cluster it's self which by default only has a single node.

In a scale out event it is simple and easy to change these values via the following properties:

`google_vpc_access_connector.connector`:`min_instances`/`max_instances` and `machine_type` in `test-app/terraform/vpc_access.tf`

and by adding a list of Read Replicas to the Postgresql deployment:

```hcl
list(object({
    name            = string
    tier            = string
    zone            = string
    disk_type       = string
    disk_autoresize = bool
    disk_size       = string
    user_labels     = map(string)
    database_flags = list(object({
      name  = string
      value = string
    }))
    ip_configuration = object({
      authorized_networks = list(map(string))
      ipv4_enabled        = bool
      private_network     = string
      require_ssl         = bool
      allocated_ip_range  = string
    })
    encryption_key_name = string
  }))
```

