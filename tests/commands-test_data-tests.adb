--  This package has been generated automatically by GNATtest.
--  You are allowed to add your code to the bodies of test routines.
--  Such changes will be kept during further regeneration of this file.
--  All code placed outside of test routine bodies will be lost. The
--  code intended to set up and tear down the test environment should be
--  placed into Commands.Test_Data.

with AUnit.Assertions; use AUnit.Assertions;
with System.Assertions;

--  begin read only
--  id:2.2/00/
--
--  This section can be used to add with clauses if necessary.
--
--  end read only

with Ada.Directories; use Ada.Directories;
with Config;          use Config;

--  begin read only
--  end read only
package body Commands.Test_Data.Tests is

--  begin read only
--  id:2.2/01/
--
--  This section can be used to add global variables and other elements.
--
--  end read only

--  begin read only
--  end read only
--  begin read only
   function Wrap_Test_To_Work_Directory_e8fba1_116ee6 (Directory : String)  return String
   is
   begin
      declare
         Test_To_Work_Directory_e8fba1_116ee6_Result : constant String := GNATtest_Generated.GNATtest_Standard.Commands.To_Work_Directory (Directory);
      begin
         return Test_To_Work_Directory_e8fba1_116ee6_Result;
      end;
   end Wrap_Test_To_Work_Directory_e8fba1_116ee6;
--  end read only

--  begin read only
   procedure Test_To_Work_Directory_test_to_work_directory (Gnattest_T : in out Test);
   procedure Test_To_Work_Directory_e8fba1_116ee6 (Gnattest_T : in out Test) renames Test_To_Work_Directory_test_to_work_directory;
--  id:2.2/e8fba17631e05769/To_Work_Directory/1/0/test_to_work_directory/
   procedure Test_To_Work_Directory_test_to_work_directory (Gnattest_T : in out Test) is
      function To_Work_Directory (Directory : String) return String renames Wrap_Test_To_Work_Directory_e8fba1_116ee6;
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

      Assert
        (To_Work_Directory (".") = Full_Name ("."),
         "Failed to resolve work directory to full path.");

--  begin read only
   end Test_To_Work_Directory_test_to_work_directory;
--  end read only

--  begin read only
   function Wrap_Test_Is_Valid_Project_Directory_217dd3_da8fb6 (Directory : String)  return Boolean
   is
   begin
      declare
         Test_Is_Valid_Project_Directory_217dd3_da8fb6_Result : constant Boolean := GNATtest_Generated.GNATtest_Standard.Commands.Is_Valid_Project_Directory (Directory);
      begin
         return Test_Is_Valid_Project_Directory_217dd3_da8fb6_Result;
      end;
   end Wrap_Test_Is_Valid_Project_Directory_217dd3_da8fb6;
--  end read only

--  begin read only
   procedure Test_Is_Valid_Project_Directory_test_is_valid_project_directory (Gnattest_T : in out Test);
   procedure Test_Is_Valid_Project_Directory_217dd3_da8fb6 (Gnattest_T : in out Test) renames Test_Is_Valid_Project_Directory_test_is_valid_project_directory;
--  id:2.2/217dd3c15619d54a/Is_Valid_Project_Directory/1/0/test_is_valid_project_directory/
   procedure Test_Is_Valid_Project_Directory_test_is_valid_project_directory (Gnattest_T : in out Test) is
      function Is_Valid_Project_Directory (Directory : String) return Boolean renames Wrap_Test_Is_Valid_Project_Directory_217dd3_da8fb6;
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

      Assert
        (not Is_Valid_Project_Directory ("."),
         "Directory without site.cfg should not be a valid project directory.");
      Create_Site_Config (".");
      Assert
        (Is_Valid_Project_Directory ("."),
         "Directory with site.cfg should be a valid project directory.");
      Delete_File ("site.cfg");

--  begin read only
   end Test_Is_Valid_Project_Directory_test_is_valid_project_directory;
--  end read only

--  begin read only
   procedure Wrap_Test_Build_Site_fd381d_489bc1 (Directory_Name : String; Success : out Boolean) 
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
               "req_sloc(commands.ads:0:):Test_Build_Site test requirement violated");
      end;
      GNATtest_Generated.GNATtest_Standard.Commands.Build_Site (Directory_Name, Success);
   end Wrap_Test_Build_Site_fd381d_489bc1;
--  end read only

