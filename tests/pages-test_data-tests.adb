--  This package has been generated automatically by GNATtest.
--  You are allowed to add your code to the bodies of test routines.
--  Such changes will be kept during further regeneration of this file.
--  All code placed outside of test routine bodies will be lost. The
--  code intended to set up and tear down the test environment should be
--  placed into Pages.Test_Data.

with AUnit.Assertions; use AUnit.Assertions;
with System.Assertions;

--  begin read only
--  id:2.2/00/
--
--  This section can be used to add with clauses if necessary.
--
--  end read only

with Ada.Directories; use Ada.Directories;
with Config; use Config;
with Sitemaps; use Sitemaps;
with Templates_Parser; use Templates_Parser;

--  begin read only
--  end read only
package body Pages.Test_Data.Tests is

--  begin read only
--  id:2.2/01/
--
--  This section can be used to add global variables and other elements.
--
--  end read only

--  begin read only
--  end read only
--  begin read only
   procedure Wrap_Test_Create_Page_132cad_e3720d (File_Name : String; Directory : String) 
   is
   begin
      begin
         pragma Assert
           (File_Name'Length > 0 and Directory'Length > 0);
         null;
      exception
         when System.Assertions.Assert_Failure =>
            AUnit.Assertions.Assert
              (False,
               "req_sloc(pages.ads:0:):Test_Create_Page test requirement violated");
      end;
      GNATtest_Generated.GNATtest_Standard.Pages.Create_Page (File_Name, Directory);
   end Wrap_Test_Create_Page_132cad_e3720d;
--  end read only

--  begin read only
   procedure Test_Create_Page_test_create_page (Gnattest_T : in out Test);
   procedure Test_Create_Page_132cad_e3720d (Gnattest_T : in out Test) renames Test_Create_Page_test_create_page;
--  id:2.2/132cad00a9fe80a5/Create_Page/1/0/test_create_page/
   procedure Test_Create_Page_test_create_page (Gnattest_T : in out Test) is
      procedure Create_Page (File_Name : String; Directory : String) renames Wrap_Test_Create_Page_132cad_e3720d;
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

      Start_Sitemap;
      Create_Empty_File ("test.md");
      Create_Page ("test.md", ".");
      Assert
        (Exists ("_output/test.html"),
         "Failed to create a new HTML page from Markdown file.");

--  begin read only
   end Test_Create_Page_test_create_page;
--  end read only

--  begin read only
   procedure Wrap_Test_Copy_File_e8c103_a56046 (File_Name : String; Directory : String) 
   is
   begin
      begin
         pragma Assert
           (File_Name'Length > 0 and Directory'Length > 0);
         null;
      exception
         when System.Assertions.Assert_Failure =>
            AUnit.Assertions.Assert
              (False,
               "req_sloc(pages.ads:0:):Test_Copy_File test requirement violated");
      end;
      GNATtest_Generated.GNATtest_Standard.Pages.Copy_File (File_Name, Directory);
   end Wrap_Test_Copy_File_e8c103_a56046;
--  end read only

--  begin read only
   procedure Test_Copy_File_test_copy_file (Gnattest_T : in out Test);
   procedure Test_Copy_File_e8c103_a56046 (Gnattest_T : in out Test) renames Test_Copy_File_test_copy_file;
--  id:2.2/e8c1032cbe7c3240/Copy_File/1/0/test_copy_file/
   procedure Test_Copy_File_test_copy_file (Gnattest_T : in out Test) is
      procedure Copy_File (File_Name : String; Directory : String) renames Wrap_Test_Copy_File_e8c103_a56046;
--  end read only

      pragma Unreferenced(Gnattest_T);

   begin

      Pages.Copy_File("test.md", ".");
      Assert
        (Exists("_output/test.md"),
         "Failed to copy file to output directory.");

--  begin read only
   end Test_Copy_File_test_copy_file;
--  end read only

