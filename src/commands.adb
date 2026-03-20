--
--  Copyright 2019-2021 Bartek thindil Jasicki
--  Copyright 2022-2024 A.J. Ianozi
--  Copyright 2026      Jesper Quorning
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

with Ada.Directories;
with Ada.Environment_Variables;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Ada.Text_IO;

with GNAT.Directory_Operations;
with GNAT.OS_Lib;

with AWS.Net;
with AWS.Server;

with Resources;

with AtomFeed;
with Config;
with Layouts;
with Messages;
with Modules;
with Monitors;
with Pages;
with Sitemaps;
with Server;

package body Commands
is
   use Ada.Strings.Unbounded;

   Version  : constant String := "3.2.0-dev";  --  Keep in sync with alire.toml
   Released : constant String := "2024-08-23";

   Dir_Separator : Character renames GNAT.Directory_Operations.Dir_Separator;

   -----------------------
   -- To_Work_Directory --
   -----------------------

   function To_Work_Directory (Directory : String) return String is
      use Ada.Directories;
   begin
      return Full_Name (Directory);
   end To_Work_Directory;

   --------------------------------
   -- Is_Valid_Project_Directory --
   --------------------------------

   function Is_Valid_Project_Directory (Directory : String) return Boolean is
   begin
      return Ada.Directories.Exists (Directory & Dir_Separator & "site.cfg");
   end Is_Valid_Project_Directory;

   ----------------
   -- Build_Site --
   ----------------

   procedure Build_Site (Directory_Name : String; Success : out Boolean) is
      use Ada.Directories;

      use AtomFeed;
      use Config;
      use Modules;
      use Sitemaps;

      Page_Tags       : Tags_Container.Map := Tags_Container.Empty_Map;
      Page_Table_Tags : TableTags_Container.Map := TableTags_Container.Empty_Map;

      procedure Build (Name : String)
      with Pre => Name'Length > 0;
      --  Build the site from directory with full path Name

      procedure Build (Name : String) is
         procedure Process_Files (Item : Directory_Entry_Type);
         --  Process file with full path Item: create html pages from markdown
         --  files or copy any other file.

         procedure Process_Directories (Item : Directory_Entry_Type);
         --  Go recursive with directory with full path Item.

         -------------------
         -- Process_Files --
         -------------------

         procedure Process_Files (Item : Directory_Entry_Type) is
         begin
            if Yass_Conf.Excluded_Files.Find_Index
                 (Item => Simple_Name (Directory_Entry => Item))
              /= Excluded_Container.No_Index
              or not Ada.Directories.Exists (Name => Full_Name (Directory_Entry => Item))
            then
               return;
            end if;

            Ada.Environment_Variables.Set
              (Name => "YASSFILE", Value => Full_Name (Directory_Entry => Item));

            if Extension (Name => Simple_Name (Directory_Entry => Item)) = "md" then
               Pages.Create_Page
                 (File_Name => Full_Name (Directory_Entry => Item), Directory => Name);
            else
               Pages.Copy_File
                 (File_Name => Full_Name (Directory_Entry => Item), Directory => Name);
            end if;

         end Process_Files;

         -------------------------
         -- Process_Directories --
         -------------------------

         procedure Process_Directories (Item : Directory_Entry_Type) is
         begin
            if Yass_Conf.Excluded_Files.Find_Index
                 (Item => Simple_Name (Directory_Entry => Item))
              = Excluded_Container.No_Index
              and Ada.Directories.Exists (Name => Full_Name (Directory_Entry => Item))
            then
               Build (Name => Full_Name (Directory_Entry => Item));
            end if;

         exception
            when Ada.Directories.Name_Error =>
               null;
         end Process_Directories;

      begin
         Search
           (Directory => Name,
            Pattern   => "",
            Filter    => (Directory => False, others => True),
            Process   => Process_Files'Access);

         Search
           (Directory => Name,
            Pattern   => "",
            Filter    => (Directory => True, others => False),
            Process   => Process_Directories'Access);
      end Build;

   begin
      --  Load the program modules with 'start' hook
      Load_Modules
        (State => "start", Page_Tags => Page_Tags, Page_Table_Tags => Page_Table_Tags);

      --  Load data from exisiting sitemap or create new set of data or nothing
      --  if sitemap generation is disabled
      Start_Sitemap;

      --  Load data from existing atom feed or create new set of data or nothing
      --  if atom feed generation is disabled
      Start_Atom_Feed;

      --  Build the site
      Build (Name => Directory_Name);

      --  Save atom feed to file or nothing if atom feed generation is disabled
      Save_Atom_Feed;

      --  Save sitemap to file or nothing if sitemap generation is disabled
      Save_Sitemap;

      --  Load the program modules with 'end' hook
      Load_Modules
        (State => "end", Page_Tags => Page_Tags, Page_Table_Tags => Page_Table_Tags);
      Success := True;

   exception
      when Pages.Generate_Site_Exception =>
         Success := False;
   end Build_Site;

   ---------------
   -- Show_Help --
   ---------------

   procedure Show_Help is
      use Ada.Text_IO;
   begin
      Put_Line (Item => "Possible actions:");
      Put_Line (Item => "help - show this screen and exit");
      Put_Line (Item => "version - show the program version and exit");
      Put_Line (Item => "license - show short info about the program license");
      Put_Line (Item => "readme - show content of README file");
      Put_Line (Item => "createnow [name] - create new site in ""name"" directory");
      Put_Line
        (Item => "create [name] - interactively create new site in ""name"" directory");
      Put_Line (Item => "build [name] - build site in ""name"" directory");
      Put_Line
        (Item =>
           "server [name] - start simple HTTP server in ""name"" directory and "
           & "auto rebuild site if needed.");
      Put_Line
        (Item => "createfile [name] - create new empty markdown file with ""name""");
   end Show_Help;

   -----------------
   -- Create_Site --
   -----------------

   procedure Create_Site (Directory : String; Interactive : Boolean) is
      use Ada.Directories;
      use Config;

      procedure Create_Dir (Path : String);

      procedure Create_Dir (Path : String) is
      begin
         Create_Path (Directory & Dir_Separator & Path);
      end Create_Dir;

      --      Path  : String renames To_String (Work_Directory);
   begin
      Create_Dir ("_layouts");
      Create_Dir ("_output");
      Create_Dir ("_modules" & Dir_Separator & "start");
      Create_Dir ("_modules" & Dir_Separator & "pre");
      Create_Dir ("_modules" & Dir_Separator & "post");
      Create_Dir ("_modules" & Dir_Separator & "end");

      if Interactive then
         Interactive_Site_Config;
      end if;
      Create_Site_Config (Directory_Name => Directory);

      Layouts.Create_Layout (Directory_Name => Directory);
      Layouts.Create_Directory_Layout (Directory_Name => Directory);
      Pages.Create_Empty_File (File_Name => Directory);

      Messages.Show_Message
        ("New page in directory """
         & Directory
         & """ was created. Edit """
         & Directory
         & Dir_Separator
         & "site.cfg"" file to set data for your new site.",
         Message_Type => Messages.SUCCESS);
   end Create_Site;

   ------------------------------
   -- Show_Version_Information --
   ------------------------------

   procedure Show_Version_Information is
      use Ada.Text_IO;
   begin
      Put_Line ("Version: " & Version);
      Put_Line ("Released: " & Released);
   end Show_Version_Information;

   ------------------------------
   -- Show_License_Information --
   ------------------------------

   procedure Show_License_Information is
      use Ada.Text_IO;
   begin
      Put_Line ("Copyright (C) 2022-2024 A.J. Ianozi");
      Put_Line ("Copyright (C) 2019-2021 Bartek thindil Jasicki");
      New_Line;
      Put_Line ("This program is free software: you can redistribute it and/or modify");
      Put_Line ("it under the terms of the GNU General Public License as published by");
      Put_Line ("the Free Software Foundation, either version 3 of the License, or");
      Put_Line ("(at your option) any later version.");
      New_Line;
      Put_Line ("This program is distributed in the hope that it will be useful,");
      Put_Line ("but WITHOUT ANY WARRANTY; without even the implied warranty of");
      Put_Line ("MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the");
      Put_Line ("GNU General Public License for more details.");
      New_Line;
      Put_Line ("You should have received a copy of the GNU General Public License");
      Put_Line ("along with this program.  If not, see <https://www.gnu.org/licenses/>.");
   end Show_License_Information;

   ----------------------
   -- Show_Readme_File --
   ----------------------

   procedure Show_Readme_File is
      use Ada.Text_IO;
   begin
      Show_Readme_Block :
      declare
         package Yass_Resources is new Resources (Crate_Name => "yass");

         Readme_Name : constant String :=
           Yass_Resources.Resource_Path & Dir_Separator & "README.md";

         Readme_File : File_Type;
      begin
         if not Ada.Directories.Exists (Name => Readme_Name) then
            Messages.Show_Message (Text => "Can't find file " & Readme_Name);
            return;
         end if;

         Open (File => Readme_File, Mode => In_File, Name => Readme_Name);

         Show_Readme_Loop :
         while not End_Of_File (Readme_File) loop
            Put_Line (Item => Get_Line (Readme_File));
         end loop Show_Readme_Loop;

         Close (Readme_File);

      end Show_Readme_Block;
   end Show_Readme_File;

   ------------------------
   -- Run_System_Command --
   ------------------------

   procedure Run_System_Command (Command : String; Success : out Boolean) is
      use GNAT.OS_Lib;

      Args : Argument_List_Access := Argument_String_To_List (Arg_String => Command);
   begin
      if Non_Blocking_Spawn
           (Program_Name => Args (Args'First).all,
            Args         => Args (Args'First + 1 .. Args'Last))
        = Invalid_Pid
      then
         Success := False;
      else
         Success := True;
      end if;

      Free (Args);
   end Run_System_Command;

   ----------------
   -- Serve_Site --
   ----------------

   procedure Serve_Site (Directory : String) is
      use Ada.Directories;
      use Ada.Text_IO;
      use Config;
   begin
      Load_Site_Config (Directory_Name => Directory);

      if not Ada.Directories.Exists (Name => To_String (Yass_Conf.Output_Directory)) then
         Create_Path (New_Directory => To_String (Yass_Conf.Output_Directory));
      end if;

      Set_Directory (Directory => To_String (Yass_Conf.Output_Directory));

      if Yass_Conf.Server_Enabled then
         if not Ada.Directories.Exists
                  (Name =>
                     To_String (Yass_Conf.Layouts_Directory)
                     & Dir_Separator
                     & "directory.html")
         then
            Layouts.Create_Directory_Layout (Directory_Name => "");
         end if;

         Server.Start_Server;

         if Yass_Conf.Browser_Command /= "none" then
            declare
               Success : Boolean;
            begin
               Run_System_Command (To_String (Yass_Conf.Browser_Command), Success);

               if not Success then
                  Put_Line
                    ("Can't start web browser. Please check your site "
                     & "configuration did it have proper value for "
                     & """BrowserCommand"" setting.");

                  Server.Shutdown_Server;

                  return;
               end if;
            end;
         end if;

      else
         Put_Line ("Started monitoring site changes. Press 'Q' to quit.");
      end if;

      Monitors.Monitor_Site.Start;
      Monitors.Monitor_Config.Start;

      AWS.Server.Wait (Mode => AWS.Server.Q_Key_Pressed);
      if Yass_Conf.Server_Enabled then
         Server.Shutdown_Server;
      else
         Put (Item => "Stopping monitoring site changes...");
      end if;

      Monitors.Monitor_Site.Stop;
      Monitors.Monitor_Config.Stop;

      Messages.Show_Message (Text => "done.", Message_Type => Messages.SUCCESS);

   exception
      when AWS.Net.Socket_Error =>
         Messages.Show_Message
           (Text =>
              "Can't start program in server mode. Probably another program is "
              & "using this same port, or you have still connected old instance of "
              & "the program in your browser. Please close whole browser and try "
              & "run the program again. If problem will persist, try to change "
              & "port for the server in the site configuration.");
   end Serve_Site;

   -----------------
   -- Create_File --
   -----------------

   procedure Create_File (Directory : String) is
      use Ada.Directories;
      use Ada.Text_IO;

      Cond : constant Boolean :=
        Ada.Strings.Fixed.Index
          (Source  => Directory,
           Pattern => Containing_Directory (Name => Current_Directory))
        = 1;

      Work_Directory_2 : constant String :=
        (if Cond then Directory else Current_Directory & Dir_Separator & Directory);

      Work_Directory : constant String :=
        (if Extension (Name => Work_Directory_2) /= "md"
         then Work_Directory_2 & ".md"
         else Work_Directory_2);
   begin
      if Ada.Directories.Exists (Name => Work_Directory) then
         Put_Line
           ("Can't create file """ & Work_Directory & """. File with that name exists.");
         return;
      end if;

      Create_Path (New_Directory => Containing_Directory (Name => Work_Directory));
      Pages.Create_Empty_File (File_Name => Work_Directory);

      Messages.Show_Message
        (Text         => "Empty file """ & Work_Directory & """ was created.",
         Message_Type => Messages.SUCCESS);
   end Create_File;

end Commands;
