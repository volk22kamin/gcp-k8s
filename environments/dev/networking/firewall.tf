locals {
  dev_firewall_rules = [
    {
      name          = "allow-ssh-via-iap"
      description   = "Allow SSH via IAP"
      direction     = "INGRESS"
      priority      = 1000
      source_ranges = ["35.235.240.0/20"]
      target_tags   = []
      allow = [
        {
          protocol = "tcp"
          ports    = ["22"]
        }
      ]
    },
    {
      name          = "allow-internal"
      description   = "Allow internal traffic"
      direction     = "INGRESS"
      priority      = 1000
      source_ranges = ["10.0.0.0/8"]
      target_tags   = []
      allow = [
        {
          protocol = "all"
          ports    = []
        }
      ]
    },
    {
      name               = "allow-egress-mongodb"
      description        = "Allow all egress from MongoDB VM"
      direction          = "EGRESS"
      priority           = 1000
      destination_ranges = ["0.0.0.0/0"]
      target_tags        = ["mongodb-vm"]
      allow = [
        {
          protocol = "all"
          ports    = []
        }
      ]
    },
    {
      name          = "allow-cloud-run-to-mongodb"
      description   = "Allow ingress from Cloud Run to MongoDB"
      direction     = "INGRESS"
      priority      = 1000
      source_tags   = ["cloud-run-service"]
      target_tags   = ["mongodb-vm"]
      allow = [
        {
          protocol = "tcp"
          ports    = ["27017"]
        }
      ]
    }
  ]
}
