@cli
Feature: users cannot move (rename) a file to a blacklisted name
  As an administrator
  I want to be able to prevent users from moving (renaming) files to specified file names
  So that I can prevent unwanted file names existing in the cloud storage

  Background:
    Given user "Alice" has been created with default attributes and without skeleton files


  Scenario: rename a file to a banned filename
    Given using new DAV path
    And user "Alice" has uploaded file with content "ownCloud test text file 0" to "textfile0.txt"
    And the administrator has enabled async operations
    When the administrator updates system config key "blacklisted_files" with value '["blacklisted-file.txt",".htaccess"]' and type "json" using the occ command
    And user "Alice" moves file "/textfile0.txt" asynchronously to "/blacklisted-file.txt" using the WebDAV API
    Then the HTTP status code should be "403"
    And user "Alice" should see the following elements
      | /textfile0.txt |


  Scenario Outline: Rename a folder to a banned name
    Given using OCS API version "1"
    And using <dav_version> DAV path
    And user "Alice" has created folder "/testshare"
    When the administrator updates system config key "blacklisted_files" with value '["blacklisted-file.txt",".htaccess"]' and type "json" using the occ command
    And user "Alice" moves folder "/testshare" to "/blacklisted-file.txt" using the WebDAV API
    Then the HTTP status code should be "403"
    And user "Alice" should see the following elements
      | /testshare/ |
    Examples:
      | dav_version |
      | old         |
      | new         |
