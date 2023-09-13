resource "aws_efs_file_system" "efs" {
  creation_token   = "dev-efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = false
  lifecycle_policy {
    transition_to_ia = "AFTER_7_DAYS"
  }
  tags = {
    Name = "dev-efs"
  }
}

resource "aws_efs_mount_target" "mount_target_efs" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_subnet.private_subnets_AZ1[1].id
  security_groups = [aws_security_group.efs_security_group.id]
}