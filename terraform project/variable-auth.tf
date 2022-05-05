variable "gcp_auth_file" {
	type = map(string)
    default ={
        default = "addthe json file "
        dev = "addthe json file "
        test =  "addthe json file "
    }
}

variable "project_name" {
	type = map(string)
    default ={
        default = "gcp-terraform-348507"
        dev = "gcp-terraform-dev-348811"
        test = "gcp-terraform-test-348811"
    }
}

variable "app_name" {
	type = map(string)
    default ={
        default = "appdefault"
        dev = "appdev"
        test = "apptest"
    }
}


# variable "env_name" {
# 	type = map(string)
#     default ={
#         default = "envdefault"
#         dev = "devenv"
#         test = "testenv"
#     }
# }

variable "machine_type" {
	type = map(string)
    default ={
        default = "e2-micro"
        dev = "e2-micro"
        test = "e2-small"
    }
}
