codeunit 81002 "Test Dll"
{
    procedure AVPrintSalesSlip()
    begin
        Clear(StatusOffline);
        Clear(StatusOther);
        Clear(OpenDrawer);
        Clear(PrintandDrawer);

        PrintandDrawer := PrintandDrawer.OpenCashDrawer;
        PrintandDrawer.GetOpendrawer('EPSON TM-T82 Receipt', StatusOffline, StatusOther, OpenDrawer);
        Message('%1 - %2 - %3', StatusOffline, StatusOther, OpenDrawer);
    end;

    var
        [RunOnClient]
        PrintandDrawer: DotNet Printer_CashDrawer;
        StatusOffline: Boolean;
        StatusOther: Text[30];
        OpenDrawer: Boolean;
}


/*
dotnet
{
    assembly("Printer_CashDrawer")
    {
        //Version = '1.0.0.0';
        //Culture = 'neutral';
        //PublicKeyToken = null;

        type("Printer_CashDrawer.OpenCashDrawer"; "Printer_CashDrawer")
        {
        }
    }
}
*/
