pageextension 81000 RetailItemList extends "Retail Item List"
{

    actions
    {
        addlast("F&unctions")
        {
            action(TakePicture)
            {
                Visible = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Camera;

                trigger OnAction()
                begin
                    Page.Run(81004);
                end;
            }

            action(GetLocation)
            {
                Visible = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Camera;

                trigger OnAction()
                begin
                    Page.Run(81005);
                end;
            }
        }
    }

    var
        myInt: Integer;
}