@cli
Feature: users cannot move (rename) a file to or into an excluded directory
  As an administrator
  I want to be able to exclude directories (folders) from being processed. Any attempt to rename an existing file or folder to one of those names should be refused.
  So that I can have directories on my cloud server storage that are not available for syncing.

  Background:
    Given using new DAV path
    And user "Alice" has been created with default attributes and without skeleton files
    And user "Alice" has uploaded file with content "ownCloud test text file 0" to "textfile0.txt"
    And the administrator has enabled async operations


  Scenario: rename a file to an excluded directory name
    When the administrator updates system config key "excluded_directories" with value '[".github"]' and type "json" using the occ command
    And user "Alice" moves file "/textfile0.txt" asynchronously to "/.github" using the WebDAV API
    Then the HTTP status code should be "403"
    And user "Alice" should see the following elements
      | /textfile0.txt |


  Scenario: rename a file to an excluded directory name inside a parent directory
    Given user "Alice" has created folder "FOLDER"
    When the administrator updates system config key "excluded_directories" with value '[".github"]' and type "json" using the occ command
    And user "Alice" moves file "/textfile0.txt" asynchronously to "/FOLDER/.github" using the WebDAV API
    Then the HTTP status code should be "403"
    And user "Alice" should see the following elements
      | /textfile0.txt |
