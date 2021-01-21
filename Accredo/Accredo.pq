section Accredo;

ExpandColumns = (tbl, col) => 
    let 
        table = Table.ExpandRecordColumn(   tbl,   col,
        Table.ColumnNames(Table.FromRecords(List.Select(Table.Column(tbl,col), each _ <> "" and _ <> null))
   ),
   Table.ColumnNames(Table.FromRecords(List.Select(Table.Column(tbl,col), each _ <> "" and _ <> null))
   ))
in 
    table;

ListToTable = (value) =>
    let 
        tbl = Table.FromList(value, Splitter.SplitByNothing(), null, null, ExtraValues.Error)
    in
        tbl;

shared Connect = (hostname as text, version as text, company as text) => 
    let 
        res = hostname & "/" & version & "/odata4/v1/company('" & company & "')/"
    in
        res;

[DataSource.Kind="Accredo", Publish="Accredo.Publish"]
shared Accredo.Contents = Value.ReplaceType(ScopeImpl, ScopeType);

ScopeType = type function(
    Endpoint as (type text meta [
        Documentation.Description = "Endpoint",
        Documentation.AllowedValues = {
        "APCategory1","APCategory2","APCostCode","APCreditor","APCreditorGroup","APExpenseGroup","APSHCategory1","APSHCategory2",
        "ARCategory1","ARCategory2","ARCustomer","ARCustomerGroup","ARSalesArea","ARSalesGroup","ARSalesPerson",
        "CBBankAccount","CBCategory1","CBCategory2","CBExpenseCode",
        "COAddress","COBankingMedia","COFXCurrency","COCurrencyRateType","COMOCategory1","COMOCategory2","COUser",
        "GLAccount","GLCategory1","GLCategory2","GLSubsidary",
        "ICCategory1","ICCategory2","ICProduct","ICStockGroup","ICUOMGroup",
        "INCategory1","INCategory2","INShipper",
        "JCCategory1","JCCategory2","JCComponent","JCCostCentre","JCJob","JCJobGroup",
        "POAuthorisation","POCategory1","POCategory2"
        }
        ])
        )
        as table meta [
        Documentation.Name = "Accredo Web Services"
    ];

ScopeImpl = (Scope as text) =>
    let        
        json = Json.Document(Extension.Contents("server.json")),
        hostname = json[hostname],
        version = json[version],
        company = json[company],
        res = Connect(hostname, version, company),
        source = Json.Document(Web.Contents(res & Scope))
    in
        ExpandColumns(ListToTable(source[value]), "Column1");

Accredo = [
    Authentication = [
        UsernamePassword = [],
        Implicit = []
    ],
    Label = Extension.LoadString("DataSourceLabel")
];

Accredo.Publish = [
    Beta = true,
    Category = "Other",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://powerbi.microsoft.com/",
    SourceImage = Accredo.Icons,
    SourceTypeImage = Accredo.Icons
];

Accredo.Icons = [
    Icon16 = { Extension.Contents("Accredo16.png"), Extension.Contents("Accredo20.png"), Extension.Contents("Accredo24.png"), Extension.Contents("Accredo32.png") },
    Icon32 = { Extension.Contents("Accredo32.png"), Extension.Contents("Accredo40.png"), Extension.Contents("Accredo48.png"), Extension.Contents("Accredo64.png") }
];
