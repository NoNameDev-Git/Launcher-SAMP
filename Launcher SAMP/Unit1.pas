unit Unit1;

interface

uses
  WinApi.Windows, System.SysUtils,  System.Classes,Vcl.Forms, Vcl.StdCtrls,
  IdComponent,  IdTCPClient, IdHTTP, Vcl.ComCtrls, IdBaseComponent, IdTCPConnection, Vcl.Controls,
  sSkinManager, sGroupBox, Vcl.ExtCtrls, sLabel, sPanel, Vcl.Buttons,
  sSpeedButton, acProgressBar, Vcl.Imaging.jpeg, acImage, sEdit, sStatusBar, System.Win.Registry,
  sButton, System.ZLib, sevenzip, Vcl.OleCtrls, SHDocVw, acWebBrowser, sMemo,
  Vcl.ColorGrd, ZipForge, sGauge, acPNG, sComboBox, System.IniFiles,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, Vcl.Dialogs;

type
  TForm1 = class(TForm)
    sSkinManager1: TsSkinManager;
    sGroupBox1: TsGroupBox;
    sImage1: TsImage;
    sGroupBox2: TsGroupBox;
    sImage2: TsImage;
    sGroupBox3: TsGroupBox;
    sImage3: TsImage;
    sStatusBar1: TsStatusBar;
    Timer1: TTimer;
    ZipForge1: TZipForge;
    sGroupBox4: TsGroupBox;
    sPanel1: TsPanel;
    sGroupBox7: TsGroupBox;
    sPanel3: TsPanel;
    sPanel2: TsPanel;
    sEdit1: TsEdit;
    sGroupBox8: TsGroupBox;
    sPanel5: TsPanel;
    sSpeedButton2: TsSpeedButton;
    sSpeedButton3: TsSpeedButton;
    sSpeedButton4: TsSpeedButton;
    sSpeedButton5: TsSpeedButton;
    sSpeedButton6: TsSpeedButton;
    sSpeedButton7: TsSpeedButton;
    sSpeedButton8: TsSpeedButton;
    sEdit3: TsEdit;
    sGauge1: TsGauge;
    sGroupBox5: TsGroupBox;
    sPanel6: TsPanel;
    sImage4: TsImage;
    sLabelFX1: TsLabelFX;
    sLabelFX2: TsLabelFX;
    sImage5: TsImage;
    sImage6: TsImage;
    sLabelFX3: TsLabelFX;
    sImage7: TsImage;
    sLabelFX4: TsLabelFX;
    sComboBox1: TsComboBox;
    sSpeedButton10: TsSpeedButton;
    sPanel7: TsPanel;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton9: TsSpeedButton;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdHTTP1: TIdHTTP;
    procedure IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sSpeedButton2Click(Sender: TObject);
    procedure sSpeedButton3Click(Sender: TObject);
    procedure sSpeedButton4Click(Sender: TObject);
    procedure sSpeedButton5Click(Sender: TObject);
    procedure sSpeedButton6Click(Sender: TObject);
    procedure sSpeedButton7Click(Sender: TObject);
    procedure sSpeedButton8Click(Sender: TObject);
    procedure sSpeedButton9Click(Sender: TObject);
    procedure sSpeedButton10Click(Sender: TObject);
    procedure sComboBox1Change(Sender: TObject);
    procedure sLabelFX3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure sLabelFX3MouseLeave(Sender: TObject);
    procedure sLabelFX3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  shell32 = 'shell32.dll';
  kernel32 = 'kernel32.dll';

var
  Form1: TForm1;


function Wow64DisableWow64FsRedirection(Var Wow64FsEnableRedirection: LongBool): LongBool; stdcall;
external kernel32 name 'Wow64DisableWow64FsRedirection';

function ShellExecuteW(hWnd: THandle; Operation, FileName, Parameters,
Directory: WideString; ShowCmd: Integer): HINST; stdcall;
external shell32 name 'ShellExecuteW';



implementation

{$R *.dfm}

uses Unit2, Unit3;

