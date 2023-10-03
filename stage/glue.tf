resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  create_table_default_permission {
    permissions = ["ALL"]

    principal {
      data_lake_principal_identifier = "IAM_ALLOWED_PRINCIPALS"
    }
  }

  name = var.athena.database_name
}

resource "aws_glue_catalog_table" "aws_glue_catalog_table" {
  name          = "s3_${var.athena.database_name}"
  database_name = var.athena.database_name

  table_type = "EXTERNAL_TABLE"

  parameters = {
    EXTERNAL              = "TRUE"
    # "parquet.compression" = "SNAPPY"
  }

  storage_descriptor {
    location      = "s3://s3-sample5-images1-logs/logs"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      parameters = {
        "input.regex"          = "([^ ]*) ([^ ]*) \\[(.*?)\\] ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) (\"[^\"]*\"|-) (-|[0-9]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) (\"[^\"]*\"|-) ([^ ]*)(?: ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*))?.*$"
        "serialization.format" = "1"
      }

      serialization_library = "org.apache.hadoop.hive.serde2.RegexSerDe"
    }

    columns {
      name = "bucketowner"
      type = "string"
    }

    columns {
      name = "bucket_name"
      type = "string"
    }

    columns {
      name = "requestdatetime"
      type = "string"
    }

    columns {
      name = "remoteip"
      type = "string"
    }

    columns {
      name = "requester"
      type = "string"
    }

    columns {
      name = "requestid"
      type = "string"
    }

    columns {
      name = "operation"
      type = "string"
    }

    columns {
      name = "key"
      type = "string"
    }
  
      columns {
      name = "request_uri"
      type = "string"
    }

    columns {
      name = "httpstatus"
      type = "string"
    }

    columns {
      name = "errorcode"
      type = "string"
    }

    columns {
      name = "bytessent"
      type = "bigint"
    }

    columns {
      name = "objectsize"
      type = "bigint"
    }

    columns {
      name = "totaltime"
      type = "string"
    }

    columns {
      name = "turnaroundtime"
      type = "string"
    }

    columns {
      name = "referrer"
      type = "string"
    }

    columns {
      name = "useragent"
      type = "string"
    }
  
    columns {
      name = "versionid"
      type = "string"
    }

    columns {
      name = "hostid"
      type = "string"
    }
  
    columns {
      name = "sigv"
      type = "string"
    }

    columns {
      name = "ciphersuite"
      type = "string"
    }

    columns {
      name = "authtype"
      type = "string"
    }

    columns {
      name = "endpoint"
      type = "string"
    }

    columns {
      name = "tlsversion"
      type = "string"
    }
  }

  depends_on = [aws_glue_catalog_database.aws_glue_catalog_database]
}