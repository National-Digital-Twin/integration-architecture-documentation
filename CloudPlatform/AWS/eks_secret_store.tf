# Deploy AWS Secrets Manager and Config Provider for Secret Store CSI Driver using Helm
resource "helm_release" "secrets-store-csi-driver" {
  name       = "secrets-store-csi-driver"
  repository = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart      = "secrets-store-csi-driver"
  version    = "1.4.8"
  namespace  = "kube-system"

  set {
    name  = "linux.image.repository"
    value = "${local.account_id}.dkr.ecr.${var.region}.amazonaws.com/public-k8s/csi-secrets-store/driver"
  }

  set {
    name  = "linux.crds.image.repository"
    value = "${local.account_id}.dkr.ecr.${var.region}.amazonaws.com/public-k8s/csi-secrets-store/driver-crds"
  }

  set {
    name  = "linux.registrarImage.repository"
    value = "${local.account_id}.dkr.ecr.${var.region}.amazonaws.com/public-k8s/sig-storage/csi-node-driver-registrar" #
  }

  set {
    name  = "linux.livenessProbeImage.repository"
    value = "${local.account_id}.dkr.ecr.${var.region}.amazonaws.com/public-k8s/sig-storage/livenessprobe" #
  }
}

resource "helm_release" "secrets-store-csi-driver-provider-aws" {
  name       = "secrets-store-csi-driver-provider-aws"
  repository = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
  chart      = "secrets-store-csi-driver-provider-aws"
  version    = "0.3.11"
  namespace  = "kube-system"

  set {
    name  = "image.repository"
    value = "${local.account_id}.dkr.ecr.${var.region}.amazonaws.com/public-ecr/aws-secrets-manager/secrets-store-csi-driver-provider-aws"
  }
}

# docker pull 127214183387.dkr.ecr.eu-west-2.amazonaws.com/public-ecr/aws-secrets-manager/secrets-store-csi-driver-provider-aws:1.0.r2-80-g8244505-2025.02.10.18.44
# docker pull 127214183387.dkr.ecr.eu-west-2.amazonaws.com/public-k8s/sig-storage/csi-node-driver-registrar:v2.11.1
# public.ecr.aws/aws-secrets-manager/secrets-store-csi-driver-provider-aws:1.0.r2-80-g8244505-2025.02.10.18.44