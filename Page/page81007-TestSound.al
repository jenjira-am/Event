page 81007 "Test Sound"
{
    Caption = 'Test Sound';
    PageType = Card;
    SourceTable = Item;

    layout
    {

        area(Content)
        {
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
                    FillAddIn();
                end;
            }
            usercontrol(TestSound; TestSound)
            {
                ApplicationArea = all;
                trigger Ready()
                begin
                    //CurrPage.TestSound.test2();
                end;
            }


            usercontrol(UserControlDesc; "Microsoft.Dynamics.Nav.Client.WebPageViewer")
            {
                trigger ControlAddInReady(callbackUrl: Text)
                begin
                    FillAddIn();
                end;

                trigger Callback(data: Text)
                begin
                    Description := data;
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

    trigger OnAfterGetRecord()
    begin
        //FillAddIn();
    end;

    local procedure FillAddIn()
    begin
        CurrPage.UserControlDesc.SetContent(StrSubstNo('<p style="color:blue; font-weight: bold; font-size:70px;">%1</p>', Description));
    end;
}



/*User Contraol.al*/

controladdin TestSound
{

    RequestedHeight = 100;
    MinimumHeight = 100;
    MaximumHeight = 100;
    RequestedWidth = 100;
    MinimumWidth = 100;
    MaximumWidth = 100;

    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;
    Scripts = 'main2.js';
    StartupScript = 'start.js';
    StyleSheets = 'style.css';

    event Ready();
    procedure embedHomePage();
    procedure test2();
}
