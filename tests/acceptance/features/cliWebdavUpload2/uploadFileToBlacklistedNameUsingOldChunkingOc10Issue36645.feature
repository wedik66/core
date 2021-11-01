@cli
Feature: users cannot upload a file to a blacklisted name using old chunking
  As an administrator
  I want to be able to prevent users from uploading files to specified file names
  So that I can prevent unwanted file names existing in the cloud storage

  Background:
    Given using OCS API version "1"
    And using old DAV path
    And user "Alice" has been created with default attributes and without skeleton files

  @issue-36645
  Scenario: Upload a file to a banned filename using old chunking
    When the administrator updates system config key "blacklisted_files" with value '["blacklisted-file.txt",".htaccess"]' and type "json" using the occ command
    And user "Alice" uploads file "filesForUpload/textfile.txt" to "blacklisted-file.txt" in 3 chunks using the WebDAV API
    Then the HTTP status code should be "507"
#    Then the HTTP status code should be "403"
    And as "Alice" file "blacklisted-file.txt" should not exist
