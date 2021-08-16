page 81004 "Card with Camera Capability"
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
            action(TakePicture)
            {
                Visible = CameraAvailable;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Camera;

                trigger OnAction()
                begin
                    Camera.RequestPictureAsync();
                end;
            }

            action(TakePictureHigh)
            {
                Visible = CameraAvailable;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Camera;

                trigger OnAction()
                begin
                    CameraOptions := CameraOptions.CameraOptions();
                    CameraOptions.Quality := 100;
                    Camera.RequestPictureAsync(CameraOptions);
                end;
            }

            action(TakePictureLow)
            {
                Visible = CameraAvailable;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Camera;

                trigger OnAction()
                begin
                    CameraOptions := CameraOptions.CameraOptions();
                    CameraOptions.Quality := 10;
                    Camera.RequestPictureAsync(CameraOptions);
                end;
            }
        }

    }

    trigger OnOpenPage()
    begin
        // The IsAvailable() enables the camera functionality based on its presence.
        if Camera.IsAvailable() then begin
            Camera := Camera.Create();
            CameraAvailable := True;
        end;
    end;

    // The PictureName contains the name of the file including its extension on the device. 
    // The naming scheme depends on the device platform. 
    // The PictureFilePath contains the path to the picture in a temporary folder on the server for the current user.
    // The PictureAvailable trigger handles the picture for when the camera has captured it and it has been uploaded.
    trigger Camera::PictureAvailable(PictureName: Text; PictureFilePath: Text)
    begin
        IncomingFile.Open(PictureFilePath);
        Message('Picture size: %1', IncomingFile.Len());
        IncomingFile.Close();
        // It is important to clean up by using the File.Erase command to avoid accumulating image files.
        File.Erase(PictureFilePath);
    end;

    var
        [RunOnClient]
        [WithEvents]
        Camera: DotNet UT_CameraProvider;
        CameraOptions: DotNet UT_CameraOptions;
        // Checks whether the current device has a camera.
        CameraAvailable: Boolean;
        IncomingFile: File;
}

dotnet
{
    assembly("Microsoft.Dynamics.Nav.ClientExtensions")
    {

        type("Microsoft.Dynamics.Nav.Client.Capabilities.CameraProvider"; "UT_CameraProvider")
        {

        }

        type("Microsoft.Dynamics.Nav.Client.Capabilities.CameraOptions"; "UT_CameraOptions")
        {

        }
    }
}