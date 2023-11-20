unit SourceMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TMainForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    EditAnswer: TEdit;
    ButtonCheckAnswer: TButton;
    ButtonNextQuestion: TButton;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure LabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ButtonCheckAnswerClick(Sender: TObject);
    procedure ButtonNextQuestionClick(Sender: TObject);
  private
    { Private declarations }
    Number1, Number2, Answer: Integer;
    Dragging: Boolean;
    OriginalLeft, OriginalTop: Integer;
  public
    { Public declarations }
    procedure GenerateQuestion;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Randomize; // Inisialisasi generator angka acak
  GenerateQuestion;
end;

procedure TMainForm.GenerateQuestion;
begin
  Number1 := Random(10) + 1; // Angka acak antara 1 dan 10
  Number2 := Random(10) + 1;
  Answer := Number1 + Number2;

  Label1.Caption := IntToStr(Number1);
  Label2.Caption := IntToStr(Number2);
  EditAnswer.Text := ''; // Bersihkan jawaban sebelumnya
end;

procedure TMainForm.LabelMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Dragging := True;
  OriginalLeft := TControl(Sender).Left;
  OriginalTop := TControl(Sender).Top;
  TControl(Sender).BringToFront;
end;

procedure TMainForm.LabelMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Dragging then
  begin
    TControl(Sender).Left := TControl(Sender).Left + X - (TControl(Sender).Width div 2);
    TControl(Sender).Top := TControl(Sender).Top + Y - (TControl(Sender).Height div 2);
  end;
end;

procedure TMainForm.ButtonCheckAnswerClick(Sender: TObject);
var
  UserAnswer: Integer;
begin
  if TryStrToInt(EditAnswer.Text, UserAnswer) then
  begin
    if UserAnswer = Answer then
      ShowMessage('Jawaban Benar!')
    else
      ShowMessage('Jawaban Salah.');
  end
  else
    ShowMessage('Masukkan angka yang valid.');

  Dragging := False; // Menghentikan drag-and-drop
end;

procedure TMainForm.ButtonNextQuestionClick(Sender: TObject);
begin
  GenerateQuestion;
end;

end.