--  begin read only
   procedure Wrap_Test_Create_Empty_File_07d252_7a3630 (File_Name : String) 
   is
   begin
      begin
         pragma Assert
           (File_Name'Length > 0);
         null;
      exception
         when System.Assertions.Assert_Failure =>
            AUnit.Assertions.Assert
              (False,
               "req_sloc(pages.ads:0:):Test_Create_Empty_File test requirement violated");
      end;
      GNATtest_Generated.GNATtest_Standard.Pages.Create_Empty_File (File_Name);
   end Wrap_Test_Create_Empty_File_07d252_7a3630;
--  end read only

--  begin read only
   procedure Test_Create_Empty_File_test_create_empty_file (Gnattest_T : in out Test);
   procedure Test_Create_Empty_File_07d252_7a3630 (Gnattest_T : in out Test) renames Test_Create_Empty_File_test_create_empty_file;
--  id:2.2/07d2529fa48cbec9/Create_Empty_File/1/0/test_create_empty_file/
   procedure Test_Create_Empty_File_test_create_empty_file (Gnattest_T : in out Test) is
      procedure Create_Empty_File (File_Name : String) renames Wrap_Test_Create_Empty_File_07d252_7a3630;
--  end read only

      pragma Unreferenced(Gnattest_T);

   begin

      Create_Empty_File("mynewfile.md");
      Assert(Exists("mynewfile.md"), "Failed to create empty Markdown file.");
      Delete_File("mynewfile.md");

--  begin read only
   end Test_Create_Empty_File_test_create_empty_file;
--  end read only

--  begin read only
   function Wrap_Test_Get_Layout_Name_dd1d05_d0feda (File_Name : String)  return String
   is
   begin
      begin
         pragma Assert
           (File_Name'Length > 0);
         null;
      exception
            when System.Assertions.Assert_Failure =>
               AUnit.Assertions.Assert
                 (False,
                  "req_sloc(pages.ads:0:):Test_Get_Layout_Name test requirement violated");
      end;
      declare
         Test_Get_Layout_Name_dd1d05_d0feda_Result : constant String := GNATtest_Generated.GNATtest_Standard.Pages.Get_Layout_Name (File_Name);
      begin
         return Test_Get_Layout_Name_dd1d05_d0feda_Result;
      end;
   end Wrap_Test_Get_Layout_Name_dd1d05_d0feda;
--  end read only

--  begin read only
   procedure Test_Get_Layout_Name_test_get_layout_name (Gnattest_T : in out Test);
   procedure Test_Get_Layout_Name_dd1d05_d0feda (Gnattest_T : in out Test) renames Test_Get_Layout_Name_test_get_layout_name;
--  id:2.2/dd1d05e38a591979/Get_Layout_Name/1/0/test_get_layout_name/
   procedure Test_Get_Layout_Name_test_get_layout_name (Gnattest_T : in out Test) is
      function Get_Layout_Name (File_Name : String) return String renames Wrap_Test_Get_Layout_Name_dd1d05_d0feda;
--  end read only

      pragma Unreferenced(Gnattest_T);

   begin

      Assert
        (Get_Layout_Name("test.md") = "_layouts/default.html",
         "Failed to get the path to the selected layout.");

--  begin read only
   end Test_Get_Layout_Name_test_get_layout_name;
--  end read only

--  begin read only
   function Wrap_Test_Get_Tag_Name_460882_6ea913 (Item : String)  return String
   is
   begin
      declare
         Test_Get_Tag_Name_460882_6ea913_Result : constant String := GNATtest_Generated.GNATtest_Standard.Pages.Get_Tag_Name (Item);
      begin
         return Test_Get_Tag_Name_460882_6ea913_Result;
      end;
   end Wrap_Test_Get_Tag_Name_460882_6ea913;
--  end read only

--  begin read only
   procedure Test_Get_Tag_Name_test_get_tag_name (Gnattest_T : in out Test);
   procedure Test_Get_Tag_Name_460882_6ea913 (Gnattest_T : in out Test) renames Test_Get_Tag_Name_test_get_tag_name;
--  id:2.2/4608820eac02f9e5/Get_Tag_Name/1/0/test_get_tag_name/
   procedure Test_Get_Tag_Name_test_get_tag_name (Gnattest_T : in out Test) is
      function Get_Tag_Name (Item : String) return String renames Wrap_Test_Get_Tag_Name_460882_6ea913;
--  end read only

      pragma Unreferenced(Gnattest_T);
   begin
      AUnit.Assertions.Assert (Get_Tag_Name (""), "", "Test_01");
      AUnit.Assertions.Assert (Get_Tag_Name (" "), "", "Test_02");
      AUnit.Assertions.Assert (Get_Tag_Name (":"), "", "Test_03");
      AUnit.Assertions.Assert (Get_Tag_Name (" name "), "", "Test_04");
      AUnit.Assertions.Assert (Get_Tag_Name (" name : "), "name", "Test_05");

      AUnit.Assertions.Assert
        (Get_Tag_Name (" name : value "), "name", "Test_06");

--  begin read only
   end Test_Get_Tag_Name_test_get_tag_name;
--  end read only

--  begin read only
   function Wrap_Test_Get_Tag_Value_fd7c47_c021a2 (Item : String)  return String
   is
   begin
      declare
         Test_Get_Tag_Value_fd7c47_c021a2_Result : constant String := GNATtest_Generated.GNATtest_Standard.Pages.Get_Tag_Value (Item);
      begin
         return Test_Get_Tag_Value_fd7c47_c021a2_Result;
      end;
   end Wrap_Test_Get_Tag_Value_fd7c47_c021a2;
--  end read only

--  begin read only
   procedure Test_Get_Tag_Value_test_get_tag_value (Gnattest_T : in out Test);
   procedure Test_Get_Tag_Value_fd7c47_c021a2 (Gnattest_T : in out Test) renames Test_Get_Tag_Value_test_get_tag_value;
--  id:2.2/fd7c478aacdbf822/Get_Tag_Value/1/0/test_get_tag_value/
   procedure Test_Get_Tag_Value_test_get_tag_value (Gnattest_T : in out Test) is
      function Get_Tag_Value (Item : String) return String renames Wrap_Test_Get_Tag_Value_fd7c47_c021a2;
--  end read only

      pragma Unreferenced(Gnattest_T);
   begin
      AUnit.Assertions.Assert (Get_Tag_Value (""), "", "Test_01");
      AUnit.Assertions.Assert (Get_Tag_Value (" "), "", "Test_02");
      AUnit.Assertions.Assert (Get_Tag_Value (":"), "", "Test_03");

      AUnit.Assertions.Assert
        (Get_Tag_Value ("name:value"), "value", "Test_04");

      AUnit.Assertions.Assert
        (Get_Tag_Value ("name: value"), "value", "Test_05");

      AUnit.Assertions.Assert
        (Get_Tag_Value (" name : value "), "value", "Test_06");

      AUnit.Assertions.Assert
        (Get_Tag_Value (": value "), "value", "Test_07");

--  begin read only
   end Test_Get_Tag_Value_test_get_tag_value;
--  end read only

--  begin read only
   function Wrap_Test_Is_Frequency_Value_e01f1a_9b3d62 (Value : String)  return Boolean
   is
   begin
      declare
         Test_Is_Frequency_Value_e01f1a_9b3d62_Result : constant Boolean := GNATtest_Generated.GNATtest_Standard.Pages.Is_Frequency_Value (Value);
      begin
         return Test_Is_Frequency_Value_e01f1a_9b3d62_Result;
      end;
   end Wrap_Test_Is_Frequency_Value_e01f1a_9b3d62;
--  end read only

--  begin read only
   procedure Test_Is_Frequency_Value_test_is_frequency_value (Gnattest_T : in out Test);
   procedure Test_Is_Frequency_Value_e01f1a_9b3d62 (Gnattest_T : in out Test) renames Test_Is_Frequency_Value_test_is_frequency_value;
--  id:2.2/e01f1aae0724c6e1/Is_Frequency_Value/1/0/test_is_frequency_value/
   procedure Test_Is_Frequency_Value_test_is_frequency_value (Gnattest_T : in out Test) is
      function Is_Frequency_Value (Value : String) return Boolean renames Wrap_Test_Is_Frequency_Value_e01f1a_9b3d62;
--  end read only

      pragma Unreferenced(Gnattest_T);
   begin
      AUnit.Assertions.Assert(Is_Frequency_Value("daily") = True, "Test_01");
      AUnit.Assertions.Assert(Is_Frequency_Value("day") = False, "Test_02");
      AUnit.Assertions.Assert(Is_Frequency_Value("allways") = False, "Test_03");
      AUnit.Assertions.Assert(Is_Frequency_Value("always") = True, "Test_04");

--  begin read only
   end Test_Is_Frequency_Value_test_is_frequency_value;
--  end read only

--  begin read only
   function Wrap_Test_Is_Priority_Value_b10801_bab02b (Value : String)  return Boolean
   is
   begin
      declare
         Test_Is_Priority_Value_b10801_bab02b_Result : constant Boolean := GNATtest_Generated.GNATtest_Standard.Pages.Is_Priority_Value (Value);
      begin
         return Test_Is_Priority_Value_b10801_bab02b_Result;
      end;
   end Wrap_Test_Is_Priority_Value_b10801_bab02b;
--  end read only

--  begin read only
   procedure Test_Is_Priority_Value_test_is_priority_value (Gnattest_T : in out Test);
   procedure Test_Is_Priority_Value_b10801_bab02b (Gnattest_T : in out Test) renames Test_Is_Priority_Value_test_is_priority_value;
--  id:2.2/b108014474d7bcac/Is_Priority_Value/1/0/test_is_priority_value/
   procedure Test_Is_Priority_Value_test_is_priority_value (Gnattest_T : in out Test) is
      function Is_Priority_Value (Value : String) return Boolean renames Wrap_Test_Is_Priority_Value_b10801_bab02b;
--  end read only

      pragma Unreferenced(Gnattest_T);
   begin
      AUnit.Assertions.Assert(Is_Priority_Value("0.0") = True, "Test_01");
      AUnit.Assertions.Assert(Is_Priority_Value("1.0") = True, "Test_02");
      AUnit.Assertions.Assert(Is_Priority_Value("0.5") = True, "Test_03");
      AUnit.Assertions.Assert(Is_Priority_Value("-0.5") = False, "Test_04");
      AUnit.Assertions.Assert(Is_Priority_Value("1.5") = False, "Test_05");

--  begin read only
   end Test_Is_Priority_Value_test_is_priority_value;
--  end read only

--  begin read only
   function Wrap_Test_Parse_Content_2dd699_082dcd (Tags : Templates_Parser.Translate_Set; Content : String)  return String
   is
   begin
      declare
         Test_Parse_Content_2dd699_082dcd_Result : constant String := GNATtest_Generated.GNATtest_Standard.Pages.Parse_Content (Tags, Content);
      begin
         return Test_Parse_Content_2dd699_082dcd_Result;
      end;
   end Wrap_Test_Parse_Content_2dd699_082dcd;
--  end read only

--  begin read only
   procedure Test_Parse_Content_test_parse_content (Gnattest_T : in out Test);
   procedure Test_Parse_Content_2dd699_082dcd (Gnattest_T : in out Test) renames Test_Parse_Content_test_parse_content;
--  id:2.2/2dd6990d53d0b6dc/Parse_Content/1/0/test_parse_content/
   procedure Test_Parse_Content_test_parse_content (Gnattest_T : in out Test) is
      function Parse_Content (Tags : Templates_Parser.Translate_Set; Content : String) return String renames Wrap_Test_Parse_Content_2dd699_082dcd;
--  end read only

      pragma Unreferenced(Gnattest_T);
      My_Tags : Translate_Set;

   begin

      Insert (My_Tags, Assoc ("page.title", "Hello World"));
      Insert (My_Tags, Assoc ("page.author", "Ada"));

      --  Known tag is substituted
      AUnit.Assertions.Assert
        (Parse_Content (My_Tags, "{%page.title%}") = "Hello World",
         "Test_01: basic tag substitution failed");

      --  Surrounding text is preserved
      AUnit.Assertions.Assert
        (Parse_Content (My_Tags, "pre {%page.title%} post") =
           "pre Hello World post",
         "Test_02: surrounding text not preserved");

      --  Tag with spaces around name is trimmed and substituted
      AUnit.Assertions.Assert
        (Parse_Content (My_Tags, "{% page.title %}") = "Hello World",
         "Test_03: tag with surrounding spaces should be substituted");

      --  Multiple tags in a single string
      AUnit.Assertions.Assert
        (Parse_Content (My_Tags, "By {%page.author%}: {%page.title%}") =
           "By Ada: Hello World",
         "Test_04: multiple tags should all be substituted");

      --  Unknown tag is left unchanged
      AUnit.Assertions.Assert
        (Parse_Content (My_Tags, "{%unknown%}") = "{%unknown%}",
         "Test_05: unknown tag should be left unchanged");

      --  Content with no tags passes through unchanged
      AUnit.Assertions.Assert
        (Parse_Content (My_Tags, "no tags here") = "no tags here",
         "Test_06: content with no tags should pass through");

      --  Empty content returns empty string
      AUnit.Assertions.Assert
        (Parse_Content (My_Tags, "") = "",
         "Test_07: empty content should return empty string");

      --  Unmatched opening delimiter leaves remaining content unchanged
      AUnit.Assertions.Assert
        (Parse_Content (My_Tags, "hello {%page.title") = "hello {%page.title",
         "Test_08: unmatched opening tag should leave content unchanged");

--  begin read only
   end Test_Parse_Content_test_parse_content;
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
end Pages.Test_Data.Tests;
