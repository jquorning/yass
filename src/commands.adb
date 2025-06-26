--    Copyright 2019-2021 Bartek thindil Jasicki & 2025 J. Quorning
--
--    This file is part of YASS.
--
--    YASS is free software: you can redistribute it and/or modify
--    it under the terms of the GNU General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    YASS is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with YASS.  If not, see <http://www.gnu.org/licenses/>.

with Ada.Directories;
with Ada.Strings.Unbounded;
with Ada.Text_IO;

with GNAT.Directory_Operations;

with Config;
with Layouts;
with Pages;

--  with Messages;

-- ****h* Yass/Commands
-- FUNCTION
-- Yass commands
-- SOURCE
package body Commands is
-- ****

   use Ada.Strings.Unbounded;
   use Ada.Text_IO;

   ------------
   -- Create --
   ------------

   procedure Create (Is_Create      : Boolean;
                     Work_Directory : String)
   is
      use Ada.Directories;

      Dir_Separator : Character renames GNAT.Directory_Operations.Dir_Separator;
   begin
      Create_Directories_Block :
      declare
         Paths: constant array(1 .. 6) of Unbounded_String :=
           (1 => To_Unbounded_String (Source => "_layouts"),
            2 => To_Unbounded_String (Source => "_output"),
            3 =>
              To_Unbounded_String
                (Source => "_modules" & Dir_Separator & "start"),
            4 =>
              To_Unbounded_String
                (Source => "_modules" & Dir_Separator & "pre"),
            5 =>
              To_Unbounded_String
                (Source => "_modules" & Dir_Separator & "post"),
            6 =>
              To_Unbounded_String
                (Source => "_modules" & Dir_Separator & "end"));
      begin
         Create_Directories_Loop :
         for Directory of Paths loop
            Create_Path
              (New_Directory =>
                 Work_Directory & Dir_Separator &
                 To_String (Source => Directory));
         end loop Create_Directories_Loop;
      end Create_Directories_Block;

      if Is_Create then
         Config.Create_Interactive_Config (Directory_Name => Work_Directory);
      else
         Config.Create_Config (Directory_Name => Work_Directory);
      end if;

      Layouts.Create_Layout (Directory_Name => Work_Directory);

      Layouts.Create_Directory_Layout (Directory_Name => Work_Directory);

      Pages.Create_Empty_File (File_Name => Work_Directory);
   end Create;

   ---------------
   -- Show_Help --
   ---------------

   procedure Show_Help is
   begin
      Put_Line(Item => "Possible actions:");
      Put_Line(Item => "help - show this screen and exit");
      Put_Line(Item => "version - show the program version and exit");
      Put_Line(Item => "license - show short info about the program license");
      Put_Line(Item => "readme - show content of README file");
      Put_Line
        (Item => "createnow [name] - create new site in ""name"" directory");
      Put_Line
        (Item =>
           "create [name] - interactively create new site in ""name"" directory");
      Put_Line(Item => "build [name] - build site in ""name"" directory");
      Put_Line
        (Item =>
           "server [name] - start simple HTTP server in ""name"" directory and auto rebuild site if needed.");
      Put_Line
        (Item =>
           "createfile [name] - create new empty markdown file with ""name""");
   end Show_Help;

end Commands;
