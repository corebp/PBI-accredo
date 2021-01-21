# PBI-accredo
A Power BI connector for Accredo Business Systems using their Web Services module

### Setup
Create a *server.json* file with your Server Hostname, Version (Mercury/Saturn) and Company Name (example in [server.example.json](Accredo/server.example.json))

### Deployment
- Open and build the VS [solution](Accredo.sln).
- Copy [Accredo.mez](Accredo/bin/Debug/Accredo.mez) to My Documents/Power BI Desktop/Custom Connectors
- Start Power BI Desktop
- Ensure Custom Connectors are enabled (File/Options and Settings/Options/Global/Security/Data Extensions)
- Add Accredo(Beta) as new data source, found under Other