procedure ShellExecute(hWnd: THandle; Operation, FileName, Parameters, Directory: WideString; ShowCmd: Integer);
var
WFER: LongBool;
begin
   if Wow64DisableWow64FsRedirection(WFER) then
   ShellExecuteW(hWnd, Operation, FileName, Parameters, Directory, ShowCmd)
   else ShellExecuteW(hWnd, Operation, FileName, Parameters, Directory, ShowCmd);
end;


procedure LoadServersData;
var
  Ini: Tinifile;
  i:Integer;
  str:string;
begin
  if FileExists(extractfilepath(paramstr(0)) + 'Launcher.ini') then
  begin
    Ini := TiniFile.Create(extractfilepath(paramstr(0)) + 'Launcher.ini');
    for i := 1 to 1000 do
    begin
      str :=   Ini.ReadString('Servers', IntToStr(i), str);
      if str = '' then Break;
      Form1.sComboBox1.Items.Add(str);
      str := '';
    end;
    FreeAndNil(Ini);
  end;
end;


function Copy_Line(position, line, types:string):string;
var
i: Integer;
sLeft, sRigth, s: String;
begin
Result:='';
s:=line;
i := pos(position, s);
if i > 0 then
begin
sLeft := copy(s, 1, i - 1);
sRigth := copy(s, i + 1, Length(s) - i);
end;
if types = 'Rigth' then
begin
Result:=sRigth;
end;
if types = 'Left' then
begin
Result:=sLeft;
end;
end;

function Parss(T_, ForS, _T: string): string;
var
a, b: integer;
begin
Result := '';
if (T_ = '') or (ForS = '') or (_T = '') then
Exit;
a := Pos(T_, ForS);
if a = 0 then
Exit
else
a := a + Length(T_);
ForS := Copy(ForS, a, Length(ForS) - a + 1);
b := Pos(_T, ForS);
if b > 0 then
Result := Copy(ForS, 1, b - 1);
end;

procedure SleepTime(j:integer);
var
i:Integer;
begin
  for i := 0 to j do
    begin
      Sleep(1);
      Application.ProcessMessages;
    end;
end;

procedure AddRegSZ(Param,PName:string);
var
  reg: TRegistry;
begin
    reg:=TRegistry.Create(KEY_WRITE or KEY_WOW64_64KEY);
  try
    reg.RootKey:=HKEY_CURRENT_USER;
    reg.LazyWrite:=false;
    reg.OpenKey('Software\SAMP',false);
    reg.WriteString(Param,PName);
  finally
    reg.CloseKey;
    reg.Free;
  end;
end;

function ReadRegSZ(ValueName: string):string;
var
  Reg: TRegistry;
  strsz: string;
begin
    Result := '';
    Reg := TRegistry.Create(KEY_READ or KEY_WOW64_64KEY);
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('Software\SAMP', true) then
    begin
      strsz := Reg.ReadString(ValueName);
      Result := strsz;
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

procedure GetInfoSampServer;
var
Ip,Port:string;
http:TIdHTTP;
StrList:TStringList;
i:Integer;
Status,HostName,HostNameTemp,HostNameShow: string;
  Players,WebUrl,Version:string;
