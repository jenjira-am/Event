page 81005 "Card with Location Capability"
{

    Caption = 'Card Page';
    PageType = Card;
    RefreshOnActivate = true;
    //SourceTable = "Test Table";

    layout
    {
        area(content)
        {
            //...
        }
    }

    actions
    {
        area(Processing)
        {
            action(GetLocation)
            {
                Visible = LocationAvailable;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Map;

                trigger OnAction()
                begin
                    LocationOptions := LocationOptions.LocationOptions;
                    LocationOptions.EnableHighAccuracy();
                    Location.RequestLocationAsync();
                end;
            }
            action(CashDrawer)
            {
                Visible = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Camera;

                trigger OnAction()
                begin
                    Clear(StatusOffline);
                    Clear(StatusOther);
                    Clear(OpenDrawer);
                    //Clear(PrintandDrawer);
                    //PrintandDrawer.OpenCashdrawer();
                    //PrintandDrawer := PrintandDrawer.OpenCashDrawer;
                    PrintandDrawer := PrintandDrawer.OpenCashDrawer();
                    PrintandDrawer.GetOpendrawer('EPSON TM-T82 Receipt', StatusOffline, StatusOther, OpenDrawer);
                    Message('%1 - %2 - %3', StatusOffline, StatusOther, OpenDrawer);
                end;
            }
        }



    }

    trigger OnOpenPage()
    begin
        if Location.IsAvailable() then begin
            Location := Location.Create();
            LocationAvailable := true;
        end;
    end;

    trigger Location::LocationChanged(Location: DotNet Location)
    begin
        // Location.Status can be: 
        //      0 = Available 
        //      1 = NoData (no data could be obtained)
        //      2 = TimedOut (location information not obtained in due time)
        //      3 = NotAvailable (for example user denied app access to location)

        if Location.Status = 0 then
            Message('Your position: %1 %2', Location.Coordinate.Latitude, Location.Coordinate.Longitude)
        else
            Message('Position not available');
    end;

    var
        [RunOnClient]
        [WithEvents]
        Location: DotNet LocationProvider;
        LocationAvailable: Boolean;
        LocationOptions: DotNet UT_LocationOptions;
        PrintandDrawer: DotNet Printer_CashDrawer;
        StatusOffline: Boolean;
        StatusOther: Text[30];
        OpenDrawer: Boolean;
}

dotnet
{
    assembly("Microsoft.Dynamics.Nav.ClientExtensions")
    {

        type("Microsoft.Dynamics.Nav.Client.Capabilities.LocationProvider"; LocationProvider)
        {

        }

        type("Microsoft.Dynamics.Nav.Client.Capabilities.Location"; Location)
        {

        }

        type("Microsoft.Dynamics.Nav.Client.Capabilities.LocationOptions"; UT_LocationOptions)
        {

        }
    }

    assembly("Printer_CashDrawer")
    {
        Version = '1.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = null;

        type("Printer_CashDrawer.OpenCashDrawer"; Printer_CashDrawer)
        {
        }
    }
}