--  This package has been generated automatically by GNATtest.
--  You are allowed to add your code to the bodies of test routines.
--  Such changes will be kept during further regeneration of this file.
--  All code placed outside of test routine bodies will be lost. The
--  code intended to set up and tear down the test environment should be
--  placed into Config.Test_Data.

with AUnit.Assertions; use AUnit.Assertions;
with System.Assertions;

--  begin read only
--  id:2.2/00/
--
--  This section can be used to add with clauses if necessary.
--
--  end read only

--  begin read only
--  end read only
package body Config.Test_Data.Tests is

--  begin read only
--  id:2.2/01/
--
--  This section can be used to add global variables and other elements.
--
--  end read only

--  begin read only
--  end read only

--  begin read only
   procedure Test_CreateConfig (Gnattest_T : in out Test);
   procedure Test_CreateConfig_dacee6 (Gnattest_T : in out Test) renames Test_CreateConfig;
--  id:2.2/dacee6cbb2f9f014/CreateConfig/1/0/
   procedure Test_CreateConfig (Gnattest_T : in out Test) is
   --  config.ads:85:4:CreateConfig
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

      AUnit.Assertions.Assert
        (Gnattest_Generated.Default_Assert_Value,
         "Test not implemented.");

--  begin read only
   end Test_CreateConfig;
--  end read only


--  begin read only
   procedure Test_ParseConfig (Gnattest_T : in out Test);
   procedure Test_ParseConfig_4edbef (Gnattest_T : in out Test) renames Test_ParseConfig;
--  id:2.2/4edbef205076ce8c/ParseConfig/1/0/
   procedure Test_ParseConfig (Gnattest_T : in out Test) is
   --  config.ads:87:4:ParseConfig
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

      AUnit.Assertions.Assert
        (Gnattest_Generated.Default_Assert_Value,
         "Test not implemented.");

--  begin read only
   end Test_ParseConfig;
--  end read only

--  begin read only
--  id:2.2/02/
--
--  This section can be used to add elaboration code for the global state.
--
begin
--  end read only
   null;
--  begin read only
--  end read only
end Config.Test_Data.Tests;
