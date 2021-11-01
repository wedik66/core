@cli
Feature: users cannot upload a file to a blacklisted name using new chunking
  As an administrator
  I want to be able to prevent users from uploading files to specified file names
  So that I can prevent unwanted file names existing in the cloud storage

  Background:
    Given using OCS API version "1"
    And using new DAV path
    And user "Alice" has been created with default attributes and without skeleton files


  Scenario: Upload a file to a banned filename using new chunking
    When the administrator updates system config key "blacklisted_files" with value '["blacklisted-file.txt",".htaccess"]' and type "json" using the occ command
    And user "Alice" creates a new chunking upload with id "chunking-42" using the WebDAV API
    And user "Alice" uploads new chunk file "1" with "AAAAA" to id "chunking-42" using the WebDAV API
    And user "Alice" uploads new chunk file "2" with "BBBBB" to id "chunking-42" using the WebDAV API
    And user "Alice" uploads new chunk file "3" with "CCCCC" to id "chunking-42" using the WebDAV API
    And user "Alice" moves new chunk file with id "chunking-42" to "blacklisted-file.txt" using the WebDAV API
    Then the HTTP status code should be "403"
    And as "Alice" file "blacklisted-file.txt" should not exist
