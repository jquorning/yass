--    Copyright 2019 Bartek thindil Jasicki
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

with Config; use Config;

-- ****h* Yass/Modules
-- FUNCTION
-- Provide code for operating the program modules
-- SOURCE
package Modules is
-- ****

   -- ****f* Modules/LoadModules
   -- FUNCTION
   -- Load all modules for selected state: start, pre, post, end. PageTags and
   -- PageTableTags will be empty in all states except pre and post for
   -- markdown files.
   -- PARAMETERS
   -- State         - State of the program in which module are loaded
   -- PageTags      - All current processed page tags with their contents
   -- PageTableTags - All current processed page table tags with their contents
   -- SOURCE
   procedure LoadModules
     (State: String; PageTags: in out Tags_Container.Map;
      PageTableTags: in out TableTags_Container.Map);
   -- ****

end Modules;