--  begin read only
   procedure Test_Build_Site_test_build_site (Gnattest_T : in out Test);
   procedure Test_Build_Site_fd381d_489bc1 (Gnattest_T : in out Test) renames Test_Build_Site_test_build_site;
--  id:2.2/fd381d61b4d528dc/Build_Site/1/0/test_build_site/
   procedure Test_Build_Site_test_build_site (Gnattest_T : in out Test) is
      procedure Build_Site (Directory_Name : String; Success : out Boolean) renames Wrap_Test_Build_Site_fd381d_489bc1;
--  end read only

      pragma Unreferenced (Gnattest_T);

      Success : Boolean;

   begin

      Create_Site_Config (".");
      Load_Site_Config (".");
      Build_Site (".", Success);
      Assert (Success, "Failed to build site.");
      Delete_File ("site.cfg");
      Yass_Conf := Default_Parser_Configuration;
      Yass_Conf.Excluded_Files.Clear;

--  begin read only
   end Test_Build_Site_test_build_site;
--  end read only

--  begin read only
   procedure Wrap_Test_Show_Help_c4c329_2865b7
   is
   begin
      GNATtest_Generated.GNATtest_Standard.Commands.Show_Help;
   end Wrap_Test_Show_Help_c4c329_2865b7;
--  end read only

--  begin read only
   procedure Test_Show_Help_test_show_help (Gnattest_T : in out Test);
   procedure Test_Show_Help_c4c329_2865b7 (Gnattest_T : in out Test) renames Test_Show_Help_test_show_help;
--  id:2.2/c4c32928a41a8323/Show_Help/1/0/test_show_help/
   procedure Test_Show_Help_test_show_help (Gnattest_T : in out Test) is
      procedure Show_Help renames Wrap_Test_Show_Help_c4c329_2865b7;
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

      Show_Help;
      Assert (True, "Show_Help raised no exception.");

--  begin read only
   end Test_Show_Help_test_show_help;
--  end read only

--  begin read only
   procedure Wrap_Test_Show_Version_Information_40398e_b19232
   is
   begin
      GNATtest_Generated.GNATtest_Standard.Commands.Show_Version_Information;
   end Wrap_Test_Show_Version_Information_40398e_b19232;
--  end read only

--  begin read only
   procedure Test_Show_Version_Information_test_show_version_information (Gnattest_T : in out Test);
   procedure Test_Show_Version_Information_40398e_b19232 (Gnattest_T : in out Test) renames Test_Show_Version_Information_test_show_version_information;
--  id:2.2/40398ec7b9a60a1a/Show_Version_Information/1/0/test_show_version_information/
   procedure Test_Show_Version_Information_test_show_version_information (Gnattest_T : in out Test) is
      procedure Show_Version_Information renames Wrap_Test_Show_Version_Information_40398e_b19232;
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

      Show_Version_Information;
      Assert (True, "Show_Version_Information raised no exception.");

--  begin read only
   end Test_Show_Version_Information_test_show_version_information;
--  end read only

--  begin read only
   procedure Wrap_Test_Show_License_Information_1372c1_c464e9
   is
   begin
      GNATtest_Generated.GNATtest_Standard.Commands.Show_License_Information;
   end Wrap_Test_Show_License_Information_1372c1_c464e9;
--  end read only

--  begin read only
   procedure Test_Show_License_Information_test_show_license_information (Gnattest_T : in out Test);
   procedure Test_Show_License_Information_1372c1_c464e9 (Gnattest_T : in out Test) renames Test_Show_License_Information_test_show_license_information;
--  id:2.2/1372c1c6fba056a8/Show_License_Information/1/0/test_show_license_information/
   procedure Test_Show_License_Information_test_show_license_information (Gnattest_T : in out Test) is
      procedure Show_License_Information renames Wrap_Test_Show_License_Information_1372c1_c464e9;
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

      Show_License_Information;
      Assert (True, "Show_License_Information raised no exception.");

--  begin read only
   end Test_Show_License_Information_test_show_license_information;
--  end read only

--  begin read only
   procedure Wrap_Test_Show_Readme_File_6d8d3a_7fff58
   is
   begin
      GNATtest_Generated.GNATtest_Standard.Commands.Show_Readme_File;
   end Wrap_Test_Show_Readme_File_6d8d3a_7fff58;
--  end read only

