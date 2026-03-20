--
--  Copyright 2019-2021 Bartek thindil Jasicki
--  Copyright 2022-2024 A.J. Ianozi
--
--  This file is part of YASS.
--
--  YASS is free software: you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation, either version 3 of the License, or
--  (at your option) any later version.
--
--  YASS is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with YASS.  If not, see <http://www.gnu.org/licenses/>.

with Ada.Command_Line;
with Ada.Directories;
with Ada.Environment_Variables;
with Ada.Exceptions;

with Commands;
with Config;
with Messages;
with Monitors;

procedure Yass
is

   -- ****if* YASS/Commands.Valid_Arguments
   -- SOURCE
--   function Valid_Arguments (Message : String; Exist : Boolean) return Boolean
--   with Pre => Message'Length > 0;
   -- FUNCTION
   -- Validate arguments which user was entered when started the program and
   -- set Work_Directory for the program.
   -- PARAMETERS
   -- Message - part of message to show when user does not entered the site
   --           project directory
   -- Exist   - did selected directory should be test did it exist or not
   -- RESULT
   -- Returns True if entered arguments are valid, otherwise False.
   -- ****

   -- ---------------------
   -- -- Valid_Arguments --
   -- ---------------------

   -- function Valid_Arguments (Message : String; Exist : Boolean) return Boolean is
   --    use Ada.Command_Line;
   --    use Ada.Directories;
   --    use Messages;
   -- begin
   --    -- User does not entered name of the site project directory
   --    if Argument_Count < 2 then
   --       Show_Message (Text => "Please specify directory name " & Message);
   --       return False;
   --    end if;

   --    --  Assign Work_Directory
   --    declare
   --       Path : String renames Argument (Number => 2);
   --    begin
   --       Work_Directory := To_Unbounded_String (Full_Name (Path));
   --    end;

   --    --   Check if selected directory exist, if not, return False
   --    if Ada.Directories.Exists (Name => To_String (Work_Directory)) = Exist then
   --       if Exist then
   --          Show_Message
   --            (Text => "Directory with that name exists, please specify another.");
   --       else
   --          Show_Message
   --            (Text =>
   --               "Directory with that name not exists, please specify existing "
   --               & "site directory.");
   --       end if;
   --       return False;
   --    end if;

   --    --  Check if selected directory is valid the program site project directory.
   --    --  Return False if not.
   --    if not Exist
   --      and not Ada.Directories.Exists
   --                (Name => To_String (Work_Directory) & Dir_Separator & "site.cfg")
   --    then
   --       Show_Message
   --         (Text =>
   --            "Selected directory don't have file ""site.cfg"". Please specify "
   --            & "proper directory.");
   --       return False;
   --    end if;
   --    return True;
   -- end Valid_Arguments;

   use Ada.Command_Line;
   use Ada.Directories;
   use Config;
begin
   if Ada.Environment_Variables.Exists (Name => "YASSDIR") then
      Set_Directory (Directory => Ada.Environment_Variables.Value (Name => "YASSDIR"));
   end if;

   --  No arguments or help: show available commands
   if Argument_Count < 1 or else Argument (1) in "help" | "--help" then
      Commands.Show_Help;

   --  Show version information
   elsif Argument (1) in "version" | "--version" then
      Commands.Show_Version_Information;

   --  Show license information
   elsif Argument (1) = "license" then
      Commands.Show_License_Information;

   --  Show README.md file
   elsif Argument (1) = "readme" then
      Commands.Show_Readme_File;

   --  Create new, selected site project directory
   elsif Argument (1) in "create" | "createnow" then
      if Argument_Count < 2 then
         Messages.Show_Message
           ("Please specify directory name where new page will be created.");
         return;
      end if;

      declare
         Interactive : constant Boolean := Argument (1) = "create";
         Directory   : constant String := Commands.To_Work_Directory (Argument (2));
      begin
         if Ada.Directories.Exists (Name => Directory) then
            Messages.Show_Message
              ("Directory with that name exists, please specify another.");
            return;
         end if;
         Commands.Create_Site (Directory, Interactive);
      end;

   elsif Argument (1) = "build" then
      if Argument_Count < 2 then
         Messages.Show_Message
           ("Please specify directory name where page will be created.");
         return;
      end if;

      declare
         Directory : constant String := Commands.To_Work_Directory (Argument (2));
         Success   : Boolean;
      begin
         if not Ada.Directories.Exists (Directory) then
            Messages.Show_Message
              (Text =>
                 "Directory with that name not exists, please specify existing "
                 & "site directory.");
            return;
         end if;

         if not Commands.Is_Valid_Project_Directory (Directory) then
            Messages.Show_Message
              ("Selected directory don't have file ""site.cfg"". Please specify "
               & "proper directory.");
            return;
         end if;

         Load_Site_Config (Directory_Name => Directory);

         Commands.Build_Site (Directory_Name => Directory, Success => Success);

         if Success then
            Messages.Show_Message ("Site was build.", Message_Type => Messages.SUCCESS);
         else
            Messages.Show_Message ("Site building has been interrupted.");
         end if;
      end;

   --  Start server to monitor changes in selected site project
   elsif Argument (1) = "server" then
      if Argument_Count < 2 then
         Messages.Show_Message
           ("Please specify directory name where site will be served.");
         return;
      end if;

      declare
         Directory : constant String := Commands.To_Work_Directory (Argument (2));
      begin
         if not Ada.Directories.Exists (Directory) then
            Messages.Show_Message
              (Text =>
                 "Directory with that name not exists, please specify existing "
                 & "site directory.");
            return;
         end if;

         if not Commands.Is_Valid_Project_Directory (Directory) then
            Messages.Show_Message
              ("Selected directory don't have file ""site.cfg"". Please specify "
               & "proper directory.");
            return;
         end if;

         Commands.Serve_Site (Directory => Directory);
      end;

   --  Create new empty markdown file with selected name
   elsif Argument (1) = "createfile" then
      if Argument_Count < 2 then
         Messages.Show_Message (Text => "Please specify name of file to create.");
         return;
      end if;

      Commands.Create_File (Directory => Argument (2));

   --  Unknown command entered
   else
      Messages.Show_Message (Text => "Unknown command '" & Argument (1) & "'");
      Commands.Show_Help;
   end if;

exception
   when Occurrence : Invalid_Config_Data =>
      Messages.Show_Message
        (Text =>
           "Invalid data in site config file ""site.cfg"". Invalid line:""" &
            Ada.Exceptions.Exception_Message (Occurrence) & """");

   when Occurrence : others =>
      Monitors.Save_Exception_Info (Occurrence, "Environment_Task");

end Yass;
