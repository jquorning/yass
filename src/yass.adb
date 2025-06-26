--    Copyright 2019-2021 Bartek thindil Jasicki & 2022-2024 A.J. Ianozi
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

with Ada.Calendar;
with Ada.Calendar.Formatting;
with Ada.Command_Line;
with Ada.Directories;
with Ada.Environment_Variables;
with Ada.Exceptions;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Ada.Text_IO;

with GNAT.Directory_Operations;
with GNAT.Traceback.Symbolic;

with AWS.Net;

with Yass_Config;

with Commands;
with Config;
with Messages;

procedure Yass
is
   use Ada.Command_Line;
   use Ada.Exceptions;
   use Ada.Strings.Unbounded;
   use Ada.Text_IO;

   use Messages;

   Version  : constant String := Yass_Config.Crate_Version;
   Released : constant String := "2024-08-23";

   Dir_Separator : Character renames GNAT.Directory_Operations.Dir_Separator;

   --## rule off GLOBAL_REFERENCES
   Work_Directory : Unbounded_String := Null_Unbounded_String;
   --## rule on GLOBAL_REFERENCES

   -- *****f* YASS/YASS.Valid_Arguments
   -- SOURCE
   function Valid_Arguments
     (Message: String; Exist: Boolean) return Boolean
   with
      Pre => Message'Length > 0;
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

   ---------------------
   -- Valid_Arguments --
   ---------------------

   function Valid_Arguments
     (Message : String; Exist : Boolean) return Boolean
   is
      use Ada.Directories;
   begin
      --  User does not entered name of the site project directory
      if Argument_Count < 2 then
         Show_Message (Text => "Please specify directory name " & Message);
         return False;
      end if;

      --  Assign Work_Directory
      if
        Ada.Strings.Fixed.Index
          (Source  => Argument (Number => 2),
           Pattern => Containing_Directory (Name => Current_Directory)) = 1
      then
         Work_Directory :=
           To_Unbounded_String (Source => Argument(Number => 2));
      else
         Work_Directory :=
           To_Unbounded_String
             (Source =>
                Current_Directory & Dir_Separator & Argument (Number => 2));
      end if;

      --  Check if selected directory exist, if not, return False
      if
        Ada.Directories.Exists (Name => To_String (Source => Work_Directory)) =
        Exist
      then
         if Exist then
            Show_Message
              (Text =>
                 "Directory with that name exists, please specify another.");
         else
            Show_Message
              (Text =>
                 "Directory with that name not exists, please specify existing site directory.");
         end if;
         return False;
      end if;

      --  Check if selected directory is valid the program site project
      --  directory. Return False if not.
      if
        not Exist and
        not Ada.Directories.Exists
          (Name =>
             To_String (Source => Work_Directory) & Dir_Separator &
             "site.cfg")
      then
         Show_Message
           (Text =>
              "Selected directory don't have file ""site.cfg"". " &
              "Please specify proper directory.");
         return False;
      end if;

      return True;
   end Valid_Arguments;

