NAMESPACE=`grep namespace $1| awk -F "=" '{print $2}' | tr -d '"' | tr -d ' '`

DIR=$(pwd)
cat << EOF > "$DIR/backend.tf"
terraform {
  backend "gcs" {
    bucket  = "`gsutil ls  | grep "backend-" | awk -F "/" '{print $3}'`"
    prefix  = "application_deployment/$NAMESPACE"
  }
}
EOF
cat "$DIR/backend.tf"