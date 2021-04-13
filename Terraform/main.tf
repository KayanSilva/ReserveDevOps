provider "aws" {
  region = "us-east-2"
  alias  = "us-east-2"
}

provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
}

resource "aws_instance" "dev4" {
  count         = 1 # Quantidade de maquinas 
  ami           = var.amis["us-east-2"]
  instance_type = "t2.micro"
  key_name      = var.key_name
  tags = {
    "Name" = "dev${count.index}"
  }
  vpc_security_group_ids = [aws_security_group.acesso-ssh.id]
  depends_on             = [aws_s3_bucket.dev4]
}

resource "aws_instance" "dev5" {
  provider      = aws.us-east-2
  count         = 1 # Quantidade de maquinas 
  ami           = var.amis["us-east-2"]
  instance_type = "t2.micro"
  key_name      = var.key_name
  tags = {
    "Name" = "dev${count.index}"
  }
  vpc_security_group_ids = [aws_security_group.acesso-ssh-us-east-2.id]
  depends_on             = [aws_dynamodb_table.dynamodb-hoologacao]
}

resource "aws_s3_bucket" "dev4" {
  bucket = "kayanlbs-dev4"
  acl    = "private"
  tags = {
    "Name" = "kayanlbs-dev4"
  }
}

resource "aws_dynamodb_table" "dynamodb-hoologacao" {
  provider     = aws.us-east-2
  name         = "GameScores"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"
  range_key    = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}
