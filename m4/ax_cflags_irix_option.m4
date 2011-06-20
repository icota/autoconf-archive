# ===========================================================================
#   http://www.gnu.org/software/autoconf-archive/ax_cflags_irix_option.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CFLAGS_IRIX_OPTION (optionflag [,[shellvar][,[A][,[NA]]])
#
# DESCRIPTION
#
#   AX_CFLAGS_IRIX_OPTION(-go_for_it) would show a message as like "checking
#   CFLAGS for irix/cc -go_for_it ... yes" and adds the optionflag to CFLAGS
#   if it is understood. You can override the shellvar-default of CFLAGS of
#   course. The order of arguments stems from the explicit macros like
#   AX_CFLAGS_WARN_ALL.
#
#   The cousin AX_CXXFLAGS_IRIX_OPTION would check for an option to add to
#   CXXFLAGS - and it uses the autoconf setup for C++ instead of C (since it
#   is possible to use different compilers for C and C++).
#
#   The macro is a lot simpler than any special AX_CFLAGS_* macro (or
#   ax_cxx_rtti.m4 macro) but allows to check for arbitrary options.
#   However, if you use this macro in a few places, it would be great if you
#   would make up a new function-macro and submit it to the ac-archive.
#
#    - $1 option-to-check-for : required ("-option" as non-value)
#    - $2 shell-variable-to-add-to : CFLAGS (or CXXFLAGS in the other case)
#    - $3 action-if-found : add value to shellvariable
#    - $4 action-if-not-found : nothing
#
#   note: in earlier versions, $1-$2 were swapped. We try to detect the
#   situation and accept a $2=~/-/ as being the old option-to-check-for.
#
#   see also: AX_CFLAGS_GCC_OPTION for the widely used original variant.
#
# LICENSE
#
#   Copyright (c) 2008 Guido U. Draheim <guidod@gmx.de>
#
#   This program is free software; you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation; either version 3 of the License, or (at your
#   option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
#   Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with this program. If not, see <http://www.gnu.org/licenses/>.
#
#   As a special exception, the respective Autoconf Macro's copyright owner
#   gives unlimited permission to copy, distribute and modify the configure
#   scripts that are the output of Autoconf when processing the Macro. You
#   need not follow the terms of the GNU General Public License when using
#   or distributing such scripts, even though portions of the text of the
#   Macro appear in them. The GNU General Public License (GPL) does govern
#   all other use of the material that constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the Autoconf
#   Macro released by the Autoconf Archive. When you make and distribute a
#   modified version of the Autoconf Macro, you may extend this special
#   exception to the GPL to apply to your modified version as well.

#serial 9

AC_DEFUN([AX_FLAGS_IRIX_OPTION_PRIVATE], [dnl
AS_VAR_PUSHDEF([FLAGS],[_AC_LANG_PREFIX[]FLAGS])dnl
AS_VAR_PUSHDEF([VAR],[ax_cv_[]_AC_LANG_ABBREV[]flags_irix_option_$1])dnl
AC_CACHE_CHECK([m4_ifval($2,$2,FLAGS) for irix/cc m4_ifval($1,$1,-option)],
VAR,[VAR="no, unknown"
 ac_save_[]FLAGS="$[]FLAGS"
for ac_arg dnl
in "-fullwarn -use_readonly_const % m4_ifval($1,$1,-option)"     dnl IRIX C
   #
do FLAGS="$ac_save_[]FLAGS "`echo $ac_arg | sed -e 's,%%.*,,' -e 's,%,,'`
   AC_TRY_COMPILE([],[return 0;],
   [VAR=`echo $ac_arg | sed -e 's,.*% *,,'` ; break])
done
 FLAGS="$ac_save_[]FLAGS"
])
case ".$VAR" in
     .ok|.ok,*) m4_ifvaln($3,$3) ;;
   .|.no|.no,*) m4_ifvaln($4,$4) ;;
   *) m4_ifvaln($3,$3,[
   if echo " $[]m4_ifval($2,$2,FLAGS) " | grep " $VAR " 2>&1 >/dev/null
   then AC_RUN_LOG([: m4_ifval($2,$2,FLAGS) does contain $VAR])
   else AC_RUN_LOG([: m4_ifval($2,$2,FLAGS)="$m4_ifval($2,$2,FLAGS) $VAR"])
                      m4_ifval($2,$2,FLAGS)="$m4_ifval($2,$2,FLAGS) $VAR"
   fi ]) ;;
esac
AS_VAR_POPDEF([VAR])dnl
AS_VAR_POPDEF([FLAGS])dnl
])

AC_DEFUN([AX_CFLAGS_IRIX_OPTION],[
  AC_LANG_PUSH([C])
  AX_FLAGS_IRIX_OPTION_PRIVATE(ifelse(m4_bregexp([$2],[-]),-1,[[$1],[$2]],[[$2],[$1]]),[$3],[$4])
  AC_LANG_POP
])

AC_DEFUN([AX_CXXFLAGS_IRIX_OPTION],[
  AC_LANG_PUSH([C++])
  AX_FLAGS_IRIX_OPTION_PRIVATE(ifelse(m4_bregexp([$2],[-]),-1,[[$1],[$2]],[[$2],[$1]]),[$3],[$4])
  AC_LANG_POP
])
