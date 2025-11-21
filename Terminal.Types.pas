unit Terminal.Types;

interface

uses
  System.SysUtils, System.Classes, System.UITypes, System.Types, Terminal.Theme;

type
  {
   TTerminalTheme
   Этот класс теперь хранит все цвета.
   Он заменяет старые константы ANSI_COLORS, DEFAULT_FG_COLOR, DEFAULT_BG_COLOR
  }

    // --- Свойства ---

  // Атрибуты символа
  TCharAttributes = record
    Bold: Boolean;
    Faint: Boolean;
    Italic: Boolean;
    Underline: Boolean;
    Blink: Boolean;
    Inverse: Boolean;
    Hidden: Boolean;
    Strikethrough: Boolean;
    ForegroundColor: TAlphaColor;
    BackgroundColor: TAlphaColor;
    // --- ИЗМЕНЕНИЕ: Reset и Default теперь требуют тему ---
    procedure Reset(ATheme: TTerminalTheme);
    class function Default(ATheme: TTerminalTheme): TCharAttributes; static;
  end;

  // Символ в терминале
  TTerminalChar = record
    Char: WideChar;
    Attributes: TCharAttributes;
  end;

  // Строка терминала
  TTerminalLine = array of TTerminalChar;

  // Позиция курсора
  TTerminalCursor = record
    X: Integer;
    Y: Integer;
    Visible: Boolean;
  end;

  // --- *** НОВЫЕ ТИПЫ ДЛЯ МЫШИ *** ---
  TMouseTrackingMode = (
    mtm1000_Click,       // ?1000 (Click)
    mtm1002_Wheel,       // ?1002 (Click + Wheel)
    mtm1003_Any,         // ?1003 (Click + Wheel + Move)
    mtm1006_SGR         // ?1006 (SGR Extended Mode)
  );
  TMouseTrackingModes = set of TMouseTrackingMode;
  // --- *** КОНЕЦ НОВЫХ ТИПОВ *** ---

// --- TTerminalTheme и КОНСТАНТЫ УДАЛЕНЫ ОТСЮДА ---

implementation

uses
  System.Math;

{ TTerminalTheme }



{ TCharAttributes }

// --- ИЗМЕНЕНИЕ: Используем ATheme ---
procedure TCharAttributes.Reset(ATheme: TTerminalTheme);
begin
  Bold := False;
  Faint := False;
  Italic := False;
  Underline := False;
  Blink := False;
  Inverse := False;
  Hidden := False;
  Strikethrough := False;
  ForegroundColor := ATheme.DefaultFG;
  BackgroundColor := ATheme.DefaultBG;
end;

// --- ИЗМЕНЕНИЕ: Используем ATheme ---
class function TCharAttributes.Default(ATheme: TTerminalTheme): TCharAttributes;
begin
  Result.Reset(ATheme);
end;

end.
