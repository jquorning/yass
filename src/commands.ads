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

with Ada.Strings.Unbounded;

-- ****h* Yass/Commands
-- SOURCE
package Commands is
-- FUNCTION
-- Yass commands
-- ****

   -- *****f* Command/Build_Site
   -- SOURCE
   procedure Build_Site (Directory_Name :     String;
                         Success        : out Boolean)
   with
      Pre => Directory_Name'Length > 0;
   -- FUNCTION
   -- Build the site from directory
   -- PARAMETERS
   -- Directory_Name - Full path to the site directory
   -- Success - Success of operation
   -- RESULT
   -- Returns True if the site was build, otherwise False.
   -- ****

   -- ****f* Commands/Create
   -- SOURCE
   procedure Create (Is_Create      : Boolean;
                     Work_Directory : String);
   -- FUNCTION
   -- Create
   -- PARAMETERS
   -- Is_Create - True: 'create' command, False: 'createnow' command
   -- Work_Directory - Work directory
   -- ****

   -- ****f* Commands/Create_File
   -- SOURCE
   procedure Create_File
      (Work_Directory : in out Ada.Strings.Unbounded.Unbounded_String;
       File_Name      :        String);
   -- FUNCTION
   -- Createfile
   -- PARAMETERS
   -- Work_Directory - Work directory
   -- File_Name - Name of md file
   -- ****

   -- ****f* Commands/Server_Command
   -- SOURCE
   procedure Server_Command (Work_Directory : String);
   -- FUNCTION
   -- Start server to monitor changes in selected site project
   -- PARAMETERS
   -- Work_Directory - Work directory
   -- ****

   -- ****f* Commands/Show_Help
   -- SOURCE
   procedure Show_Help;
   -- FUNCTION
   -- Show the program help - list of available commands
   -- ****

   -- ****f* Commands/Show_License
   -- SOURCE
   procedure Show_License;
   -- FUNCTION
   -- Show license
   -- ****

   -- ****f* Commands/Show_Readme
   -- SOURCE
   procedure Show_Readme (Command_Name : String);
   -- FUNCTION
   -- Show readme.md
   -- ****

end Commands;
