--  Copyright 2019-2021 Bartek thindil Jasicki
--  Copyright 2022-2024 A.J. Ianozi
--  Cpypright 2026      Jesper Quorning
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

package Commands is

   -- ****if* YASS/Commands.To_Work_Directory
   -- SOURCE
   function To_Work_Directory (Directory : String) return String
   with Test_Case => (Name => "Test_To_Work_Directory", Mode => Nominal);
   -- FUNCTION
   -- Return full name of Directory.
   -- PARAMETERS
   -- Directory - Relative path to the site directory
   -- RESULT
   -- Full name of Directory.
   -- ****

   -- ****if* YASS/Commands.Is_Valid_Project_Directory
   -- SOURCE
   function Is_Valid_Project_Directory (Directory : String) return Boolean
   with Test_Case => (Name => "Test_Is_Valid_Project_Directory", Mode => Nominal);
   -- FUNCTION
   -- If Directory contains site.cfg file.
   -- PARAMETERS
   -- Directory - Full path to the site directory
   -- RESULT
   -- True if Directory contains site.cfg file.
   -- ****

   -- ****if* YASS/Commands.Build_Site
   -- SOURCE
   procedure Build_Site (Directory_Name : String; Success : out Boolean)
   with
     Test_Case => (Name => "Test_Build_Site", Mode => Nominal),
     Pre       => Directory_Name'Length > 0;
   -- FUNCTION
   -- Build the site from directory
   -- PARAMETERS
   -- Directory_Name - Full path to the site directory.
   -- Success - True when site was build successfully.
   -- ****

   -- ****if* YASS/Commands.Show_Help
   -- SOURCE
   procedure Show_Help
   with Test_Case => (Name => "Test_Show_Help", Mode => Nominal);
   -- FUNCTION
   -- Show the program help - list of available commands
   -- ****

   -- ****if* YASS/Commands.Show_Version_Information
   -- SOURCE
   procedure Show_Version_Information
   with Test_Case => (Name => "Test_Show_Version_Information", Mode => Nominal);
   -- FUNCTION
   -- Show version information.
   -- ****

   -- ****if* YASS/Commands.Show_License_Information
   -- SOURCE
   procedure Show_License_Information
   with Test_Case => (Name => "Test_Show_License_Information", Mode => Nominal);
   -- FUNCTION
   -- Show the license information.
   -- ****

   -- ****if* YASS/Commands.Show_Readme_File
   -- SOURCE
   procedure Show_Readme_File
   with Test_Case => (Name => "Test_Show_Readme_File", Mode => Nominal);
   -- FUNCTION
   -- Show the readme file.
   -- ****

   -- ****if* YASS/Commands.Run_System_Command
   -- SOURCE
   procedure Run_System_Command (Command : String; Success : out Boolean)
   with Test_Case => (Name => "Test_Run_System_Command", Mode => Nominal);
   -- FUNCTION
   -- Run Command.
   -- PARAMETERS
   -- Command - Full path to command to run.
   -- Success - True when command was started successfully.
   -- ****

   -- ****if* YASS/Commands.Create_Site
   -- SOURCE
   procedure Create_Site (Directory : String; Interactive : Boolean);
   -- FUNCTION
   -- Create site.
   -- PARAMETERS
   -- Directory - Full path to the site directory.
   -- Interactive - If user should input parameters interactively.
   -- ****

   -- ****if* YASS/Commands.Server_Site
   -- SOURCE
   procedure Serve_Site (Directory : String)
   with Test_Case => (Name => "Test_Serve_Site", Mode => Nominal);
   -- FUNCTION
   -- Server site.
   -- PARAMETERS
   -- Directory - Full path to the site directory.
   -- ****

   -- ****if* YASS/Commands.Create_File
   -- SOURCE
   procedure Create_File (Directory : String)
   with Test_Case => (Name => "Test_Create_Site", Mode => Nominal);
   -- FUNCTION
   -- Create file.
   -- PARAMETERS
   -- Directory - Full path to the site directory.
   -- ****

end Commands;
