unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, sSpeedButton, Vcl.ExtCtrls,
  sPanel, Vcl.StdCtrls, sGroupBox, Vcl.ComCtrls, sStatusBar, sEdit, System.IniFiles, Unit1;

type
  TForm3 = class(TForm)
    sGroupBox4: TsGroupBox;
    sPanel1: TsPanel;
    sSpeedButton2: TsSpeedButton;
    sSpeedButton9: TsSpeedButton;
    sGroupBox1: TsGroupBox;
    sPanel2: TsPanel;
    sGroupBox2: TsGroupBox;
    sPanel3: TsPanel;
    sSpeedButton4: TsSpeedButton;
    sStatusBar1: TsStatusBar;
    sEdit1: TsEdit;
    procedure sSpeedButton9Click(Sender: TObject);
    procedure sSpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}



procedure SaveServersData;
var
  Ini: Tinifile;
  i:Integer;
  b:Boolean;
  str:string;
begin
  Ini := TiniFile.Create(extractfilepath(paramstr(0)) + 'Launcher.ini');
  b := False;
  if Form3.sEdit1.Text <> '' then
  begin
   if Pos(':', Form3.sEdit1.Text) <> 0 then
   begin
    for i := 0 to Form1.sComboBox1.Items.Count-1 do
    begin
      if Form1.sComboBox1.Items.Strings[i] = Form3.sEdit1.Text then
      begin
        b := True;
      end;
    end;
    if b = False then
    begin
     Ini.WriteString('Servers', IntToStr(Form1.sComboBox1.Items.Count), Form3.sEdit1.Text);
     str := Form3.sEdit1.Text;
     Form1.sComboBox1.Items.Add(str);
    end
    else
    begin
      ShowMessage('Данный сервер есть в списке.');
    end;
   end;
  end;
  FreeAndNil(Ini);
end;

procedure TForm3.sSpeedButton4Click(Sender: TObject);
begin
SaveServersData;
end;

procedure TForm3.sSpeedButton9Click(Sender: TObject);
begin
Form3.Close;
end;

end.
