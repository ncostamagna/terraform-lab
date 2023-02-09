resource "aws_key_pair" "class_key" {
    key_name = "class_key"
    public_key = "${file("class_key.pem.pub")}"
}