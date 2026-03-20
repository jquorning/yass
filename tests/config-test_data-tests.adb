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

with Ada.Directories; use Ada.Directories;

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
   procedure Wrap_Test_Create_Site_Config_842f15_54b31b (Directory_Name : String) 
   is
   begin
      begin
         pragma Assert
           (Directory_Name'Length > 0);
         null;
      exception
         when System.Assertions.Assert_Failure =>
            AUnit.Assertions.Assert
              (False,
               "req_sloc(config.ads:0:):Test_Create_Site_Config test requirement violated");
      end;
      GNATtest_Generated.GNATtest_Standard.Config.Create_Site_Config (Directory_Name);
   end Wrap_Test_Create_Site_Config_842f15_54b31b;
--  end read only

--  begin read only
   procedure Test_Create_Site_Config_test_create_site_config (Gnattest_T : in out Test);
   procedure Test_Create_Site_Config_842f15_54b31b (Gnattest_T : in out Test) renames Test_Create_Site_Config_test_create_site_config;
--  id:2.2/842f1521fafb3929/Create_Site_Config/1/0/test_create_site_config/
   procedure Test_Create_Site_Config_test_create_site_config (Gnattest_T : in out Test) is
      procedure Create_Site_Config (Directory_Name : String) renames Wrap_Test_Create_Site_Config_842f15_54b31b;
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

      AUnit.Assertions.Assert
        (Gnattest_Generated.Default_Assert_Value,
         "Test not implemented.");

--  begin read only
   end Test_Create_Site_Config_test_create_site_config;
--  end read only

--  begin read only
   procedure Wrap_Test_Load_Site_Config_a9348d_aefb46 (Directory_Name : String) 
   is
   begin
      begin
         pragma Assert
           (Directory_Name'Length > 0);
         null;
      exception
         when System.Assertions.Assert_Failure =>
            AUnit.Assertions.Assert
              (False,
               "req_sloc(config.ads:0:):Test_Load_Site_Config test requirement violated");
      end;
      GNATtest_Generated.GNATtest_Standard.Config.Load_Site_Config (Directory_Name);
   end Wrap_Test_Load_Site_Config_a9348d_aefb46;
--  end read only

--  begin read only
   procedure Test_Load_Site_Config_test_load_site_config (Gnattest_T : in out Test);
   procedure Test_Load_Site_Config_a9348d_aefb46 (Gnattest_T : in out Test) renames Test_Load_Site_Config_test_load_site_config;
--  id:2.2/a9348dc236de57ec/Load_Site_Config/1/0/test_load_site_config/
   procedure Test_Load_Site_Config_test_load_site_config (Gnattest_T : in out Test) is
      procedure Load_Site_Config (Directory_Name : String) renames Wrap_Test_Load_Site_Config_a9348d_aefb46;
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

      AUnit.Assertions.Assert
        (Gnattest_Generated.Default_Assert_Value,
         "Test not implemented.");

--  begin read only
   end Test_Load_Site_Config_test_load_site_config;
--  end read only


--  begin read only
   --  procedure Test_Parse_Config_test_parse_config (Gnattest_T : in out Test);
   --  procedure Test_Parse_Config_31244b_test_parse_config (Gnattest_T : in out Test) renames Test_Parse_Config_test_parse_config;
--  id:2.2/31244ba1905b93dd/Parse_Config/1/1/test_parse_config/
   --  procedure Test_Parse_Config_test_parse_config (Gnattest_T : in out Test) is
--  end read only
--  
--        pragma Unreferenced(Gnattest_T);
--  
--     begin
--  
--        Yass_Config.Language := To_Unbounded_String("pl");
--        Parse_Config(".");
--        Assert
--          (Yass_Config.Language = To_Unbounded_String("en"),
--           "Failed to parse the program configuration file.");
--  
--  begin read only
   --  end Test_Parse_Config_test_parse_config;
--  end read only


--  begin read only
   --  procedure Test_Create_Config_test_create_config (Gnattest_T : in out Test);
   --  procedure Test_Create_Config_683023_test_create_config (Gnattest_T : in out Test) renames Test_Create_Config_test_create_config;
--  id:2.2/6830236232fc055b/Create_Config/1/1/test_create_config/
   --  procedure Test_Create_Config_test_create_config (Gnattest_T : in out Test) is
--  end read only
--  
--        pragma Unreferenced(Gnattest_T);
--  
--     begin
--  
--        Create_Config(".");
--        Assert
--          (Exists("site.cfg"),
--           "Failed to create the project configuration file.");
--  
--  begin read only
   --  end Test_Create_Config_test_create_config;
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
