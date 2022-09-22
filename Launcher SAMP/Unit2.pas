unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, sSpeedButton, Vcl.StdCtrls,
  sGroupBox, Vcl.ComCtrls, sStatusBar, Vcl.ExtCtrls, sPanel, sEdit, sLabel, System.Win.Registry;

type
  TForm2 = class(TForm)
    sStatusBar1: TsStatusBar;
    sSpeedButton8: TsSpeedButton;
    sGroupBox4: TsGroupBox;
    sPanel1: TsPanel;
    sSpeedButton2: TsSpeedButton;
    sSpeedButton9: TsSpeedButton;
    sGroupBox1: TsGroupBox;
    sPanel3: TsPanel;
    sEdit1: TsEdit;
    sGroupBox2: TsGroupBox;
    sPanel2: TsPanel;
    sSpeedButton1: TsSpeedButton;
    procedure sSpeedButton1Click(Sender: TObject);
    procedure sSpeedButton8Click(Sender: TObject);
    procedure sSpeedButton9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure AddRegSZ(Param,PName:string);
var
reg: TRegistry;
begin
try
reg:=TRegistry.Create(KEY_WRITE or KEY_WOW64_64KEY);
reg.RootKey:=HKEY_CURRENT_USER;
reg.LazyWrite:=false;
reg.OpenKey('Software\SAMP',false);
reg.WriteString(Param,PName);
finally
reg.CloseKey;
reg.Free;
end;
end;

procedure TForm2.sSpeedButton1Click(Sender: TObject);
begin
AddRegSZ('gta_sa_exe',Form2.sEdit1.Text+'\gta_sa.exe');
end;

procedure TForm2.sSpeedButton8Click(Sender: TObject);
begin
Form2.Close;
end;

procedure TForm2.sSpeedButton9Click(Sender: TObject);
begin
Form2.Close;
end;

end.
