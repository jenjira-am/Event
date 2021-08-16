codeunit 81000 "Event External Commands"
{
    SingleInstance = true;
    TableNo = "POS Menu Line";

    var
        GlobalRec: Record "POS Menu Line";
        POSTerminal: Record "POS Terminal";
        StoreSetup: Record Store;
        PosFuncProfile: Record "POS Functionality Profile";
        PosTrans: Record "POS Transaction";
        POSTransFound: Boolean;
        Globals: Codeunit "POS Session";
        sl: Record "POS Trans. Line";
        POSCommandRegistration: Codeunit "POS Command Registration";
        Text001: TextConst ENU = 'Event AVision Commands';
        EPosCtrlInterface: Codeunit "EPOS Control Interface";

    trigger OnRun()
    begin
        GlobalRec := Rec;
        IF Rec."Registration Mode" THEN
            Register(Rec)
        ELSE BEGIN
            InitMenu(Rec);
            CASE Rec.Command OF
                'CUSTOM':
                    case Rec.Parameter of
                        'AVSEARCHITEMINFO':
                            ItemInformationforEvent();
                    end;
                'AVSHOWPANELITEMINFO':
                    ShowPanelItemInfo();
            END;
            Rec := GlobalRec;
        END;
    end;

    procedure Register(VAR MenuLine: Record "POS Menu Line")
    var
        Module: Code[20];
    begin
        Module := 'Event Avision';
        POSCommandRegistration.RegisterModule(Module, Text001, 81000);
        //POSCommandRegistration.RegisterExtCommand('AVSEARCHITEMINFO', 'Search Item Information', 81000, 0, Module, FALSE);
        //POSCommandRegistration.RegisterExtCommand('AVSHOWPANELITEMINFO', 'Show Panel Item Information', 81000, 0, Module, FALSE);
        //POSCommandRegistration.RegisterExtCommand('AVMOBILESCAN', 'Mobile Scan', 81001, 0, Module, FALSE);
        POSCommandRegistration.RegisterExtCommand('AVSCANSEARCHMEMBER', 'Mobile Scan Member', 81001, 0, Module, FALSE);

        MenuLine."Registration Mode" := FALSE;
    end;

    local procedure InitMenu(VAR POSMenuLine: Record "POS Menu Line")
    begin
        POSTerminal.GET(Globals.TerminalNo);

        StoreSetup.GET(POSTerminal."Store No.");
        PosFuncProfile.GET(Globals.FunctionalityProfileID);

        POSTransFound := TRUE;
        IF PosTrans.GET(POSMenuLine."Current-RECEIPT") THEN BEGIN
            IF sl.GET(PosTrans."Receipt No.", POSMenuLine."Current-LINE") THEN;
        END ELSE
            POSTransFound := FALSE;
    end;

    procedure ItemInformationforEvent()
    var
        ItemFilterTB: Record Item;
        Barcodes: Record Barcodes;
        DivisionTB: Record Division;
        ItemCateTB: Record "Item Category";
        RetailProductTB: Record "Retail Product Group";
        PeriodicDisc: Record "Periodic Discount";
        PeriodicDiscLine: Record "Periodic Discount Line";
    begin
        Clear(ScanBarcode);
        PosCtrl_g.GetRecordZoomData(RecRef_g, '#INFOITEMZOOM');
        RecRef_g.SetTable(ItemTemp_g);
        ScanBarcode := ItemTemp_g."Search Description";

        Clear(ItemTemp_g);
        RecRef_g.GetTable(ItemTemp_g);
        PosCtrl_g.ShowRecordZoom(RecRef_g, '#INFOITEMZOOM', '#INFOITEMEDIT', true);

        if ScanBarcode <> '' then begin
            Clear(Barcodes);
            if Barcodes.Get(UpperCase(ScanBarcode)) then begin
                Clear(ItemFilterTB);
                if ItemFilterTB.Get(Barcodes."Item No.") then begin
                    Clear(DivisionTB);
                    if DivisionTB.Get(ItemFilterTB."Division Code") then;

                    Clear(ItemCateTB);
                    if ItemCateTB.Get(ItemFilterTB."Item Category Code") then;

                    Clear(RetailProductTB);
                    if RetailProductTB.Get(ItemFilterTB."Item Category Code", ItemFilterTB."Retail Product Code") then;

                    Clear(PeriodicDiscLine);
                    PeriodicDiscLine.SetRange(Type, PeriodicDiscLine.Type::Item);
                    PeriodicDiscLine.SetRange("No.", ItemFilterTB."No.");
                    PeriodicDiscLine.SetRange(Status, PeriodicDiscLine.Status::Enabled);
                    if PeriodicDiscLine.FindFirst() then begin
                        Clear(PeriodicDisc);
                        if PeriodicDisc.Get(PeriodicDiscLine."Offer No.") then;
                    end;

                    ItemTemp_g := ItemFilterTB;
                    ItemTemp_g."Search Description" := ScanBarcode;
                    ItemTemp_g."No." := Barcodes."Item No.";
                    ItemTemp_g.Description := ItemFilterTB.Description;
                    ItemTemp_g."Description 2" := DivisionTB.Description;
                    ItemTemp_g."Vendor Item No." := ItemCateTB.Description;
                    ItemTemp_g."Block Reason" := RetailProductTB.Description;
                    ItemTemp_g."Lot No. Filter" := PeriodicDisc.Description;
                    RecRef_g.GetTable(ItemTemp_g);
                    PosCtrl_g.ShowRecordZoom(RecRef_g, '#INFOITEMZOOM', '#INFOITEMEDIT', true);
                end;
            end else begin
                PosCtrl_g.PosMessage('Barcodes not found.');
                exit;
            end;
        end else begin
            PosCtrl_g.PosMessage('Enter search criteria.');
            exit;
        end;
    end;

    procedure ShowPanelItemInfo()
    begin
        Clear(ItemTemp_g);
        RecRef_g.GetTable(ItemTemp_g);
        PosCtrl_g.ShowRecordZoom(RecRef_g, '#INFOITEMZOOM', '#INFOITEMEDIT', true);
        PosCtrl_g.ShowPanelModal('#ITEMINFOMATION');
    end;

    procedure AVScanBarcode(ScanDataLabel: Text)
    begin
        Clear(ItemTemp_g);
        ItemTemp_g."Search Description" := ScanDataLabel;

        RecRef_g.GetTable(ItemTemp_g);
        PosCtrl_g.ShowRecordZoom(RecRef_g, '#INFOITEMZOOM', '#INFOITEMEDIT', true);
        ItemInformationforEvent;
    end;

    procedure AVScanMemberCard(ScanDataLabel: Text)
    var
        POSTransaction: Codeunit "POS Transaction";
    begin
        Clear(POSTransaction);
        POSTransaction.InputMemberCard(ScanDataLabel);
    end;

    var
        ItemTemp_g: Record Item temporary;
        RecRef_g: RecordRef;
        PosCtrl_g: Codeunit "EPOS Control Interface";
        ScanBarcode: Text[100];

}