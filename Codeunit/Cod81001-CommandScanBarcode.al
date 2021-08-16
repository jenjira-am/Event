codeunit 81001 "Command Scan Barcode"
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

        InitMenu(Rec);
        CASE Rec.Command OF
            'AVMOBILESCAN':
                PAGE.RunModal(81000);
            'AVSCANSEARCHMEMBER':
                Page.RunModal(81003);

        END;
        Rec := GlobalRec;
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

    var
        ItemTemp_g: Record Item temporary;
        RecRef_g: RecordRef;
        PosCtrl_g: Codeunit "EPOS Control Interface";

}