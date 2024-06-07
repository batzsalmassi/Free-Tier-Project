terraform {
	backend "s3" {
		bucket = "sean-terraform-project-bucket-backend"
		key = "terraform/seanProject.tfstate"
		region = "us-east-1"
	}
}
