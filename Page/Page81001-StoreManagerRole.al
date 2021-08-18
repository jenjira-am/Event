page 81001 "Store Manager RC"
{
    Caption = 'Store Manager Headline';
    PageType = RoleCenter;
    RefreshOnActivate = true;

    layout
    {
        area(rolecenter)
        {
            part(Control10014500; "Restaurant Manager Headline")
            {
                ApplicationArea = all;
                UpdatePropagation = Both;
            }
            part("Store Manager Cues"; "Store Manager Cues")
            {
                ApplicationArea = all;
                Caption = 'Store Metrics';
                UpdatePropagation = Both;
            }
            part("DemoPage"; "Demo Page")
            {
                ApplicationArea = All;
                Caption = 'Test Sign';
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(TestSound)
            {
                ApplicationArea = All;
                Caption = 'TestSound';
                RunObject = Page "Test Sound";
            }
            action("Run POS")
            {
                ApplicationArea = All;
                Caption = 'Run POS';
                RunObject = Page "POS Client";
            }
            action("Current Availability")
            {
                ApplicationArea = all;
                Caption = 'Current Availability';
                Image = NewSalesQuote;
                RunObject = Page "Current Availability";
                RunPageMode = Edit;
                ToolTip = 'Set Current Availabiltiy for items';
            }
        }
        area(processing)
        {
            group("Time Management")
            {
                Caption = 'Time Management';
                Image = New;
                ToolTip = 'Manage staff time';
                action("Time Acceptance")
                {
                    ApplicationArea = all;
                    Caption = 'Time Acceptance';
                    Image = Timesheet;
                    RunObject = Page "Time Acceptance Page";
                    ToolTip = 'Accept staff timesheets.';
                }
            }
            group(New)
            {
                Caption = 'New';
                Image = New;
                action(Customer)
                {
                    AccessByPermission = TableData Customer = IMD;
                    ApplicationArea = All;
                    Caption = 'Customer';
                    Image = Customer;
                    RunObject = Page "Customer Card";
                    RunPageMode = Create;
                    ToolTip = 'Register a new customer.';
                }
                action(Member)
                {
                    AccessByPermission = TableData "Member Contact" = IMD;
                    ApplicationArea = All;
                    Caption = 'Member';
                    Image = Vendor;
                    RunObject = Page "Membership Card";
                    RunPageMode = Create;
                    ToolTip = 'Register a new member.';
                }
                action("Purchase Order")
                {
                    AccessByPermission = TableData "Purchase Header" = IMD;
                    ApplicationArea = All;
                    Caption = 'Purchase Order';
                    Image = Customer;
                    RunObject = Page "Purchase Order";
                    RunPageMode = Create;
                    ToolTip = 'Register a new purchase order.';
                }
                action(Item)
                {
                    AccessByPermission = TableData Item = IMD;
                    ApplicationArea = All;
                    Caption = 'Item';
                    Image = Vendor;
                    RunObject = Page "Hospitality Item Card";
                    RunPageMode = Create;
                    ToolTip = 'Register a new item.';
                }
                action(Recipe)
                {
                    AccessByPermission = TableData Item = IMD;
                    ApplicationArea = All;
                    Caption = 'Recipe';
                    Image = Vendor;
                    RunObject = Page "Recipe Card";
                    RunPageMode = Create;
                    ToolTip = 'Register a new recipe.';
                }
            }
            group("End-of day")
            {
                Caption = 'End-of day';
                action("Calculate Dining Area Statistics")
                {
                    ApplicationArea = All;
                    Caption = 'Calculate Dining Area Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report "Calculate Din. Area Statistics";
                    ToolTip = 'Calculate Dining Area Statistics';
                }
                group(Statements)
                {
                    Caption = 'Statements';
                    Image = ReferenceData;
                    action("Open Statements")
                    {
                        ApplicationArea = All;
                        AccessByPermission = TableData Statement = R;
                        Caption = 'Open Statements';
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        RunObject = Page "Open Statement List";
                        ToolTip = 'View and edit your open statements';
                    }
                    action("Store Open Statements")
                    {
                        ApplicationArea = All;
                        AccessByPermission = TableData Statement = R;
                        Caption = 'Store Open Statements';
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        RunObject = Page "Store Open Statement List";
                        ToolTip = 'View and edit your store open statements';
                    }
                }
                group("Safe Management")
                {
                    Caption = 'Safe Management';
                    Image = ReferenceData;
                    action("Store Safes")
                    {
                        ApplicationArea = All;
                        AccessByPermission = TableData "Store Safe" = R;
                        Caption = 'Store Safes';
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        RunObject = Page "Store Safe List";
                        ToolTip = 'View and edit your store safes';
                    }
                }
            }
            group(Setup)
            {
                Caption = 'Setup';
                Image = Setup;
                action("Hospitality Setup")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "Hospitality Setup" = IMD;
                    Caption = 'Hospitality Setup';
                    Image = CompanyInformation;
                    RunObject = Page "Hospitality Setup";
                    ToolTip = 'Enter default settings for the overview form and control the behaviour and filtering of orders. ';
                }
                action("Hospitality Status Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Hospitality Status Setup';
                    Image = CompanyInformation;
                    RunObject = Page "Hospitality Status Setup";
                    ToolTip = 'Setup types of statuses for tables';
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                action("Best Selling Items")
                {
                    ApplicationArea = All;
                    Caption = 'Best Selling Items';
                    Image = CompanyInformation;
                    RunObject = Report "Bestselling items";
                    ToolTip = 'Generate a report of best selling items.';
                }
                action("Stock Turnover")
                {
                    ApplicationArea = All;
                    Caption = 'Stock Turnover';
                    Image = CompanyInformation;
                    RunObject = Report "Stock turnover";
                    ToolTip = 'Generate a report on stock turnover.';
                }
                action("Shrinkage Item")
                {
                    ApplicationArea = All;
                    Caption = 'Shrinkage Item';
                    Image = CompanyInformation;
                    RunObject = Report "Shrinkage - Item";
                    ToolTip = 'Generate a report on shrinkage items.';
                }
                action("Store Analysis")
                {
                    ApplicationArea = All;
                    Caption = 'Store Analysis';
                    Image = CompanyInformation;
                    RunObject = Report "Store Analysis Excel";
                    ToolTip = 'Generate a report on store analysis.';
                }
            }
        }
        /*
        area(embedding)
        {
            ToolTip = 'Manage your business. See KPIs, trial balance, and favorite customers.';
            action(Restaurants)
            {
                ApplicationArea = All;
                Caption = 'Restaurants';
                RunObject = Page "Restaurant List";
            }
            action(Recipes)
            {
                ApplicationArea = All;
                Caption = 'Recipes';
                RunObject = Page "Recipe List";
            }
            action(Vendors)
            {
                ApplicationArea = All;
                Caption = 'Vendors';
                RunObject = Page "Vendor List";
            }
            action("Dining Areas")
            {
                ApplicationArea = All;
                Caption = 'Dining Areas';
                RunObject = Page "Dining Areas";
            }
            action("Staff Roster")
            {
                ApplicationArea = All;
                Caption = 'Staff Roster';
                RunObject = Page "Staff Roster";
            }
        }
        */
        area(sections)
        {
            group(Restaurant)
            {
                Caption = 'Store';
                Image = Journals;
                ToolTip = 'Manage your restaurant';

                action("Store")
                {
                    ApplicationArea = All;
                    Caption = 'Store';
                    RunObject = Page "Store List";
                }
                action("POS Terminals")
                {
                    ApplicationArea = All;
                    Caption = 'POS Terminals';
                    RunObject = Page "POS Terminals";
                }
            }

            group(Staff)
            {
                Caption = 'Staff';
                Image = AdministrationSalesPurchases;
                ToolTip = 'Manage staff.';
                action("StaffList")
                {
                    ApplicationArea = All;
                    Caption = 'Staff List';
                    RunObject = Page "LSC Staff List";
                }
                action("Staff Permission")
                {
                    ApplicationArea = All;
                    Caption = 'Staff Permission';
                    RunObject = Page "Staff Permissions Group List";
                }
            }

        }
    }
}

