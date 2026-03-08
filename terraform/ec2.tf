# ── Jenkins + Docker EC2 ──────────────────────────
resource "aws_instance" "jenkins" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.jenkins.id]
  key_name               = var.key_name

  root_block_device {
    volume_size = 20
    volume_type = "gp2"
  }

  tags = {
    Name    = "${var.project_name}-jenkins"
    Role    = "jenkins"
    Project = var.project_name
  }
}

# ── K3s Kubernetes EC2 ────────────────────────────
resource "aws_instance" "k8s" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.k8s.id]
  key_name               = var.key_name

  root_block_device {
    volume_size = 20
    volume_type = "gp2"
  }

  tags = {
    Name    = "${var.project_name}-k8s"
    Role    = "kubernetes"
    Project = var.project_name
  }
}
