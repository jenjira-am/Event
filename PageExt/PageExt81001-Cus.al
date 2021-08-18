pageextension 81001 CustomerFact extends "Customer List"
{
    layout
    {
        addbefore("Power BI Report FactBox")
        {
            part("DemoPage"; "Demo Page")
            {
                ApplicationArea = All;
                Caption = 'Test Sign';
            }
        }

    }
}