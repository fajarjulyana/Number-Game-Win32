program NumberGame;

uses
  Forms,
  SourceMain in 'src\SourceMain.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Number Game';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