begin
  Form1.Enabled := False;
  Ip := Copy_Line(':', Form1.sComboBox1.Text, 'Left');
  Port := Copy_Line(':', Form1.sComboBox1.Text, 'Rigth');
  http := TidHTTP.Create(nil);
  StrList := TStringList.Create();
  try
    http.IOHandler := Form1.IdSSLIOHandlerSocketOpenSSL1;
    http.HandleRedirects:=True;
    StrList.Text := http.get('http://midway-rp.xyz/infosamp.php?ip='+Ip+'&port='+Port);
    Application.ProcessMessages;
    Status := Parss('|status|', StrList.Text ,'|/status|');
    if Pos('Online',Status) <> 0 then
    begin
      Players := Parss('|players|', StrList.Text ,'|/players|');
      HostName := Parss('|hostname|', StrList.Text ,'|/hostname|');
      HostNameTemp := '';
      if Length(HostName) > 34 then
      begin
         for i := 1 to 34 do
         begin
           HostNameTemp := HostNameTemp + HostName[i];
         end;
         HostNameShow := HostNameTemp + ' ...';
      end
      else if Length(HostName) <= 34 then
      begin
        HostNameShow := HostName;
      end;
      WebUrl := Parss('|weburl|', StrList.Text ,'|/weburl|');
      Version := Parss('|version|', StrList.Text ,'|/version|');

    end
    else
    begin
      Form1.sLabelFX1.Caption := '--------';
      Form1.sLabelFX2.Caption := '--------';
      Form1.sLabelFX3.Caption := '--------';
      Form1.sLabelFX4.Caption := '--------';
    end;
  except
    Application.ProcessMessages;
  end;

  if ((Players <> '') and (HostNameShow <> '') and (WebUrl <> '') and (Version <> '')) then
  begin
  Form1.sLabelFX1.Caption := Players;
  Form1.sLabelFX2.Caption := HostNameShow;
  Form1.sLabelFX3.Caption := WebUrl;
  Form1.sLabelFX4.Caption := Version;
  end
  else
  begin
  Form1.sLabelFX1.Caption := '--------';
  Form1.sLabelFX2.Caption := '--------';
  Form1.sLabelFX3.Caption := '--------';
  Form1.sLabelFX4.Caption := '--------';
  end;


  http.Disconnect;
  http.Free;
  StrList.Free;
  Form1.Enabled := True;


end;

procedure TForm1.FormShow(Sender: TObject);
var
  DirSamp:string;
begin
  Form1.sEdit1.Text := ReadRegSZ('PlayerName');
  DirSamp := ReadRegSZ('gta_sa_exe');
  if DirSamp = '' then
    DirSamp := 'C:\Program Files (x86)\Grand Theft Auto - San Andreas'
  else
  begin
   while DirSamp[Length(DirSamp)] <> '\' do
     Delete(DirSamp,Length(DirSamp),1);
   Delete(DirSamp,Length(DirSamp),1);
  end;
  Form2.sEdit1.Text := DirSamp;

  //Добавляем ip нашего сервера
  sComboBox1.Items.Add('45.129.99.96:7777');
  sComboBox1.ItemIndex := 0;
  //Подгружаем info о нашем сервере
  GetInfoSampServer;
  //Загружаем список серверов
  LoadServersData;

end;

procedure TForm1.IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
  var
  SizeMB:string;
  Percent:string;
  const
  i64MB = 1024 * 1024;
begin
  sGauge1.Progress := AWorkCount;
  if AWorkCount div i64MB > 0 then
  begin
   Percent := Format('%.2f', [AWorkCount * 100 / sGauge1.MaxValue]);
   SizeMB := Format('[ %.2f Mb ]', [AWorkCount / i64MB]);
   Form1.sEdit3.Text := 'Идёт загрузка архива: '+
   SizeMB+'  [ '+Percent+' % ]';
  end;
  Application.ProcessMessages;
end;

procedure TForm1.IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  sGauge1.MinValue := 0;
  sGauge1.MaxValue := AWorkCountMax;
  Application.ProcessMessages;
end;

procedure TForm1.sComboBox1Change(Sender: TObject);
begin
  GetInfoSampServer;
end;

procedure TForm1.sLabelFX3Click(Sender: TObject);
begin
if sLabelFX3.Cursor = crHandPoint then
ShellExecute(0, '', sLabelFX3.Caption, '', '', 1);
end;

procedure TForm1.sLabelFX3MouseLeave(Sender: TObject);
begin
sLabelFX3.Cursor := crDefault;
sLabelFX3.Shadow.Color := $808080;
end;

procedure TForm1.sLabelFX3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if sLabelFX3.Caption <> '--------' then
begin
  sLabelFX3.Cursor := crHandPoint;
  sLabelFX3.Shadow.Color := $000000;
end;
end;

procedure TForm1.sSpeedButton10Click(Sender: TObject);
begin
Form3.ShowModal;
end;

procedure TForm1.sSpeedButton1Click(Sender: TObject);
var
  FileStream :TFileStream;
  NickName,DirSamp,ServerIP:string;
