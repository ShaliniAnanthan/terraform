variable "region" {
	type = map(string)
    default ={
        default = "us-west1"
        dev = "us-central1"
        test = "us-east1"
    }
}

variable "zone" {
	type = map(string)
    default ={
        default = "us-west1-a"
        dev = "us-central1-b"
        test = "us-east1-c"
    }
}

variable "subnet_cidr" {
	type = map(string)
    default ={
        default = "10.40.1.0/24"
        dev = "10.50.1.0/24"
        test = "10.60.1.0/24"
    }
}