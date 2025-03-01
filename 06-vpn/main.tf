#Craete Key Pair for login to VPN
resource "aws_key_pair" "openvpn" {
  key_name   = "openvpn"

  # public_key = file("~/.ssh/openvpn.pub")
  public_key = file("openvpn.pub")
  #public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICl6tjaPMzCYYR51/5XcWU+0Kx9q6CGV4Vo/ahoQKxLw kdpra@KDP"
}

#Instance VPN
module "openvpn" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  ami = local.ami_id

  name = local.resource_name
  key_name               = aws_key_pair.openvpn.key_name

  instance_type          = "t3.micro"
 
  vpc_security_group_ids = [local.vpn_sg_id]

  subnet_id              = local.public_subnet_id

  tags = merge(
    var.common_tags,

        {
            Name = local.resource_name
        }
  )
}