begin
   if Ada.Environment_Variables.Exists (Name => "YASSDIR") then
      Ada.Directories.Set_Directory
         (Directory => Ada.Environment_Variables.Value (Name => "YASSDIR"));
   end if;

   --  No arguments or help: show available commands
   if Argument_Count < 1 or else Argument (Number => 1) = "help" then
      Commands.Show_Help;

   --  Show version information
   elsif Argument(Number => 1) = "version" then
      Put_Line (Item => "Version: " & Version);
      Put_Line (Item => "Released: " & Released);

   --  Show license information
   elsif Argument(Number => 1) = "license" then
      Commands.Show_License;

   --  Show README.md file
   elsif Argument (Number => 1) = "readme" then
      Commands.Show_Readme (Command_Name);

   --  Create new, selected site project directory
   elsif Argument(Number => 1) in "createnow" | "create" then
      if not Valid_Arguments
          (Message => "where new page will be created.", Exist => True) then
         return;
      end if;

      Commands.Create
        (Is_Create      => Argument (Number => 1) = "create",
         Work_Directory => To_String (Work_Directory));

      Messages.Show_Message
        (Text =>
           "New page in directory """ & Argument(Number => 2) &
           """ was created. Edit """ & Argument(Number => 2) & Dir_Separator &
           "site.cfg"" file to set data for your new site.",
         Message_Type => Messages.SUCCESS);

   elsif Argument(Number => 1) = "build" then
      if not Valid_Arguments
          (Message => "from where page will be created.", Exist => False) then
         return;
      end if;

      declare
         Success : Boolean;
      begin
         Commands.Build_Site (Directory_Name => To_String (Work_Directory),
                              Success        => Success);
         if Success then
            Show_Message
              (Text => "Site was build.", Message_Type => Messages.SUCCESS);
         else
            Show_Message (Text => "Site building has been interrupted.");
         end if;
      end;

   --  Start server to monitor changes in selected site project
   elsif Argument (Number => 1) = "server" then
      if not Valid_Arguments
          (Message => "from where site will be served.", Exist => False) then
         return;
      end if;

      Commands.Server_Command (Work_Directory => To_String (Work_Directory));

      Show_Message (Text => "done.", Message_Type => Messages.SUCCESS);

   --  Create new empty markdown file with selected name
   elsif Argument(Number => 1) = "createfile" then
      if Argument_Count < 2 then
         Show_Message(Text => "Please specify name of file to create.");
         return;
      end if;

      Commands.Create_File (Work_Directory => Work_Directory,
                            File_Name      => Argument (2));

      Show_Message
        (Text =>
           "Empty file """ & To_String (Source => Work_Directory) &
           """ was created.",
         Message_Type => Messages.SUCCESS);

   --  Unknown command entered
   else
      Show_Message(Text => "Unknown command '" & Argument(Number => 1) & "'");
      Commands.Show_Help;

   end if;

exception

   when An_Exception : Config.Invalid_Config_Data =>
      Show_Message
        (Text =>
           "Invalid data in site config file ""site.cfg"". Invalid line:""" &
           Exception_Message(X => An_Exception) & """");

   when AWS.Net.Socket_Error =>
      Show_Message
        (Text =>
           "Can't start program in server mode. Probably another program is " &
           "using this same port, or you have still connected old instance of " &
           "the program in your browser. Please close whole browser and try run "  &
           "the program again. If problem will persist, try to change port for " &
           "the server in the site configuration.");

   when An_Exception : others =>
      Save_Exception_Info_Block :
      declare
         use Ada.Calendar;
         use GNAT.Traceback.Symbolic;

         Error_File: File_Type;
      begin
         if Ada.Directories.Exists (Name => "error.log") then
            Open (File => Error_File, Mode => Append_File, Name => "error.log");
         else
            Create
              (File => Error_File, Mode => Append_File, Name => "error.log");
         end if;

         Put_Line
           (File => Error_File,
            Item => Ada.Calendar.Formatting.Image (Date => Clock));
         Put_Line (File => Error_File, Item => Version);
         Put_Line
           (File => Error_File,
            Item => "Exception: " & Exception_Name(X => An_Exception));
         Put_Line
           (File => Error_File,
            Item => "Message: " & Exception_Message(X => An_Exception));
         Put_Line
           (File => Error_File,
            Item => "-------------------------------------------------");

         if Dir_Separator = '/' then
            Put_Line
              (File => Error_File,
               Item => Symbolic_Traceback (E => An_Exception));
         else
            Put_Line
              (File => Error_File,
               Item => Exception_Information (X => An_Exception));
         end if;

         Put_Line
           (File => Error_File,
            Item => "-------------------------------------------------");

         Close (File => Error_File);

         Put_Line
           (Item =>
              "Oops, something bad happen and program crashed. Please, remember " &
              "what you done before crash and report this problem at " &
              "https://github.com/yet-another-static-site-generator/yass and " &
              "attach (if possible) file 'error.log' (should be in this same " &
              "directory).");
      end Save_Exception_Info_Block;

end Yass;