--  begin read only
   procedure Test_Show_Readme_File_test_show_readme_file (Gnattest_T : in out Test);
   procedure Test_Show_Readme_File_6d8d3a_7fff58 (Gnattest_T : in out Test) renames Test_Show_Readme_File_test_show_readme_file;
--  id:2.2/6d8d3a0f161abc4a/Show_Readme_File/1/0/test_show_readme_file/
   procedure Test_Show_Readme_File_test_show_readme_file (Gnattest_T : in out Test) is
      procedure Show_Readme_File renames Wrap_Test_Show_Readme_File_6d8d3a_7fff58;
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

      Show_Readme_File;
      Assert (True, "Show_Readme_File raised no exception.");

--  begin read only
   end Test_Show_Readme_File_test_show_readme_file;
--  end read only

--  begin read only
   procedure Wrap_Test_Run_System_Command_d198a0_26a902 (Command : String; Success : out Boolean) 
   is
   begin
      GNATtest_Generated.GNATtest_Standard.Commands.Run_System_Command (Command, Success);
   end Wrap_Test_Run_System_Command_d198a0_26a902;
--  end read only

--  begin read only
   procedure Test_Run_System_Command_test_run_system_command (Gnattest_T : in out Test);
   procedure Test_Run_System_Command_d198a0_26a902 (Gnattest_T : in out Test) renames Test_Run_System_Command_test_run_system_command;
--  id:2.2/d198a0ab7b0117ad/Run_System_Command/1/0/test_run_system_command/
   procedure Test_Run_System_Command_test_run_system_command (Gnattest_T : in out Test) is
      procedure Run_System_Command (Command : String; Success : out Boolean) renames Wrap_Test_Run_System_Command_d198a0_26a902;
--  end read only

      pragma Unreferenced (Gnattest_T);

      Success : Boolean;

   begin

      Run_System_Command ("/bin/true", Success);
      Assert (Success, "Failed to run system command.");

--  begin read only
   end Test_Run_System_Command_test_run_system_command;
--  end read only

--  begin read only
   procedure Wrap_Test_Serve_Site_eab7d6_627bb0 (Directory : String) 
   is
   begin
      GNATtest_Generated.GNATtest_Standard.Commands.Serve_Site (Directory);
   end Wrap_Test_Serve_Site_eab7d6_627bb0;
--  end read only

--  begin read only
   procedure Test_Serve_Site_test_serve_site (Gnattest_T : in out Test);
   procedure Test_Serve_Site_eab7d6_627bb0 (Gnattest_T : in out Test) renames Test_Serve_Site_test_serve_site;
--  id:2.2/eab7d676303e89a0/Serve_Site/1/0/test_serve_site/
   procedure Test_Serve_Site_test_serve_site (Gnattest_T : in out Test) is
      procedure Serve_Site (Directory : String) renames Wrap_Test_Serve_Site_eab7d6_627bb0;
--  end read only

      pragma Unreferenced (Gnattest_T);
      pragma Unreferenced (Serve_Site);

   begin

      --  Serve_Site starts a blocking HTTP server and monitor tasks;
      --  not testable in an automated unit test context.
      Assert (True, "Serve_Site not exercised in unit tests.");

--  begin read only
   end Test_Serve_Site_test_serve_site;
--  end read only

--  begin read only
   procedure Wrap_Test_Create_File_8acb2f_cd5262 (Directory : String) 
   is
   begin
      GNATtest_Generated.GNATtest_Standard.Commands.Create_File (Directory);
   end Wrap_Test_Create_File_8acb2f_cd5262;
--  end read only

--  begin read only
   procedure Test_Create_File_test_create_site (Gnattest_T : in out Test);
   procedure Test_Create_File_8acb2f_cd5262 (Gnattest_T : in out Test) renames Test_Create_File_test_create_site;
--  id:2.2/8acb2f2d296152f4/Create_File/1/0/test_create_site/
   procedure Test_Create_File_test_create_site (Gnattest_T : in out Test) is
      procedure Create_File (Directory : String) renames Wrap_Test_Create_File_8acb2f_cd5262;
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

      Create_File ("test_commands_file");
      Assert
        (Exists ("test_commands_file.md"),
         "Failed to create empty markdown file.");
      Delete_File ("test_commands_file.md");

--  begin read only
   end Test_Create_File_test_create_site;
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
end Commands.Test_Data.Tests;
