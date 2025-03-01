#Instance
module "bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = local.ami_id
  name = local.resource_name

  instance_type          = "t3.micro"
 
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id              = local.public_subnet_id

  # connection {
  #   host = module.bastion.private_ip    
  #   type = "ssh"
  #   user = var.user
  #   password = var.password
  # }
  # provisioner "remote-exec"{
  #   inline = [ "sudo dnf install mysql-server -y" ]
  # }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}