begin
  sSpeedButton1.Enabled := False;
  NickName := sEdit1.Text;
  AddRegSZ('PlayerName',NickName);
  DirSamp := Form2.sEdit1.Text;
  AddRegSZ('gta_sa_exe',DirSamp+'\gta_sa.exe');
  ServerIP := Form1.sComboBox1.Text;
  if DirectoryExists(Form2.sEdit1.Text) = False then
    ForceDirectories(Form2.sEdit1.Text);

  if ((FileExists(Form2.sEdit1.Text +'\gta_sa.exe') = False) and
  (FileExists(Form2.sEdit1.Text +'\samp.exe') = False)) then
  begin
    Form1.sEdit3.Text := 'Начинаю загрузку архива, ожидайте.';
    SleepTime(200);
    FileStream := TFileStream.Create(ExtractFilePath(ParamStr(0))+'GTA_SAMP.zip', fmCreate);
    IdHTTP1.Get('http://midway-rp.xyz/GTA_SAMP.zip', FileStream);
    FreeAndNil(FileStream);
    Form1.sEdit3.Text := 'Загрузка завершена, ожидайте.';
    SleepTime(200);
    Form1.sEdit3.Text := 'Начинаю распаковку файлов, ожидайте.';
    SleepTime(200);
    try
        ZipForge1.FileName:=ExtractFilePath(ParamStr(0))+'GTA_SAMP.zip';
        ZipForge1.OpenArchive;
        ZipForge1.BaseDir := DirSamp+'\';
        ZipForge1.ExtractFiles('*.*');
        ZipForge1.CloseArchive;
    except
      Application.ProcessMessages;
    end;
    Form1.sEdit3.Text := 'Запускаю игру, ожидайте.';
    SleepTime(200);
    ShellExecute(0, 'open', 'cmd.exe', '/c "'+DirSamp+'\samp.exe" '+ServerIP, DirSamp, 0);
    sGauge1.Progress := 0;
    Form1.sEdit3.Text := 'Индикатор  загрузки  GTA  SAMP  архива.';
    sSpeedButton1.Enabled := True;
    Form1.WindowState:=wsMinimized;
  end else
  if ((FileExists(Form2.sEdit1.Text +'\gta_sa.exe') = True) and
  (FileExists(Form2.sEdit1.Text +'\samp.exe') = True)) then
  begin
    Form1.sEdit3.Text := 'Запускаю игру, ожидайте.';
    SleepTime(200);
    ShellExecute(0, 'open', 'cmd.exe', '/c "'+DirSamp+'\samp.exe" '+ServerIP, DirSamp, 0);
    sGauge1.Progress := 0;
    Form1.sEdit3.Text := 'Индикатор  загрузки  GTA  SAMP  архива.';
    sSpeedButton1.Enabled := True;
    Form1.WindowState:=wsMinimized;
  end;
end;

procedure TForm1.sSpeedButton2Click(Sender: TObject);
begin
ShellExecute(0, '', 'https://midway-rp.xyz/', '', '', 1);
end;

procedure TForm1.sSpeedButton3Click(Sender: TObject);
begin
ShellExecute(0, '', 'https://vk.com/midway_roleplay', '', '', 1);
end;

procedure TForm1.sSpeedButton4Click(Sender: TObject);
begin
ShellExecute(0, '', 'https://discord.gg/A4dHb6vd', '', '', 1);
end;

procedure TForm1.sSpeedButton5Click(Sender: TObject);
begin
ShellExecute(0, '', 'https://www.youtube.com/channel/UCqoBcT48z7B1ajAC_3746Nw', '', '', 1);
end;

procedure TForm1.sSpeedButton6Click(Sender: TObject);
begin
ShellExecute(0, '', 'https://t.me/midway_rp', '', '', 1);
end;

procedure TForm1.sSpeedButton7Click(Sender: TObject);
begin
Form1.WindowState:=wsMinimized;
end;

procedure TForm1.sSpeedButton8Click(Sender: TObject);
begin
  asm
      call Exitprocess;
  end;
end;

procedure TForm1.sSpeedButton9Click(Sender: TObject);
begin
Form2.ShowModal;
end;

end.
