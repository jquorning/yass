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

-- ****h* Yass/Commands
-- FUNCTION
-- Yass commands
-- SOURCE
package Commands is
-- ****

   -- ****if* Command/Build_Site
   -- FUNCTION
   -- Build the site from directory
   -- PARAMETERS
   -- Directory_Name - full path to the site directory
   -- Success - Success of operation
   -- RESULT
   -- Returns True if the site was build, otherwise False.
   -- SOURCE
   procedure Build_Site (Directory_Name : String;
                         Success        : out Boolean)
   with
      Pre => Directory_Name'Length > 0;
   -- ****

   -- ****f* Commands/Create
   -- FUNCTION
   -- Create
   -- ARGUMENTS
   -- Is_Create - True: 'create' command, False: 'createnow' command
   -- Work_Directory - Work directory
   -- SOURCE
   procedure Create (Is_Create      : Boolean;
                     Work_Directory : String);
   -- ****

   -- ****f* Commands/Show_License
   -- FUNCTION
   -- Show license
   -- SOURCE
   procedure Show_License;
   -- ****

   -- ****f* Commands/Show_Help
   -- FUNCTION
   -- Show the program help - list of available commands
   -- SOURCE
   procedure Show_Help;
   -- ****

end Commands;
