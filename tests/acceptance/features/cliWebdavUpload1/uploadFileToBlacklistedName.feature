@cli
Feature: users cannot upload a file to a blacklisted name
  As an administrator
  I want to be able to prevent users from uploading files to specified file names
  So that I can prevent unwanted file names existing in the cloud storage

  Background:
    Given using OCS API version "1"
    And user "Alice" has been created with default attributes and without skeleton files

  @issue-ocis-reva-54
  Scenario Outline: upload a file to a banned filename
    Given using <dav_version> DAV path
    When the administrator updates system config key "blacklisted_files" with value '["blacklisted-file.txt",".htaccess"]' and type "json" using the occ command
    And user "Alice" uploads file with content "uploaded content" to "blacklisted-file.txt" using the WebDAV API
    Then the HTTP status code should be "403"
    And as "Alice" file "blacklisted-file.txt" should not exist
    Examples:
      | dav_version |
      | old         |
      | new         |
