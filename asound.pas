// unit NEEDED FOR HINT TO WORK
(* Return either a static or a dynamic representation of the ALSA interface
  library (libasound.so or similar). In this case it is static.
*)
unit
  Asound;

(* This is a minimal ALSA interface derived from work by Andreas Stoeckel,      *)
(* Robert Rozee <rozee@mail.com> and FredvS <fiens@hotmail.com>. Refactored by  *)
(* MarkMLl.                                                                     *)

{  Free Pascal port by Nikolay Nikolov <nickysn@users.sourceforge.net>
   This version of the header has been created by Andreas Stoeckel and has been
   adapted to the needs of the Audorra audio library. For a complete version of the
   header for pascal have a look for the fpAlsa project on sourceforge.
   http://sourceforge.net/projects/fpalsa/
   This adaption has been done for the following reasons:
     - Easier to update to new versions of ALSA, as not the whole header has to be updated
     - Easier to distribute with Audorra (only a short, single file)
}

{**
 * \file include/asoundlib.h
 * \brief Application interface library for the ALSA driver
 * \author Jaroslav Kysela <perex@perex.cz>
 * \author Abramo Bagnara <abramo@alsa-project.org>
 * \author Takashi Iwai <tiwai@suse.de>
 * \date 1998-2001
 *
 * Application interface library for the ALSA driver
 *}
{*
 *   This library is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Lesser General Public License as
 *   published by the Free Software Foundation; either version 2.1 of
 *   the License, or (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Lesser General Public License for more details.
 *
 *   You should have received a copy of the GNU Lesser General Public
 *   License along with this library; if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 *
 *}

{$mode objfpc}{$H+}
{$PACKRECORDS C}

interface

uses
  Classes, SysUtils, CTypes;

const
  (* The ALSA libraries are statically linked, always return false.
  *)
  IsDynamic= false;
  (* The ALSA libraries are statically linked, if the program has started
    successfully then they must be in memory.
  *)
  ModuleInMemory= true;

{$define CONSTS }
{$undef TYPES   }
{$undef PROCS   }
{$i AsoundDefs.inc }

{$undef CONSTS  }
{$define TYPES  }
{$undef PROCS   }
{$i AsoundDefs.inc }

{$push }
{$macro on}
{$undef CONSTS }
{$undef TYPES  }
{$define PROCS }
{$define LIBASOUND__:= external 'libasound'; }
{$i AsoundDefs.inc }
{$pop }


implementation

end.

