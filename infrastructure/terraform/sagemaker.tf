# SageMaker endpoint configuration
resource "aws_sagemaker_model" "healthcare_model" {
  name               = "healthcare-prediction-model"
  execution_role_arn = aws_iam_role.sagemaker_role.arn

  primary_container {
    image = "${aws_ecr_repository.model_repository.repository_url}:latest"
    model_data_url = "s3://${aws_s3_bucket.model_bucket.id}/model.tar.gz"
  }
}

resource "aws_sagemaker_endpoint_configuration" "healthcare_endpoint_config" {
  name = "healthcare-endpoint-config"

  production_variants {
    variant_name           = "primary"
    model_name             = aws_sagemaker_model.healthcare_model.name
    initial_instance_count = 2
    instance_type          = "ml.m5.large"
  }
}

resource "aws_sagemaker_endpoint" "healthcare_endpoint" {
  name                 = "healthcare-prediction-endpoint"
  endpoint_config_name = aws_sagemaker_endpoint_configuration.healthcare_endpoint_config.name
}
