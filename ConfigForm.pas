unit ConfigForm;

{/

NOTES:
------
From: http://www.physionet.org/physiotools/wag/signal-5.htm

Format 16
---------
Each sample is represented by a 16-bit two’s complement amplitude stored least
significant byte first. Any unused high-order bits are sign-extended from the
most significant bit. Historically, the format used for MIT-BIH and AHA
database distribution 9-track tapes was format 16, with the addition of a
logical EOF (octal 0100000) and null-padding after the logical EOF.

Looking at the Hex file it appears that we have:

 Header         1,024
 10 bytes          10
 Data      64,440,000
 --------  ----------
 File Size 64,441,034 bytes

What are the mystery 10 bytes - in single or 2 byte pairs?
  3 x 2 bytes + 4bytes = 10?

Does the data still need to be scaled voltage wise?

Should we include a time reference column that advances by
1/sample-freq per sample?

Calculate check-sums for each channel (requires the .HEA file)

Could parse freq, scale and no, channels frmo the file header

Should selecting TAB create a .TSV output file?

Perhaps if file size is greater than 1 MB we could output and
"Estimated processing time X mins".

/}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StrUtils, ComCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    InputFileButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    OutputFileButton: TButton;
    ConvertButton: TButton;
    CancelButton: TButton;
    Memo1: TMemo;
    Label3: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label4: TLabel;
    procedure InputFileButtonClick(Sender: TObject);
    procedure OutputFileButtonClick(Sender: TObject);
    procedure ConvertButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
  private
    { Private declarations }
    converted: Integer;
    separator: Pchar;
    function TwosComplement(val: Integer): Integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.InputFileButtonClick(Sender: TObject);
begin
  // load file
  OpenDialog1.Filter := 'RAW data files (*.raw)|*.RAW|DAT data files (*.dat)|*.DAT';
  OpenDialog1.FileName := '';
  if OpenDialog1.Execute then
    Edit1.Text := OpenDialog1.FileName;
end;


procedure TForm1.OutputFileButtonClick(Sender: TObject);
begin
  // choose output file
  SaveDialog1.Filter := 'Comma-separated value files (*.csv)|*.CSV';
  SaveDialog1.FileName := '';
  if SaveDialog1.Execute then
    Edit2.Text := SaveDialog1.FileName;
end;


procedure TForm1.ConvertButtonClick(Sender: TObject);
var
  InFile: File;
  OutFile: TextFile;
  str: String;
  byteArray: array[1..6] of byte;
  byteChar: byte;
  i,count: integer;
  ch1,ch2,ch3: integer;
  size: Integer;
begin
    // convert
    AssignFile(InFile, Edit1.Text);
    FileMode := fmOpenRead;  {Set file access to read only }
    Reset(InFile,1);
    size := FileSize(InFile) - 1024 - 10; // less header
    ProgressBar1.Max := size;
    ProgressBar1.Step := size div 100;
    ProgressBar1.Position := 0;

    // dump header to memo
    str := '';
    Memo1.Enabled := True;
    BlockRead(InFile,byteChar,1);
    while byteChar <> $2A do
      begin
        if byteChar = $0A then
          begin
            Memo1.Lines.Add(str);
            str := '';
          end
        else
          str := str + Char(byteChar);
        BlockRead(InFile,byteChar,1);
      end;
    Memo1.Lines.Add(str);

    // It appears that the header is padded out to 1,024 bytes using asterisks
    // although this could just be a coincidence.
    // chew '*'
    while byteChar = $2A do
      begin
        BlockRead(InFile,byteChar,1);
      end;

    Memo1.Lines.Add('Decoding channel data from ' + IntToStr(size) + ' bytes...');

    // open output file
    AssignFile(OutFile, Edit2.Text);
    ReWrite(OutFile);

    // chew the next 9 bytes between header and data
    // (last byte is read within the conversion loop)
    for i := 1 to 9 do
      begin
        BlockRead(InFile,byteChar,1);
        // Memo1.Lines.Add('? = ' + IntToStr(byteChar));
      end;

    // read and convert data
    Timer1.Enabled := True;
    try
      while not eof(InFile)do
        begin
          // convert 2-bytes per channel
          BlockRead(InFile,byteArray,6,count);

          if count < 6 then
            Exit;

          // read signal values  
          Ch1 := TwosComplement((byteArray[1] shl 8) + byteArray[2]);
          Ch2 := TwosComplement((byteArray[3] shl 8) + byteArray[4]);
          Ch3 := TwosComplement((byteArray[5] shl 8) + byteArray[6]);

          WriteLn(OutFile,
                  (IntToStr(Ch1) + separator +
                   IntToStr(Ch2) + separator +
                   IntToStr(Ch3)));

          Inc(converted,6);
          ProgressBar1.Position := converted;
        end;
    finally
      // close files
      CloseFile(InFile);
      CloseFile(OutFile);
      Memo1.Lines.Add('Done.');//trace
      Timer1.Enabled := False;
    end;

    // should calculate checksums
    Memo1.Lines.Add('');
    Memo1.Lines.Add('Conversion complete.');


end;


function TForm1.TwosComplement(val: Integer): Integer;
begin
  // convert negative 2's complement values
  if val >= $8000 then                            // MSB is '1'
    Result := -1 * ((not ($FFFF0000 + val)) + 1) // invert and add 1
  else
    Result := val;
end;


procedure TForm1.CancelButtonClick(Sender: TObject);
begin
  Application.Terminate;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
begin
  // update progress bar
  ProgressBar1.Position := converted;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  separator := Chr($2C); // ','
end;


procedure TForm1.RadioButton1Click(Sender: TObject);
begin
    if RadioButton1.Checked then
      separator := Chr($2C)
    else
      separator := Chr($09);
end;


procedure TForm1.RadioButton2Click(Sender: TObject);
begin
    if RadioButton2.Checked then
      separator := Chr($09)
    else
      separator := Chr($2C);

end;

end.
