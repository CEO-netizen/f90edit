! -----------------------------------------------------------------------------
! Copyright 2025 Gage <zeroday@disroot.org>
! This program is free software: you can redistribute it and/or modify
! it under the terms of the GNU General Public License as published by
! the Free Software Foundation, either version 3 of the License, or
! (at your option) any later version.
!
! This program is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
! GNU General Public License for more details.
!
! You should have received a copy of the GNU General Public License
! along with this program. If not, see <https://www.gnu.org/licenses/>.
! -----------------------------------------------------------------------------
program f90edit
implicit none

integer :: maxlines, maxlen
parameter (maxlines=100, maxlen=80)
character(maxlen) :: buffer(maxlines)
integer :: n, i, cmd, line

n = 0
print *, "*** F90 Mini Editor ***"
print *, "Commands: 1=append, 2=print, 3=delete, 4=write, 5=license, 6=quit"

10 continue
print *, "Enter command:"
read(*,*) cmd

! ---- Append line
if (cmd == 1) then
   if (n >= maxlines) then
      print *, "Buffer full!"
   else
      n = n + 1
      print *, "Enter text:"
      read(*,'(A)') buffer(n)
   end if

! ---- Print all lines
else if (cmd == 2) then
   do i = 1, n
      print '(I3,2X,A)', i, buffer(i)
   end do

! ---- Delete a line
else if (cmd == 3) then
   print *, "Delete which line?"
   read(*,*) line
   if (line >= 1 .and. line <= n) then
      do i = line, n-1
         buffer(i) = buffer(i+1)
      end do
      n = n - 1
   else
      print *, "Invalid line."
   end if

! ---- Write to file
else if (cmd == 4) then
   open(unit=10, file='output.txt', status='unknown')
   do i = 1, n
      write(10,'(A)') buffer(i)
   end do
   close(10)
   print *, "Saved to output.txt"

! ---- License disclaimer
else if (cmd == 5) then
   print *, "F90edit  Copyright (C) 2025  Gage <zeroday@disroot.org>"
   print *, "This program comes with ABSOLUTELY NO WARRANTY; see LICENSE file."
   print *, "This is free software, and you are welcome to redistribute it"
   print *, "under the conditions of the GNU GPL 3.0"

! ---- Quit
else if (cmd == 6) then
   print *, "Exiting editor..."
   stop

else
   print *, "Unknown command."
end if

goto 10
end program f90edit
