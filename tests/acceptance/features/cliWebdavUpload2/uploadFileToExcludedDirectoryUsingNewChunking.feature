@cli
Feature: users cannot upload a file to or into an excluded directory using new chunking
  As an administrator
  I want to be able to exclude directories (folders) from being processed. Any attempt to upload a file to one of those names should be refused.
  So that I can have directories on my cloud server storage that are not available for syncing.

  Background:
    Given using OCS API version "1"
    And using new DAV path
    And user "Alice" has been created with default attributes and without skeleton files


  Scenario: Upload a file to an excluded directory name using new chunking
    When the administrator updates system config key "excluded_directories" with value '[".github"]' and type "json" using the occ command
    And user "Alice" creates a new chunking upload with id "chunking-42" using the WebDAV API
    And user "Alice" uploads new chunk file "1" with "AAAAA" to id "chunking-42" using the WebDAV API
    And user "Alice" uploads new chunk file "2" with "BBBBB" to id "chunking-42" using the WebDAV API
    And user "Alice" uploads new chunk file "3" with "CCCCC" to id "chunking-42" using the WebDAV API
    And user "Alice" moves new chunk file with id "chunking-42" to ".github" using the WebDAV API
    Then the HTTP status code should be "403"
    And as "Alice" file ".github" should not exist


  Scenario: Upload a file to an excluded directory name inside a parent directory using new chunking
    Given user "Alice" has created folder "FOLDER"
    When the administrator updates system config key "excluded_directories" with value '[".github"]' and type "json" using the occ command
    And user "Alice" creates a new chunking upload with id "chunking-42" using the WebDAV API
    And user "Alice" uploads new chunk file "1" with "AAAAA" to id "chunking-42" using the WebDAV API
    And user "Alice" uploads new chunk file "2" with "BBBBB" to id "chunking-42" using the WebDAV API
    And user "Alice" uploads new chunk file "3" with "CCCCC" to id "chunking-42" using the WebDAV API
    And user "Alice" moves new chunk file with id "chunking-42" to "/FOLDER/.github" using the WebDAV API
    Then the HTTP status code should be "403"
    And as "Alice" folder "/FOLDER" should exist
    But as "Alice" file "/FOLDER/.github" should not exist
