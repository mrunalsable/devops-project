output "jenkins_public_ip" {
  description = "Public IP of Jenkins server"
  value       = aws_instance.jenkins.public_ip
}

output "jenkins_public_dns" {
  description = "Public DNS of Jenkins server"
  value       = aws_instance.jenkins.public_dns
}

output "k8s_public_ip" {
  description = "Public IP of K3s server"
  value       = aws_instance.k8s.public_ip
}

output "k8s_public_dns" {
  description = "Public DNS of K3s server"
  value       = aws_instance.k8s.public_dns
}

output "ssh_jenkins" {
  description = "SSH command for Jenkins"
  value       = "ssh -i ~/.ssh/devops-project ubuntu@${aws_instance.jenkins.public_ip}"
}

output "ssh_k8s" {
  description = "SSH command for K3s"
  value       = "ssh -i ~/.ssh/devops-project ubuntu@${aws_instance.k8s.public_ip}"
}
