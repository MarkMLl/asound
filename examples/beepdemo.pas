program BeepDemo;

(* Demo non-GUI beep for Linux using ALSA.                                      *)

{$mode objfpc}{$H+}

uses
  Classes, SysUtils, AlsaPcm;

begin
  ALSAbeep(880, 660)
end.

