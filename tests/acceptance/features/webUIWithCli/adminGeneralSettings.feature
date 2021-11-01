@webUI @insulated @disablePreviews @mailhog @admin_settings-feature-required
Feature: admin general settings
  As an admin
  I want to be able to manage general settings on the ownCloud server
  So that I can configure general settings on the ownCloud server

  Background:
    Given the administrator has changed their own email address to "admin@owncloud.com"
    And the administrator has browsed to the admin general settings page

  @smokeTest @skipOnDockerContainerTesting
  Scenario: administrator sets update channel
    Given the administrator has invoked occ command "config:app:set core OC_Channel --value git"
    When the user reloads the current page of the webUI
    And the administrator sets the value of update channel to "daily" using the webUI
    Then the update channel should be "daily"

  @smokeTest @skipOnFIREFOX @skipOnDockerContainerTesting
  Scenario: administrator changes the cron job
    Given the administrator has invoked occ command "config:app:set core backgroundjobs_mode --value ajax"
    When the user reloads the current page of the webUI
    And the administrator sets the value of cron job to "webcron" using the webUI
    Then the background jobs mode should be "webcron"

  @smokeTest @skipOnDockerContainerTesting
  Scenario: administrator changes the log level
    Given the administrator has invoked occ command "config:system:set loglevel --value 0"
    When the user reloads the current page of the webUI
    And the administrator sets the value of log level to 1 using the webUI
    Then the log level should be "1"
