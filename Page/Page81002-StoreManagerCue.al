page 81002 "Store Manager Cues"
{
    UsageCategory = Lists;
    ApplicationArea = All;
    PageType = CardPart;
    ShowFilter = false;
    SourceTable = "Restaurant Manager Cues";

    layout
    {
        area(content)
        {
            cuegroup(Control10014506)
            {
                CueGroupLayout = Wide;
                ShowCaption = false;
                field(AVSaleAmt; AVSaleAmt)
                {
                    Caption = 'Sale Amount';
                    Visible = true;
                }
                field(AVDisc; AVDisc)
                {
                    Caption = 'Discount Amount';
                    Visible = true;
                }
                field(AVTotalbill; AVTotalbill)
                {
                    Caption = 'Total Bill';
                    Visible = true;
                }
                field(AVRefundbill; AVRefundbill)
                {
                    Caption = 'Refund Bill';
                    Visible = true;
                }
                field(AVTotalMember; AVTotalMember)
                {
                    Caption = 'Total Member';
                    Visible = true;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        OnRefresh();
        EventTransaction();
    end;

    trigger OnAfterGetRecord()
    begin
        // IF("No. Transactions" <= 1) THEN
        //  ColorVar := 'Unfavorable'
        // ELSE IF("No. Transactions" > 2) THEN
        //  ColorVar := 'Ambiguous'
        // ELSE IF("No. Transactions" > 3) THEN
        //  ColorVar := 'Favorable';
        // IF(TotalSeatCapAvailable <= 10) THEN
        //  SeatCapColorIndicator := 'Unfavorable'
        // ELSE IF((TotalSeatCapAvailable < 80) AND (TotalSeatCapAvailable > 10 )) THEN
        //  SeatCapColorIndicator := 'Ambiguous'
        // ELSE IF(TotalSeatCapAvailable >= 80) THEN
        //  SeatCapColorIndicator := 'Favorable';
    end;

    trigger OnOpenPage()
    begin
        Reset;
        if not Get then begin
            Init;
            Insert;
        end;

        OnRefresh();
        EventTransaction();
    end;

    var
        ShowDateTxt: Text[350];
        DateChoice: Date;
        [InDataSet]
        SeatCapColorIndicator: Text;
        [InDataSet]
        ColorVar: Text;
        DiningAreaId: Text[50];
        DiningAreaId2: Text[50];
        TotalFree: Integer;
        TotalOccupied: Integer;
        TotalGuests: Integer;
        TotalSeatCapAvailable: Integer;
        TotalSeatCap: Integer;
        AmountPerGuest: Decimal;
        RevPASH: Decimal;
        HoursOpen: Decimal;
        SeatHours: Decimal;
        TableTurnover: Decimal;
        StoreFilter: Code[20];
        AVSaleAmt: Decimal;
        AVDisc: Decimal;
        AVTotalbill: Integer;
        AVRefundbill: Integer;
        AVTotalMember: Integer;

    [Scope('OnPrem')]
    procedure OnRefresh()
    var
        RetailUser: Record "Retail User";
        DiningArea: Record "Dining Area";
        Store: Record Store;
        POSTerminal: Record "POS Terminal";
        MinOpen: Decimal;
    begin
        Clear(TotalFree);
        Clear(TotalGuests);
        Clear(TotalOccupied);
        Clear(TotalSeatCap);
        Clear(TotalSeatCapAvailable);
        DateChoice := WorkDate;
        RetailUser.Get(UserId);
        POSTerminal.Get(RetailUser."POS Terminal");
        Store.Get(POSTerminal."Store No.");
        ShowDateTxt := Format(DateChoice);
        StoreFilter := Store."No.";
        DiningArea.SetRange("Restaurant No.", StoreFilter);
        if DiningArea.FindSet then begin
            repeat
                UpdateDiningAreaTotals(DiningArea, MinOpen);
            until DiningArea.Next = 0;
        end;
        HoursOpen := MinOpen / 60;
        SetRange("Date Filter", DateChoice);
        SetRange("Store Filter", RetailUser."Store No.");
        CalculateRestaurantKPIs(RetailUser);
        CurrPage.Update;
    end;

    local procedure UpdateDiningAreaTotals(DiningArea: Record "Dining Area"; var MinOpen: Decimal)
    var
        DiningAreaStatisticsTmp: Record "Dining Area Statistics" temporary;
        DiningAreaTableStatisticsTmp: Record "Dining Area Table Statistics" temporary;
        DiningAreaUtilities: Codeunit "Dining Area Utilities";
        ToDate: DateTime;
        FromDate: DateTime;
        OpenFrom: DateTime;
        OpenTo: DateTime;
        OpeningTime: Decimal;
    begin
        if DiningArea."Use Seating Capacity" then begin
            FromDate := CurrentDateTime;
            DiningAreaUtilities.GetCurrenttDiningAreaStatistics(DiningArea, DiningAreaStatisticsTmp, DiningAreaTableStatisticsTmp, OpenFrom, OpenTo);
            OpeningTime := Round(((OpenTo - OpenFrom) / 60000), 1);
            MinOpen += OpeningTime;
            TotalFree += DiningAreaStatisticsTmp."No. of Free Dining Tables";
            TotalOccupied += DiningAreaStatisticsTmp."No. of Occupied Dining Tables";
            TotalGuests += DiningAreaStatisticsTmp."No. of Guests in Dining Area";
            TotalSeatCap += DiningAreaStatisticsTmp."Total Seat Capacity";
            TotalSeatCapAvailable += DiningAreaStatisticsTmp."Available Seat Capacity";
        end;
    end;

    local procedure CalculateRestaurantKPIs(RetailUser: Record "Retail User")
    var
        DiningReservHistoryEntry: Record "Dining Reserv. History Entry";
    begin
        if Rec.FindFirst then begin
            CalcFields("No. of Seatings", "No. of No-Shows", "No. of Cancellations", "No. of Guests on Waitlist", "Gross Turnover", "No. of Transactions");
            if "Number of Guests for Date" <> 0 then
                AmountPerGuest := "Gross Turnover" / "Number of Guests for Date";
            SeatHours := TotalSeatCap * HoursOpen;
            if SeatHours <> 0 then
                RevPASH := "Gross Turnover" / SeatHours;
            if TotalFree + TotalOccupied <> 0 then
                TableTurnover := "No. of Seatings" / (TotalFree + TotalOccupied);
        end;
    end;

    local procedure EventTransaction()
    var
        Transaction: Record "Transaction Header";
    begin
        Clear(AVSaleAmt);
        Clear(AVDisc);
        Clear(AVRefundbill);
        Clear(AVTotalbill);
        Clear(AVTotalMember);

        Clear(Transaction);
        AVTotalbill := Transaction.Count;
        if Transaction.FindSet() then begin
            Transaction.CalcSums(Payment);
            Transaction.CalcSums("Discount Amount");
        end;

        Transaction.SetFilter("Retrieved from Receipt No.", '<>%1', '');
        AVRefundbill := Transaction.Count;

        Transaction.SetRange("Retrieved from Receipt No.");
        Transaction.SetFilter("Member Card No.", '<>%1', '');
        AVTotalMember := Transaction.Count;

        AVSaleAmt := Transaction.Payment;
        AVDisc := Transaction."Discount Amount";
    end;
}

