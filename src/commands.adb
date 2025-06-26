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
with Ada.Environment_Variables;
with Ada.Strings.Unbounded;
with Ada.Text_IO;

with GNAT.Directory_Operations;

with AtomFeed;
with Config;
with Layouts;
with Messages;
with Modules;
with Sitemaps;
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

   Dir_Separator : Character renames GNAT.Directory_Operations.Dir_Separator;

   ----------------
   -- Build_Site --
   ----------------

   procedure Build_Site (Directory_Name : String;
                         Success        : out Boolean)
   is
      use Ada.Directories;

      use AtomFeed;
      use Config;
      use Modules;
      use Sitemaps;

      Page_Tags       : Tags_Container.Map := Tags_Container.Empty_Map;
      Page_Table_Tags : TableTags_Container.Map :=
        TableTags_Container.Empty_Map;

      procedure Build (Name : String)
      with
         Pre => Name'Length > 0;
      --  Build the site from directory with full path Name

      -----------
      -- Build --
      -----------

      procedure Build (Name : String)
      is
         procedure Process_Directories (Item : Directory_Entry_Type);
         --  Go recursive with directory with full path Item.

         -------------------
         -- Process_Files --
         -------------------

         procedure Process_Files (Item : Directory_Entry_Type);
         --  Process file with full path Item: create html pages from markdown
         --  files or copy any other file.

         procedure Process_Files (Item : Directory_Entry_Type)
         is
            Simple_Nam : String renames Simple_Name (Directory_Entry => Item);
            Full_Nam   : String renames Full_Name   (Directory_Entry => Item);
         begin
            if
              Yass_Config.Excluded_Files.Find_Index
                (Item => Simple_Nam) /=
              Excluded_Container.No_Index or
              not Ada.Directories.Exists (Name => Full_Nam)
            then
               return;
            end if;

            Ada.Environment_Variables.Set
              (Name  => "YASSFILE",
               Value => Full_Nam);

            if Extension (Name => Simple_Nam) = "md" then
               Pages.Create_Page
                 (File_Name => Full_Nam,
                  Directory => Name);
            else
               Pages.Copy_File
                 (File_Name => Full_Nam,
                  Directory => Name);
            end if;
         end Process_Files;

         -------------------------
         -- Process_Directories --
         -------------------------

         procedure Process_Directories (Item : Directory_Entry_Type) is
         begin
            if Yass_Config.Excluded_Files.Find_Index
                (Item => Simple_Name (Directory_Entry => Item)) =
              Excluded_Container.No_Index and
              Ada.Directories.Exists
                (Name => Full_Name(Directory_Entry => Item)) then
               Build (Name => Full_Name(Directory_Entry => Item));
            end if;
         exception
            when Ada.Directories.Name_Error =>
               null;
         end Process_Directories;

      begin
         Search
           (Directory => Name, Pattern => "",
            Filter => (Directory => False, others => True),
            Process => Process_Files'Access);

         Search
           (Directory => Name, Pattern => "",
            Filter => (Directory => True, others => False),
            Process => Process_Directories'Access);
      end Build;

   begin
      --  Load the program modules with 'start' hook
      Load_Modules
        (State           => "start",
         Page_Tags       => Page_Tags,
         Page_Table_Tags => Page_Table_Tags);

      --  Load data from exisiting sitemap or create new set of data or
      --  nothing if sitemap generation is disabled
      Start_Sitemap;

      --  Load data from existing atom feed or create new set of data or
      --  nothing if atom feed generation is disabled
      Start_Atom_Feed;

      --  Build the site
      Build (Name => Directory_Name);

      --  Save atom feed to file or nothing if atom feed generation is disabled
      Save_Atom_Feed;

      --  Save sitemap to file or nothing if sitemap generation is disabled
      Save_Sitemap;

      -- Load the program modules with 'end' hook
      Load_Modules
        (State           => "end",
         Page_Tags       => Page_Tags,
         Page_Table_Tags => Page_Table_Tags);

      Success := True;

   exception
      when Pages.Generate_Site_Exception =>
         Success := False;

   end Build_Site;

   ------------
   -- Create --
   ------------

   procedure Create (Is_Create      : Boolean;
                     Work_Directory : String)
   is
      use Ada.Directories;
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

   ------------------
   -- Show_License --
   ------------------

   procedure Show_License is
   begin
      Put_Line (Item => "Copyright (C) 2022-2024 A.J. Ianozi");
      Put_Line (Item => "Copyright (C) 2019-2021 Bartek thindil Jasicki");
      New_Line;
      Put_Line
        (Item =>
           "This program is free software: you can redistribute it and/or modify");
      Put_Line
        (Item =>
           "it under the terms of the GNU General Public License as published by");
      Put_Line
        (Item =>
           "the Free Software Foundation, either version 3 of the License, or");
      Put_Line (Item => "(at your option) any later version.");
      New_Line;
      Put_Line
        (Item =>
           "This program is distributed in the hope that it will be useful,");
      Put_Line
        (Item =>
           "but WITHOUT ANY WARRANTY; without even the implied warranty of");
      Put_Line
        (Item =>
           "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the");
      Put_Line (Item => "GNU General Public License for more details.");
      New_Line;
      Put_Line
        (Item =>
           "You should have received a copy of the GNU General Public License");
      Put_Line
        (Item =>
           "along with this program.  If not, see <https://www.gnu.org/licenses/>.");
   end Show_License;

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

   -----------------
   -- Show_Readme --
   -----------------

   procedure Show_Readme (Command_Name : String)
   is
      use Ada.Environment_Variables;
      use Ada.Directories;

      Readme_Name : constant String :=
        (if Ada.Environment_Variables.Exists (Name => "APPDIR")
         then Value (Name => "APPDIR") & "/usr/share/doc/yass/README.md"
         else Containing_Directory (Name => Command_Name) & Dir_Separator &
              "README.md");
      Readme_File : File_Type;
   begin
      if not Ada.Directories.Exists (Name => Readme_Name) then
         Messages.Show_Message (Text => "Can't find file " & Readme_Name);
         return;
      end if;

      Open (File => Readme_File, Mode => In_File, Name => Readme_Name);

      Show_Readme_Loop :
      while not End_Of_File(File => Readme_File) loop
         Put_Line (Item => Get_Line (File => Readme_File));
      end loop Show_Readme_Loop;

      Close (File => Readme_File);

   end Show_Readme;

end Commands;
