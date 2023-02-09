#resource "aws_iam_group" "administradores" {
#  name = "nahuel_administradores"
#}
#
#resource "aws_iam_policy_attachment" "admins-attach" {
#    name = "nahuel-admins-attach"
#    groups = ["${aws_iam_group.administradores.name}"]
#
#    #que tipo de politica
#    policy_arn = "arn:aws:iam::aws:policy/job-function/SystemAdministrator"
#}
#
#resource "aws_iam_user" "nahuel_admin1" {
#    name = "nahuel_admin1"
#}
#
#resource "aws_iam_user" "nahuel_admin2" {
#    name = "nahuel_admin2"
#}
#
##agregamos usuarios al grupo
#resource "aws_iam_group_membership" "nahuel-admins-user" {
#    name = "nahuel-admins-user"
#    users = [
#        "${aws_iam_user.nahuel_admin1.name}",
#        "${aws_iam_user.nahuel_admin2.name}",
#    ]
#    group = "${aws_iam_group.administradores.name}"
#}
#
#resource "aws_iam_access_key" "nahuel-admin1-access" {
#    user = "${aws_iam_user.nahuel_admin1.name}"
#}
#resource "aws_iam_access_key" "nahuel-admin2-access" {
#    user = "${aws_iam_user.nahuel_admin2.name}"
#}
#
#output "nahuel_admin1_access_key" {
#  value = "${aws_iam_access_key.nahuel-admin1-access.id}"
#}
#output "nahuel_admin1_secret_key" {
#  value = "${aws_iam_access_key.nahuel-admin1-access.secret}"
#}
#output "nahuel_admin2_access_key" {
#  value = "${aws_iam_access_key.nahuel-admin2-access.id}"
#}
#output "nahuel_admin2_secret_key" {
#  #No lo muestra
#  value = "${aws_iam_access_key.nahuel-admin2-access.encrypted_secret}"
#}