resource "azurerm_user_assigned_identity" "example" {
  name                = "example-uai"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = "example-workspace"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_log_analytics_solution" "example" {
  solution_name         = "WindowsEventForwarding"
  location              = var.location
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.example.id
  workspace_name        = azurerm_log_analytics_workspace.example.name
  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/WindowsEventForwarding"
  }
}

resource "azurerm_eventhub_namespace" "example" {
  name                = "exeventns"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  capacity            = 1
}

resource "azurerm_eventhub" "example" {
  name                = "exevent2"
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_storage_account" "example" {
  name                     = "examstorage"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example" {
  name                  = "examplecontainer"
  container_access_type = "private"
}

resource "azurerm_monitor_data_collection_endpoint" "example" {
  name                = "example-dcre"
  resource_group_name = var.resource_group_name
  location            = var.location

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_monitor_data_collection_rule" "example" {
  name                        = "example-rule"
  resource_group_name         = var.resource_group_name
  location                    = var.location
  data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.example.id

  destinations {
    log_analytics {
      workspace_resource_id = azurerm_log_analytics_workspace.example.id
      name                  = "example-destination-log"
    }

    event_hub {
      event_hub_id = azurerm_eventhub.example.id
      name         = "example-destination-eventhub"
    }

    storage_blob {
      storage_account_id = azurerm_storage_account.example.id
      container_name     = azurerm_storage_container.example.name
      name               = "example-destination-storage"
    }

    azure_monitor_metrics {
      name = "example-destination-metrics"
    }
  }

  data_flow {
    streams      = ["Microsoft-InsightsMetrics"]
    destinations = ["example-destination-metrics"]
  }

  data_flow {
    streams      = ["Microsoft-InsightsMetrics", "Microsoft-Syslog", "Microsoft-Perf"]
    destinations = ["example-destination-log"]
  }

  data_flow {
    streams       = ["Custom-MyTableRawData"]
    destinations  = ["example-destination-log"]
    output_stream = "Microsoft-Syslog"
    transform_kql = "source | project TimeGenerated = Time, Computer, Message = AdditionalContext"
  }

  data_sources {
    syslog {
      facility_names = ["*"]
      log_levels     = ["*"]
      name           = "example-datasource-syslog"
      streams        = ["Microsoft-Syslog"]
    }

    iis_log {
      streams         = ["Microsoft-W3CIISLog"]
      name            = "example-datasource-iis"
      log_directories = ["C:\\Logs\\W3SVC1"]
    }

    log_file {
      name          = "example-datasource-logfile"
      format        = "text"
      streams       = ["Custom-MyTableRawData"]
      file_patterns = ["C:\\JavaLogs\\*.log"]
      settings {
        text {
          record_start_timestamp_format = "ISO 8601"
        }
      }
    }

    performance_counter {
      streams                       = ["Microsoft-Perf", "Microsoft-InsightsMetrics"]
      sampling_frequency_in_seconds = 60
      counter_specifiers            = ["Processor(*)\\% Processor Time"]
      name                          = "example-datasource-perfcounter"
    }

    windows_event_log {
      streams        = ["Microsoft-WindowsEvent"]
      x_path_queries = ["*![System/Level=1]"]
      name           = "example-datasource-wineventlog"
    }

    extension {
      streams            = ["Microsoft-WindowsEvent"]
      input_data_sources = ["example-datasource-wineventlog"]
      extension_name     = "example-extension-name"
      extension_json = jsonencode({
        a = 1
        b = "hello"
      })
      name = "example-datasource-extension"
    }
  }

  stream_declaration {
    stream_name = "Custom-MyTableRawData"
    column {
      name = "Time"
      type = "datetime"
    }
    column {
      name = "Computer"
      type = "string"
    }
    column {
      name = "AdditionalContext"
      type = "string"
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.example.id]
  }

  description = "data collection rule example"
  tags = {
    foo = "bar"
  }
  depends_on = [
    azurerm_log_analytics_solution.example
  ]
}