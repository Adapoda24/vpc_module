data "aws_ami" "instance"{
  most_recent = true
  filter {
    name = "name"
    values = var.value
  }
}

resource "aws_instance" "test_inst" {
  ami           = data.aws_ami.instance.id
  instance_type = var.ins_type
  key_name = var.key
  tags = {
    Name=var.tag_name
    env=var.env
  }
}