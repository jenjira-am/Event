page 81000 "Event Scanner Dialog"
{
    Caption = 'Event Barcode scanning';
    Editable = false;
    PageType = NavigatePage;
    SourceTable = "POS Scanner";

    layout
    {
        area(content)
        {
            usercontrol(control; "LS_Central_POS_DeviceDialog")
            {
                ApplicationArea = All;

                trigger AddInReady(data: Text)
                begin
                    OnAddInReady();
                end;


                trigger OnResponseFromAddInEx(type: Text; id: Text; success: Boolean; data: Text)
                begin

                    ScannerResult := false;

                    case (type) of
                        'SCANNER':
                            ResolveAppShellScan(id, success, data);
                        'SCANBARCODEDATA':
                            ResolveBarcodeScan(id, success, data);
                        'SCANNERERROR':
                            Message('Error while scanning barcode - ' + data)
                        else
                            Message('Scan response is not implemented [' + type + ']');
                    end;

                    CurrPage.Close();
                end;

                trigger OnResponseFromAddIn(type: Text; data: Text)
                begin
                end;
            }
        }
    }

    actions
    {

    }

    var
        ScannerString: Text;
        JSONUtil: Codeunit "POS JSON Util";
        ScanDataType: Text;
        ScanDataLabel: Text;
        ScannerResult: Boolean;
        EPOSControler: Codeunit "EPOS Controler";
        POSView: Codeunit "POS View";
        BarcodeScanType: Enum "Barcode Scan Types";

    local procedure ResolveBarcodeScan(id: Text; success: Boolean; data: Text)
    begin
        ScanDataLabel := data;
        ScanDataType := id;

        ScannerResult := true;
    end;

    local procedure ResolveAppShellScan(id: Text; success: Boolean; data: Text)
    var
        DataString: DotNet String;
        EventExternalCommand: Codeunit "Event External Commands";
    begin
        DataString := data;
        ScannerString := DataString;
        ScanDataLabel := JSONUtil.GetValueFromJsonString(ScannerString, 'ScanDataLabel');
        ScanDataType := JSONUtil.GetValueFromJsonString(ScannerString, 'ScanDataType');
        if StrPos(ScanDataLabel, '##HardwareProfile##') > 0 then
            EPOSControler.SetHardwareProfileFromQRCodeData(ScanDataLabel)
        else
            EventExternalCommand.AVScanBarcode(ScanDataLabel);      //AVJTA
        //POSView.ProcessScannerInput(ScanDataLabel);

        ScannerResult := true;
    end;

    local procedure OnAddInReady()
    begin
        case BarcodeScanType of
            "Barcode Scan Types"::AppShellScan:
                CurrPage.control.SendRequestToAddInEx('SCANNER:SCANDATA', '', '');
            "Barcode Scan Types"::BarcodeScan:
                CurrPage.control.SendRequestToAddInEx('SCANNER:SCANBARCODEDATA', '', Rec.AsJSON());
        end;

    end;

    [Scope('OnPrem')]
    procedure SetScannerID(ID: Code[20]; UseBarcodeScanType: Enum "Barcode Scan Types")
    begin
        BarcodeScanType := UseBarcodeScanType;
        Rec.Get(ID);
    end;

    [Scope('OnPrem')]
    procedure GetScanDataLabel(): Text
    begin
        exit(ScanDataLabel);
    end;

    [Scope('OnPrem')]
    procedure GetScanDataType(): Text
    begin
        exit(ScanDataType);
    end;

    [Scope('OnPrem')]
    procedure GetScannerResult(): Boolean
    begin
        exit(ScannerResult);
    end;

}

