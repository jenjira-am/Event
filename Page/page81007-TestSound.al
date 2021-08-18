page 81007 "Test Sound"
{
    Caption = 'Test Sound';
    PageType = Card;
    SourceTable = Item;

    layout
    {
        area(Content)
        {
            usercontrol(TestSound; TestSound)
            {
                ApplicationArea = all;
                trigger Ready()
                begin
                    CurrPage.TestSound.test2();
                end;
            }

            field("No."; "No.")
            {
                ApplicationArea = All;
            }
            field(Description; Description)
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CurrPage.TestSound.embedHomePage();
                end;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Test)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.TestSound.embedHomePage();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin

    end;


}

/*User Contraol.al*/

controladdin TestSound
{
    RequestedHeight = 300;
    MinimumHeight = 300;
    MaximumHeight = 300;
    RequestedWidth = 700;
    MinimumWidth = 700;
    MaximumWidth = 700;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;
    Scripts = 'main2.js';
    StartupScript = 'start.js';

    event Ready();
    procedure embedHomePage();
    procedure test2();
}
