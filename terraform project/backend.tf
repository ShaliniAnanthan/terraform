terraform{
   backend "gcs" {
       bucket = "gcptfstate1"
       prefix= "terraform-demo/tfstate"
       credentials = "gcp-accounts.json"
   }
}