resource "azurerm_resource_group" "res-0" {
  location = "westeurope"
  name     = "DefaultResourceGroup-WEU"
}
resource "azurerm_log_analytics_workspace" "res-1" {
  location            = "westeurope"
  name                = "DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  resource_group_name = "DefaultResourceGroup-WEU"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-2" {
  category                   = "General Exploration"
  display_name               = "All Computers with their most recent data"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_General|AlphabeticallySortedComputers"
  query                      = "search not(ObjectName == \"Advisor Metrics\" or ObjectName == \"ManagedSpace\") | summarize AggregatedValue = max(TimeGenerated) by Computer | limit 500000 | sort by Computer asc\r\n// Oql: NOT(ObjectName=\"Advisor Metrics\" OR ObjectName=ManagedSpace) | measure max(TimeGenerated) by Computer | top 500000 | Sort Computer // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-3" {
  category                   = "General Exploration"
  display_name               = "Stale Computers (data older than 24 hours)"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_General|StaleComputers"
  query                      = "search not(ObjectName == \"Advisor Metrics\" or ObjectName == \"ManagedSpace\") | summarize lastdata = max(TimeGenerated) by Computer | limit 500000 | where lastdata < ago(24h)\r\n// Oql: NOT(ObjectName=\"Advisor Metrics\" OR ObjectName=ManagedSpace) | measure max(TimeGenerated) as lastdata by Computer | top 500000 | where lastdata < NOW-24HOURS // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-4" {
  category                   = "General Exploration"
  display_name               = "Which Management Group is generating the most data points?"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_General|dataPointsPerManagementGroup"
  query                      = "search * | summarize AggregatedValue = count() by ManagementGroupName\r\n// Oql: * | Measure count() by ManagementGroupName // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-5" {
  category                   = "General Exploration"
  display_name               = "Distribution of data Types"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_General|dataTypeDistribution"
  query                      = "search * | extend Type = $table | summarize AggregatedValue = count() by Type\r\n// Oql: * | Measure count() by Type // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-6" {
  category                   = "Log Management"
  display_name               = "All Events"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|AllEvents"
  query                      = "Event | sort by TimeGenerated desc\r\n// Oql: Type=Event // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-7" {
  category                   = "Log Management"
  display_name               = "All Syslogs"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|AllSyslog"
  query                      = "Syslog | sort by TimeGenerated desc\r\n// Oql: Type=Syslog // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-8" {
  category                   = "Log Management"
  display_name               = "All Syslog Records grouped by Facility"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|AllSyslogByFacility"
  query                      = "Syslog | summarize AggregatedValue = count() by Facility\r\n// Oql: Type=Syslog | Measure count() by Facility // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-9" {
  category                   = "Log Management"
  display_name               = "All Syslog Records grouped by ProcessName"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|AllSyslogByProcessName"
  query                      = "Syslog | summarize AggregatedValue = count() by ProcessName\r\n// Oql: Type=Syslog | Measure count() by ProcessName // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-10" {
  category                   = "Log Management"
  display_name               = "All Syslog Records with Errors"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|AllSyslogsWithErrors"
  query                      = "Syslog | where SeverityLevel == \"error\" | sort by TimeGenerated desc\r\n// Oql: Type=Syslog SeverityLevel=error // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-11" {
  category                   = "Log Management"
  display_name               = "Average HTTP Request time by Client IP Address"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|AverageHTTPRequestTimeByClientIPAddress"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = avg(TimeTaken) by cIP\r\n// Oql: Type=W3CIISLog | Measure Avg(TimeTaken) by cIP // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-12" {
  category                   = "Log Management"
  display_name               = "Average HTTP Request time by HTTP Method"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|AverageHTTPRequestTimeHTTPMethod"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = avg(TimeTaken) by csMethod\r\n// Oql: Type=W3CIISLog | Measure Avg(TimeTaken) by csMethod // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-13" {
  category                   = "Log Management"
  display_name               = "Count of IIS Log Entries by Client IP Address"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|CountIISLogEntriesClientIPAddress"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by cIP\r\n// Oql: Type=W3CIISLog | Measure count() by cIP // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-14" {
  category                   = "Log Management"
  display_name               = "Count of IIS Log Entries by HTTP Request Method"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|CountIISLogEntriesHTTPRequestMethod"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by csMethod\r\n// Oql: Type=W3CIISLog | Measure count() by csMethod // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-15" {
  category                   = "Log Management"
  display_name               = "Count of IIS Log Entries by HTTP User Agent"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|CountIISLogEntriesHTTPUserAgent"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by csUserAgent\r\n// Oql: Type=W3CIISLog | Measure count() by csUserAgent // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-16" {
  category                   = "Log Management"
  display_name               = "Count of IIS Log Entries by Host requested by client"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|CountOfIISLogEntriesByHostRequestedByClient"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by csHost\r\n// Oql: Type=W3CIISLog | Measure count() by csHost // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-17" {
  category                   = "Log Management"
  display_name               = "Count of IIS Log Entries by URL for the host \"www.contoso.com\" (replace with your own)"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|CountOfIISLogEntriesByURLForHost"
  query                      = "search csHost == \"www.contoso.com\" | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by csUriStem\r\n// Oql: Type=W3CIISLog csHost=\"www.contoso.com\" | Measure count() by csUriStem // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-18" {
  category                   = "Log Management"
  display_name               = "Count of IIS Log Entries by URL requested by client (without query strings)"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|CountOfIISLogEntriesByURLRequestedByClient"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by csUriStem\r\n// Oql: Type=W3CIISLog | Measure count() by csUriStem // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-19" {
  category                   = "Log Management"
  display_name               = "Count of Events with level \"Warning\" grouped by Event ID"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|CountOfWarningEvents"
  query                      = "Event | where EventLevelName == \"warning\" | summarize AggregatedValue = count() by EventID\r\n// Oql: Type=Event EventLevelName=warning | Measure count() by EventID // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-20" {
  category                   = "Log Management"
  display_name               = "Shows breakdown of response codes"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|DisplayBreakdownRespondCodes"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by scStatus\r\n// Oql: Type=W3CIISLog | Measure count() by scStatus // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-21" {
  category                   = "Log Management"
  display_name               = "Count of Events grouped by Event Log"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|EventsByEventLog"
  query                      = "Event | summarize AggregatedValue = count() by EventLog\r\n// Oql: Type=Event | Measure count() by EventLog // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-22" {
  category                   = "Log Management"
  display_name               = "Count of Events grouped by Event Source"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|EventsByEventSource"
  query                      = "Event | summarize AggregatedValue = count() by Source\r\n// Oql: Type=Event | Measure count() by Source // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-23" {
  category                   = "Log Management"
  display_name               = "Count of Events grouped by Event ID"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|EventsByEventsID"
  query                      = "Event | summarize AggregatedValue = count() by EventID\r\n// Oql: Type=Event | Measure count() by EventID // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-24" {
  category                   = "Log Management"
  display_name               = "Events in the Operations Manager Event Log whose Event ID is in the range between 2000 and 3000"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|EventsInOMBetween2000to3000"
  query                      = "Event | where EventLog == \"Operations Manager\" and EventID >= 2000 and EventID <= 3000 | sort by TimeGenerated desc\r\n// Oql: Type=Event EventLog=\"Operations Manager\" EventID:[2000..3000] // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-25" {
  category                   = "Log Management"
  display_name               = "Count of Events containing the word \"started\" grouped by EventID"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|EventsWithStartedinEventID"
  query                      = "search in (Event) \"started\" | summarize AggregatedValue = count() by EventID\r\n// Oql: Type=Event \"started\" | Measure count() by EventID // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-26" {
  category                   = "Log Management"
  display_name               = "Find the maximum time taken for each page"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|FindMaximumTimeTakenForEachPage"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = max(TimeTaken) by csUriStem\r\n// Oql: Type=W3CIISLog | Measure Max(TimeTaken) by csUriStem // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-27" {
  category                   = "Log Management"
  display_name               = "IIS Log Entries for a specific client IP Address (replace with your own)"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|IISLogEntriesForClientIP"
  query                      = "search cIP == \"192.168.0.1\" | extend Type = $table | where Type == W3CIISLog | sort by TimeGenerated desc | project csUriStem, scBytes, csBytes, TimeTaken, scStatus\r\n// Oql: Type=W3CIISLog cIP=\"192.168.0.1\" | Select csUriStem,scBytes,csBytes,TimeTaken,scStatus // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-28" {
  category                   = "Log Management"
  display_name               = "All IIS Log Entries"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|ListAllIISLogEntries"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | sort by TimeGenerated desc\r\n// Oql: Type=W3CIISLog // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-29" {
  category                   = "Log Management"
  display_name               = "How many connections to Operations Manager's SDK service by day"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|NoOfConnectionsToOMSDKService"
  query                      = "Event | where EventID == 26328 and EventLog == \"Operations Manager\" | summarize AggregatedValue = count() by bin(TimeGenerated, 1d) | sort by TimeGenerated desc\r\n// Oql: Type=Event EventID=26328 EventLog=\"Operations Manager\" | Measure count() interval 1DAY // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-30" {
  category                   = "Log Management"
  display_name               = "When did my servers initiate restart?"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|ServerRestartTime"
  query                      = "search in (Event) \"shutdown\" and EventLog == \"System\" and Source == \"User32\" and EventID == 1074 | sort by TimeGenerated desc | project TimeGenerated, Computer\r\n// Oql: shutdown Type=Event EventLog=System Source=User32 EventID=1074 | Select TimeGenerated,Computer // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-31" {
  category                   = "Log Management"
  display_name               = "Shows which pages people are getting a 404 for"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|Show404PagesList"
  query                      = "search scStatus == 404 | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by csUriStem\r\n// Oql: Type=W3CIISLog scStatus=404 | Measure count() by csUriStem // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-32" {
  category                   = "Log Management"
  display_name               = "Shows servers that are throwing internal server error"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|ShowServersThrowingInternalServerError"
  query                      = "search scStatus == 500 | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by sComputerName\r\n// Oql: Type=W3CIISLog scStatus=500 | Measure count() by sComputerName // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-33" {
  category                   = "Log Management"
  display_name               = "Total Bytes received by each Azure Role Instance"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|TotalBytesReceivedByEachAzureRoleInstance"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = sum(csBytes) by RoleInstance\r\n// Oql: Type=W3CIISLog | Measure Sum(csBytes) by RoleInstance // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-34" {
  category                   = "Log Management"
  display_name               = "Total Bytes received by each IIS Computer"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|TotalBytesReceivedByEachIISComputer"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = sum(csBytes) by Computer | limit 500000\r\n// Oql: Type=W3CIISLog | Measure Sum(csBytes) by Computer | top 500000 // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-35" {
  category                   = "Log Management"
  display_name               = "Total Bytes responded back to clients by Client IP Address"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|TotalBytesRespondedToClientsByClientIPAddress"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = sum(scBytes) by cIP\r\n// Oql: Type=W3CIISLog | Measure Sum(scBytes) by cIP // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-36" {
  category                   = "Log Management"
  display_name               = "Total Bytes responded back to clients by each IIS ServerIP Address"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|TotalBytesRespondedToClientsByEachIISServerIPAddress"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = sum(scBytes) by sIP\r\n// Oql: Type=W3CIISLog | Measure Sum(scBytes) by sIP // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-37" {
  category                   = "Log Management"
  display_name               = "Total Bytes sent by Client IP Address"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|TotalBytesSentByClientIPAddress"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = sum(csBytes) by cIP\r\n// Oql: Type=W3CIISLog | Measure Sum(csBytes) by cIP // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-38" {
  category                   = "Log Management"
  display_name               = "All Events with level \"Warning\""
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|WarningEvents"
  query                      = "Event | where EventLevelName == \"warning\" | sort by TimeGenerated desc\r\n// Oql: Type=Event EventLevelName=warning // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-39" {
  category                   = "Log Management"
  display_name               = "Windows Firewall Policy settings have changed"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|WindowsFireawallPolicySettingsChanged"
  query                      = "Event | where EventLog == \"Microsoft-Windows-Windows Firewall With Advanced Security/Firewall\" and EventID == 2008 | sort by TimeGenerated desc\r\n// Oql: Type=Event EventLog=\"Microsoft-Windows-Windows Firewall With Advanced Security/Firewall\" EventID=2008 // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_log_analytics_saved_search" "res-40" {
  category                   = "Log Management"
  display_name               = "On which machines and how many times have Windows Firewall Policy settings changed"
  log_analytics_workspace_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU"
  name                       = "LogManagement(DefaultWorkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-WEU)_LogManagement|WindowsFireawallPolicySettingsChangedByMachines"
  query                      = "Event | where EventLog == \"Microsoft-Windows-Windows Firewall With Advanced Security/Firewall\" and EventID == 2008 | summarize AggregatedValue = count() by Computer | limit 500000\r\n// Oql: Type=Event EventLog=\"Microsoft-Windows-Windows Firewall With Advanced Security/Firewall\" EventID=2008 | measure count() by Computer | top 500000 // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  depends_on = [
    azurerm_log_analytics_workspace.res-1,
  ]
}
resource "azurerm_storage_account" "res-446" {
  account_replication_type  = "RAGRS"
  account_tier              = "Standard"
  location                  = "westeurope"
  name                      = "storagetestxsec"
  queue_encryption_key_type = "Account"
  resource_group_name       = "DefaultResourceGroup-WEU"
  table_encryption_key_type = "Account"
  customer_managed_key {
    key_vault_key_id          = "https://keyvaultencryptionxsec.vault.azure.net/keys/TestKey"
    user_assigned_identity_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/learn-vault/providers/Microsoft.ManagedIdentity/userAssignedIdentities/keystoragetalker"
  }
  identity {
    identity_ids = ["/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/learn-vault/providers/Microsoft.ManagedIdentity/userAssignedIdentities/keystoragetalker"]
    type         = "SystemAssigned, UserAssigned"
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_storage_container" "res-448" {
  container_access_type = "container"
  name                  = "testblob"
  storage_account_name  = "storagetestxsec"
}
resource "azurerm_storage_encryption_scope" "res-449" {
  key_vault_key_id   = "https://keyvaultencryptionxsec.vault.azure.net/keys/TestKey"
  name               = "Encryptionscope1"
  source             = "Microsoft.KeyVault"
  storage_account_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.Storage/storageAccounts/storagetestxsec"
  depends_on = [
    azurerm_storage_account.res-446,
  ]
}
resource "azurerm_storage_encryption_scope" "res-450" {
  key_vault_key_id   = "https://keyvaultencryptionxsec.vault.azure.net/keys/TestKey"
  name               = "Encryptionscope2"
  source             = "Microsoft.KeyVault"
  storage_account_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.Storage/storageAccounts/storagetestxsec"
  depends_on = [
    azurerm_storage_account.res-446,
  ]
}
resource "azurerm_storage_share" "res-452" {
  name                 = "testfileshare1"
  quota                = 5120
  storage_account_name = "storagetestxsec"
}
resource "azurerm_storage_account" "res-455" {
  account_replication_type        = "LRS"
  account_tier                    = "Standard"
  allow_nested_items_to_be_public = false
  location                        = "westeurope"
  name                            = "svenstorage104"
  resource_group_name             = "DefaultResourceGroup-WEU"
  tags = {
    ms-resource-usage = "azure-cloud-shell"
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_storage_container" "res-457" {
  name                 = "blobcontainersven"
  storage_account_name = "svenstorage104"
}
resource "azurerm_storage_share" "res-459" {
  name                 = "sven-storage104shell"
  quota                = 6
  storage_account_name = "svenstorage104"
  acl {
    id = "GhostedRecall"
    access_policy {
      permissions = "r"
    }
  }
}
resource "azurerm_storage_account" "res-462" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = "westeurope"
  name                     = "testblobtestxsec"
  resource_group_name      = "DefaultResourceGroup-WEU"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_storage_account" "res-467" {
  account_replication_type  = "RAGRS"
  account_tier              = "Standard"
  location                  = "westeurope"
  name                      = "tsetedzoaccount"
  queue_encryption_key_type = "Account"
  resource_group_name       = "DefaultResourceGroup-WEU"
  table_encryption_key_type = "Account"
  customer_managed_key {
    key_vault_key_id          = "https://keyvaultencryptionxsec.vault.azure.net/keys/TestKey"
    user_assigned_identity_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/learn-vault/providers/Microsoft.ManagedIdentity/userAssignedIdentities/keystoragetalker"
  }
  identity {
    identity_ids = ["/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/learn-vault/providers/Microsoft.ManagedIdentity/userAssignedIdentities/keystoragetalker"]
    type         = "SystemAssigned, UserAssigned"
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_storage_encryption_scope" "res-469" {
  infrastructure_encryption_required = true
  key_vault_key_id                   = "https://keyvaultencryptionxsec.vault.azure.net/keys/TestKey"
  name                               = "edzotestscope"
  source                             = "Microsoft.KeyVault"
  storage_account_id                 = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.Storage/storageAccounts/tsetedzoaccount"
  depends_on = [
    azurerm_storage_account.res-467,
  ]
}
resource "azurerm_log_analytics_solution" "res-473" {
  location              = "westeurope"
  resource_group_name   = "defaultresourcegroup-weu"
  solution_name         = "ContainerInsights"
  workspace_name        = "defaultworkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-weu"
  workspace_resource_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/defaultresourcegroup-weu/providers/Microsoft.OperationalInsights/workspaces/defaultworkspace-1a0d078e-b0e6-432d-89c7-8a75cac664aa-weu"
  plan {
    product   = "OMSGallery/ContainerInsights"
    publisher = "Microsoft"
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
