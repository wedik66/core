@cli
Feature: add and delete app configs using occ command

  As an administrator
  I want to be able to add and delete app configs via the command line
  So that I can configure apps via the command line, rather than having to use the webUI

  Scenario: admin adds and deletes a config for an app using the occ command
    When the administrator adds config key "con" with value "conkey" in app "core" using the occ command
    Then the command should have been successful
    And the command output should contain the text 'Config value con for app core set to conkey'
    And the config key "con" of app "core" should have value "conkey"
    When the administrator deletes config key "con" of app "core" using the occ command
    Then the command should have been successful
    And the command output should contain the text 'Config value con of app core deleted'
    And app "core" should not have config key "con"

  Scenario: admin adds and deletes a system config
    When the administrator adds system config key "con" with value "conkey" using the occ command
    Then the command should have been successful
    And the command output should contain the text 'System config value con set to string conkey'
    And system config key "con" should have value "conkey"
    When the administrator deletes system config key "con" using the occ command
    Then the command should have been successful
    And the command output should contain the text 'System config value con deleted'
    And system config key "con" should not exist

  Scenario: admin adds a config key for an app with an empty value using the occ command
    When the administrator adds config key "con" with value "''" in app "core" using the occ command
    Then the command should have been successful
    And the command output should contain the text 'Config value con for app core set to'
    And the config key "con" of app "core" should have value ""

  Scenario: admin adds a system config with an empty value
    When the administrator adds system config key "con" with value "" using the occ command
    Then the command should have been successful
    And the command output should contain the text 'System config value con set to empty string'
    And system config key "con" should have value ""

  @skipOnOcV10.6 @skipOnOcV10.7 @skipOnOcV10.8.0
  Scenario: admin tries to add an empty config key for an app using the occ command
    When the administrator adds config key "''" with value "conkey" in app "core" using the occ command
    Then the command should have failed with exit code 1
    And the command output should contain the text 'Config name must not be empty.'

  @skipOnOcV10.6 @skipOnOcV10.7 @skipOnOcV10.8.0
  Scenario: admin tries to add a config key and specifying the empty string as the app name using the occ command
    When the administrator adds config key "con" with value "conkey" in app "''" using the occ command
    Then the command should have failed with exit code 1
    And the command output should contain the text 'App name must not be empty.'

  @skipOnOcV10.6 @skipOnOcV10.7 @skipOnOcV10.8.0
  Scenario: admin tries to add an empty system config key using the occ command
    When the administrator adds system config key "''" with value "conkey" using the occ command
    Then the command should have failed with exit code 1
    And the command output should contain the text 'Config name must not be empty.'

  Scenario: admin can list system config keys
    When the administrator lists the config keys
    Then the command should have been successful
    And the command output should contain the system configs

  Scenario: admin can list app config keys
    When the administrator lists the config keys
    Then the command should have been successful
    And the command output should contain the apps configs

  Scenario: app directory should be listed in the config file
    When the administrator lists the config keys
    Then the command should have been successful
    And the system config key "apps_paths" from the last command output should match value '/\"url\":\"\/apps\",\"writable\":false/' of type "json"

  Scenario: app-external directory should be listed in the config
    When the administrator lists the config keys
    Then the command should have been successful
    And the system config key "apps_paths" from the last command output should match value '/\"url\":\"\/apps-external\",\"writable\":true/' of type "json"

  Scenario: log time zone should be listed in the config file
    When the administrator lists the config keys
    Then the command should have been successful
    And the system config key "logtimezone" from the last command output should match value "UTC" of type "string"

  Scenario: server installed should be listed in the config file
    When the administrator lists the config keys
    Then the command should have been successful
    And the system config key "installed" from the last command output should match value "true" of type "boolean"


  Scenario: Check that search_min_length can be changed
    Given using OCS API version "1"
    When the administrator updates system config key "user.search_min_length" with value "4" using the occ command
    Then the capabilities setting of "files_sharing" path "search_min_length" should be "4"


  Scenario: set maximum size of previews
    Given user "Alice" has been created with default attributes and without skeleton files
    And user "Alice" has uploaded file "filesForUpload/lorem.txt" to "/parent.txt"
    When the administrator updates system config key "preview_max_x" with value "null" using the occ command
    And the administrator updates system config key "preview_max_y" with value "null" using the occ command
    Then the HTTP status code should be "201"
    When user "Alice" downloads the preview of "/parent.txt" with width "null" and height "null" using the WebDAV API
    Then the HTTP status code should be "400"
    And the value of the item "/d:error/s:exception" in the response about user "Alice" should be "Sabre\DAV\Exception\BadRequest"
