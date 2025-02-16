resource "aws_launch_template" "tomcat_lt" {
  name = "tomcat-launch-template"

  image_id      = var.tomcat_ami
  instance_type = var.tomcat_instance_type
  key_name      = var.key_name

  network_interfaces {
    device_index                = 0
    associate_public_ip_address = false
    security_groups             = ["${aws_security_group.tomcat_sg.id}"]
    subnet_id                   = aws_subnet.private_subnet_1.id
  }

  user_data = base64encode(<<EOF
#!/bin/bash
set -eux

# Update Ubuntu packages
sudo apt update && sudo apt upgrade -y

# Install Java 17
sudo apt install -y openjdk-17-jdk

# Download and Install Tomcat (Latest Version)
sudo wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.19/bin/apache-tomcat-10.1.19.tar.gz
tar -xvf apache-tomcat-10.1.19.tar.gz
sudo mv apache-tomcat-10.1.19 /opt/tomcat
sudo chmod +x /opt/tomcat/bin/*.sh

# Create a Tomcat user
sudo useradd -r -m -d /opt/tomcat -s /bin/false tomcat
sudo chown -R tomcat:tomcat /opt/tomcat
sudo bash -c "cat > /etc/systemd/system/tomcat.service <<EOT
[Unit]
Description=Apache Tomcat Server
After=network.target

[Service]
User=tomcat
Group=tomcat
WorkingDirectory=/opt/tomcat
ExecStart=/opt/tomcat/bin/catalina.sh run
ExecStop=/opt/tomcat/bin/shutdown.sh
Restart=always

[Install]
WantedBy=multi-user.target
EOT"

# Reload systemd and start Tomcat
sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl start tomcat

# Install MySQL Server
sudo apt install -y mysql-server

# Secure MySQL installation (you can automate this with debconf-set-selections)
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY 'StrongRootPassword';"
sudo mysql -uroot -p'StrongRootPassword' -e "CREATE DATABASE app_db;"
sudo mysql -uroot -p'StrongRootPassword' -e "GRANT ALL PRIVILEGES ON app_db.* TO 'app_user'@'%' IDENTIFIED BY 'AppUserPassword'; FLUSH PRIVILEGES;"

# Enable and start MySQL service
sudo systemctl enable mysql
sudo systemctl start mysql


EOF
  )
}
