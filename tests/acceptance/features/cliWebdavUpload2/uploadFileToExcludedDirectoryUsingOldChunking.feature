@cli
Feature: users cannot upload a file to or into an excluded directory using old chunking
  As an administrator
  I want to be able to exclude directories (folders) from being processed. Any attempt to upload a file to one of those names should be refused.
  So that I can have directories on my cloud server storage that are not available for syncing.

  Background:
    Given using OCS API version "1"
    And using old DAV path
    And user "Alice" has been created with default attributes and without skeleton files

  @skipOnOcV10 @issue-36645
  Scenario: Upload a file to an excluded directory name using old chunking
    When the administrator updates system config key "excluded_directories" with value '[".github"]' and type "json" using the occ command
    And user "Alice" uploads file "filesForUpload/textfile.txt" to "/.github" in 3 chunks using the WebDAV API
    Then the HTTP status code should be "403"
    And as "Alice" file ".github" should not exist

  @skipOnOcV10 @issue-36645
  Scenario: Upload a file to an excluded directory name inside a parent directory using old chunking
    Given user "Alice" has created folder "FOLDER"
    When the administrator updates system config key "excluded_directories" with value '[".github"]' and type "json" using the occ command
    And user "Alice" uploads file "filesForUpload/textfile.txt" to "/FOLDER/.github" in 3 chunks using the WebDAV API
    Then the HTTP status code should be "403"
    And as "Alice" folder "/FOLDER" should exist
    But as "Alice" file "/FOLDER/.github" should not exist
