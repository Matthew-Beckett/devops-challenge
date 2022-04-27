terraform {    
    source  = "tfr:///terraform-google-modules/network/google?version=5.0.0"
}

inputs = {
    network_name = "faceit-test-app-example-vpc"
    subnets = [
        {
            subnet_name           = "faceit-test-app-subnet-01"
            subnet_ip             = "10.10.0.0/28"
            subnet_region         = "europe-west2"
        }
    ]

    secondary_ranges = {
        faceit-test-app-subnet-01 = [
            {
                range_name = "faceit-test-app-subnet-01-secondary-01"
                ip_cidr_range = "10.11.0.0/24"
            }
        ]
    }
}