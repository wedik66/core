@api @issue-ocis-reva-56 @notToImplementOnOCIS @newChunking @issue-ocis-1321
Feature: users cannot upload a file to or into an excluded directory using new chunking
  As an administrator
  I want to be able to exclude directories (folders) from being processed. Any attempt to upload a file to one of those names should be refused.
  So that I can have directories on my cloud server storage that are not available for syncing.

  Background:
    Given using OCS API version "1"
    And using new DAV path
    And user "Alice" has been created with default attributes and without skeleton files

  @skipOnOcV10.3
  Scenario Outline: upload a file to a filename that matches excluded_directories_regex using new chunking
    # Note: we have to write JSON for the value, and to get a backslash in the double-quotes we have to escape it
    # The actual regular expressions end up being endswith\.bad$ and ^\.git
    Given the administrator has updated system config key "excluded_directories_regex" with value '["endswith\\.bad$","^\\.git","containsvirusinthename"]' and type "json"
    When user "Alice" creates a new chunking upload with id "chunking-42" using the WebDAV API
    And user "Alice" uploads new chunk file "1" with "AAAAA" to id "chunking-42" using the WebDAV API
    And user "Alice" uploads new chunk file "2" with "BBBBB" to id "chunking-42" using the WebDAV API
    And user "Alice" uploads new chunk file "3" with "CCCCC" to id "chunking-42" using the WebDAV API
    And user "Alice" moves new chunk file with id "chunking-42" to "<filename>" using the WebDAV API
    Then the HTTP status code should be "403"
    And as "Alice" file "<filename>" should not exist
    Examples:
      | filename                        |
      | thisendswith.bad                |
      | .github                         |
      | this-containsvirusinthename.txt |

  @skipOnOcV10.3
  Scenario: upload a file to a filename that does not match excluded_directories_regex using new chunking
    # Note: we have to write JSON for the value, and to get a backslash in the double-quotes we have to escape it
    # The actual regular expressions end up being endswith\.bad$ and ^\.git
    Given the administrator has updated system config key "excluded_directories_regex" with value '["endswith\\.bad$","^\\.git","containsvirusinthename"]' and type "json"
    When user "Alice" creates a new chunking upload with id "chunking-42" using the WebDAV API
    And user "Alice" uploads new chunk file "1" with "AAAAA" to id "chunking-42" using the WebDAV API
    And user "Alice" uploads new chunk file "2" with "BBBBB" to id "chunking-42" using the WebDAV API
    And user "Alice" uploads new chunk file "3" with "CCCCC" to id "chunking-42" using the WebDAV API
    And user "Alice" moves new chunk file with id "chunking-42" to "not-contains-virus-in-the-name.txt" using the WebDAV API
    Then the HTTP status code should be "201"
    And as "Alice" file "not-contains-virus-in-the-name.txt" should exist
