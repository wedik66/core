dir = {
    "base": "/drone",
    "server": "/drone/src",
    "federated": "/drone/federated",
}

config = {
    "rocketchat": {
        "channel": "server",
        "from_secret": "public_rocketchat",
    },
    "branches": [
        "master",
    ],
    "dependencies": True,
    "codestyle": True,
    "phpstan": True,
    "phan": True,
    "javascript": True,
    "litmus": True,
    "dav": True,
    "phpunit": {
        "mostDatabases": {
            "phpVersions": [
                "7.3",
            ],
            # Gather coverage for all databases except Oracle
            "coverage": True,
            "databases": [
                "sqlite",
                "mariadb:10.2",
                "mariadb:10.3",
                "mariadb:10.4",
                "mariadb:10.5",
                "mariadb:10.6",
                "mysql:5.5",
                "mysql:5.7",
                "mysql:8.0",
                "postgres:9.4",
                "postgres:10.3",
            ],
        },
        "slowDatabases": {
            "phpVersions": [
                "7.3",
            ],
            # Oracle takes a long time to start and run
            # So do not collect coverage for that
            # This helps the SonarCloud analysis to be ready much more quickly
            "coverage": False,
            "databases": [
                "oracle",
            ],
        },
        "reducedDatabases": {
            "phpVersions": [
                "7.4",
            ],
            "databases": [
                "sqlite",
                "mariadb:10.2",
            ],
        },
        "external-samba-windows": {
            "phpVersions": [
                "7.3",
                "7.4",
            ],
            "databases": [
                "sqlite",
            ],
            "externalTypes": [
                "samba",
                "windows",
            ],
            "coverage": True,
            "extraCommandsBeforeTestRun": [
                "ls -l /var/cache",
                "mkdir /var/cache/samba",
                "ls -l /var/cache",
                "ls -l /var/cache/samba",
            ],
        },
        "external-other": {
            "phpVersions": [
                "7.3",
                "7.4",
            ],
            "databases": [
                "sqlite",
            ],
            "externalTypes": [
                "webdav",
                "sftp",
                "scality",
                "owncloud",
            ],
            "coverage": True,
        },
    },
    "acceptance": {
        "api": {
            "suites": [
                "apiAuth",
                "apiAuthOcs",
                "apiAuthWebDav",
                "apiCapabilities",
                "apiComments",
                "apiFavorites",
                "apiMain",
                "apiProvisioning-v1",
                "apiProvisioning-v2",
                "apiProvisioningGroups-v1",
                "apiProvisioningGroups-v2",
                "apiShareCreateSpecialToRoot1",
                "apiShareCreateSpecialToShares1",
                "apiShareCreateSpecialToRoot2",
                "apiShareCreateSpecialToShares2",
                "apiSharees",
                "apiShareManagementToRoot",
                "apiShareManagementToShares",
                "apiShareManagementBasicToRoot",
                "apiShareManagementBasicToShares",
                "apiShareOperationsToRoot1",
                "apiShareOperationsToRoot2",
                "apiShareOperationsToShares1",
                "apiShareOperationsToShares2",
                "apiSharePublicLink1",
                "apiSharePublicLink2",
                "apiShareReshareToRoot1",
                "apiShareReshareToShares1",
                "apiShareReshareToRoot2",
                "apiShareReshareToShares2",
                "apiShareReshareToRoot3",
                "apiShareReshareToShares3",
                "apiShareUpdateToRoot",
                "apiShareUpdateToShares",
                "apiTags",
                "apiTranslation",
                "apiTrashbin",
                "apiTrashbinRestore",
                "apiVersions",
                "apiWebdavEtagPropagation1",
                "apiWebdavEtagPropagation2",
                "apiWebdavLocks",
                "apiWebdavLocks2",
                "apiWebdavLocks3",
                "apiWebdavLocksUnlock",
                "apiWebdavMove1",
                "apiWebdavMove2",
                "apiWebdavOperations",
                "apiWebdavPreviews",
                "apiWebdavProperties1",
                "apiWebdavProperties2",
                "apiWebdavUpload1",
                "apiWebdavUpload2",
            ],
        },
        "apiNotifications": {
            "suites": [
                "apiSharingNotificationsToRoot",
                "apiSharingNotificationsToShares",
            ],
            "extraApps": {
                "notifications": 'if [ -f "composer.json" ]; then composer install; fi',
            },
        },
        "apiFederation": {
            "suites": [
                "apiFederationToRoot1",
                "apiFederationToRoot2",
                "apiFederationToShares1",
                "apiFederationToShares2",
            ],
            "federatedServerNeeded": True,
            "federatedServerVersions": ["git", "latest", "10.7.0"],
        },
        "cli": {
            "suites": [
                "cliBackground",
                "cliLocalStorage",
                "cliMain",
                "cliProvisioning",
                "cliTrashbin",
            ],
            "emailNeeded": True,
        },
        "cliAppManagement": {
            "suites": [
                "cliAppManagement",
            ],
            "testingRemoteSystem": False,
        },
        "cliEncryption": {
            "suites": [
                "cliEncryption",
            ],
            "extraApps": {
                "encryption": "composer install",
            },
            "testingRemoteSystem": False,
            "extraSetup": [{
                "name": "configure-encryption",
                "image": "owncloudci/php:7.4",
                "pull": "always",
                "commands": [
                    "php occ maintenance:singleuser --on",
                    "php occ encryption:enable",
                    "php occ encryption:select-encryption-type masterkey --yes",
                    "php occ encryption:encrypt-all --yes",
                    "php occ encryption:status",
                    "php occ maintenance:singleuser --off",
                ],
            }],
            "extraCommandsBeforeTestRun": [
                "mkdir data/owncloud-keys",
                "chown -R www-data data/owncloud-keys",
                "chmod -R 0770 data/owncloud-keys",
            ],
        },
        "cliExternalStorage": {
            "suites": [
                "cliExternalStorage",
            ],
            "federatedServerNeeded": True,
            "federatedServerVersions": ["git", "latest", "10.7.0"],
        },
        "webUI": {
            "suites": {
                "webUIAddUsers": "",
                "webUIAdminSettings": "",
                "webUIComments": "",
                "webUICreateDelete": "",
                "webUIFavorites": "",
                "webUIFiles": "",
                "webUILogin": "",
                "webUIManageQuota": "",
                "webUIManageUsersGroups": "webUIManageUsersGrps",
                "webUIMoveFilesFolders": "webUIMoveFilesFolder",
                "webUIPersonalSettings": "webUIPersonalSetting",
                "webUIRenameFiles": "",
                "webUIRenameFolders": "",
                "webUIRestrictSharing": "",
                "webUISettingsMenu": "",
                "webUISharingAcceptShares": "webUISharingAcceptSh",
                "webUISharingAutocompletion1": "webUISharingAutocomp1",
                "webUISharingAutocompletion2": "webUISharingAutocomp2",
                "webUISharingInternalGroups1": "webUISharingIntGroup1",
                "webUISharingInternalGroups2": "webUISharingIntGroup2",
                "webUISharingInternalUsers1": "webUISharingIntUsers1",
                "webUISharingInternalUsers2": "webUISharingIntUsers2",
                "webUISharingPublic1": "",
                "webUISharingPublic2": "",
                "webUITags": "",
                "webUITrashbin": "",
                "webUIUpload": "",
                "webUIWebdavLockProtection": "webUIWebdavLockProt",
                "webUIWebdavLocks": "",
            },
            "emailNeeded": True,
            "useHttps": False,
            "selUserNeeded": True,
        },
        "webUINotifications": {
            "suites": {
                "webUISharingNotifications": "webUISharingNotify",
            },
            "emailNeeded": True,
            "useHttps": False,
            "extraApps": {
                "notifications": "composer install",
            },
        },
        "webUIFileActionsMenu": {
            "suites": {
                "webUIFileActionsMenu": "",
            },
            "useHttps": False,
            "extraApps": {
                "files_texteditor": "make vendor",
                "richdocuments": "make vendor",
            },
        },
        "webUIFederation": {
            "suites": {
                "webUISharingExternal1": "webUISharingExt1",
                "webUISharingExternal2": "webUISharingExt2",
            },
            "federatedServerNeeded": True,
            "federatedServerVersions": ["git", "latest", "10.7.0"],
        },
        "webUIFirefox": {
            "suites": {
                "webUIFirefoxSmoketest": "webUIFfSmoke",
            },
            "browsers": [
                "firefox",
            ],
            "emailNeeded": True,
            "useHttps": False,
            "filterTags": "@smokeTest&&~@notifications-app-required",
            "runAllSuites": True,
            "numberOfParts": 3,
        },
        "webUIProxy": {
            "suites": {
                "webUIProxySmoketest": "webUIProxySmoke",
            },
            "browsers": [
                "chrome",
            ],
            "emailNeeded": True,
            "proxyNeeded": True,
            "useHttps": False,
            "filterTags": "@smokeTest&&~@notifications-app-required",
            "runAllSuites": True,
            "numberOfParts": 3,
        },
        "webUIMobileSize": {
            "suites": {
                "webUIMobileSize": "",
            },
            "browsers": [
                "chrome",
            ],
            "emailNeeded": True,
            "useHttps": False,
            "filterTags": "@mobileResolutionTest&&~@notifications-app-required",
            "runAllSuites": True,
            "numberOfParts": 3,
            "extraEnvironment": {
                "MOBILE_RESOLUTION": "375x812",
                "OC_LANGUAGE": "en-EN",
            },
        },
        "apiProxy": {
            "suites": {
                "apiProxySmoketest": "apiProxySmoke",
            },
            "proxyNeeded": True,
            "useHttps": False,
            "filterTags": "@smokeTest&&~@notifications-app-required",
            "runAllSuites": True,
            "numberOfParts": 8,
        },
        "apiOnSqlite": {
            "suites": {
                "apiOnSqlite": "apiOnSqlite",
            },
            "databases": ["sqlite"],
            "useHttps": False,
            "filterTags": "@sqliteDB",
            "runAllSuites": True,
        },
    },
}

def main(ctx):
    initial = initialPipelines(ctx)

    before = beforePipelines(ctx)
    dependsOn(initial, before)

    coverageTests = coveragePipelines(ctx)
    if (coverageTests == False):
        print("Errors detected in coveragePipelines. Review messages above.")
        return []

    dependsOn(before, coverageTests)

    nonCoverageTests = nonCoveragePipelines(ctx)
    if (nonCoverageTests == False):
        print("Errors detected in nonCoveragePipelines. Review messages above.")
        return []

    dependsOn(before, nonCoverageTests)

    stages = stagePipelines(ctx)
    if (stages == False):
        print("Errors detected in stagePipelines. Review messages above.")
        return []

    dependsOn(before, stages)

    if (coverageTests == []):
        afterCoverageTests = []
    else:
        afterCoverageTests = afterCoveragePipelines(ctx)
        dependsOn(coverageTests, afterCoverageTests)

    after = afterPipelines(ctx)
    dependsOn(afterCoverageTests + nonCoverageTests + stages, after)

    return initial + before + coverageTests + afterCoverageTests + nonCoverageTests + stages + after

def initialPipelines(ctx):
    return dependencies(ctx) + checkStarlark()

def beforePipelines(ctx):
    return codestyle() + changelog(ctx) + checkForRecentBuilds(ctx) + phpstan() + phan()

def coveragePipelines(ctx):
    # All unit test pipelines that have coverage or other test analysis reported
    jsPipelines = javascript(ctx, True)
    phpUnitPipelines = phpTests(ctx, "phpunit", True)
    phpIntegrationPipelines = phpTests(ctx, "phpintegration", True)
    if (jsPipelines == False) or (phpUnitPipelines == False) or (phpIntegrationPipelines == False):
        return False

    return jsPipelines + phpUnitPipelines + phpIntegrationPipelines

def nonCoveragePipelines(ctx):
    # All unit test pipelines that do not have coverage or other test analysis reported
    jsPipelines = javascript(ctx, False)
    phpUnitPipelines = phpTests(ctx, "phpunit", False)
    phpIntegrationPipelines = phpTests(ctx, "phpintegration", False)
    if (jsPipelines == False) or (phpUnitPipelines == False) or (phpIntegrationPipelines == False):
        return False

    return jsPipelines + phpUnitPipelines + phpIntegrationPipelines

def stagePipelines(ctx):
    # Pipelines that do not produce coverage or other test analysis reports
    litmusPipelines = litmus()
    davPipelines = dav()
    acceptancePipelines = acceptance(ctx)
    if (litmusPipelines == False) or (davPipelines == False) or (acceptancePipelines == False):
        return False

    return litmusPipelines + davPipelines + acceptancePipelines

def afterCoveragePipelines(ctx):
    return [
        sonarAnalysis(ctx),
    ]

def afterPipelines(ctx):
    return [
        notify(),
    ]

def dependencies(ctx):
    pipelines = []

    if "dependencies" not in config:
        return pipelines

    default = {
        "phpVersions": ["7.3"],
        "nodeJsVersion": "14",
    }

    if "defaults" in config:
        if "dependencies" in config["defaults"]:
            for item in config["defaults"]["dependencies"]:
                default[item] = config["defaults"]["dependencies"][item]

    dependenciesConfig = config["dependencies"]

    if type(dependenciesConfig) == "bool":
        if dependenciesConfig:
            # the config has 'dependencies' true, so specify an empty dict that will get the defaults
            dependenciesConfig = {}
        else:
            return pipelines

    if len(dependenciesConfig) == 0:
        # 'dependencies' is an empty dict, so specify a single section that will get the defaults
        dependenciesConfig = {"doDefault": {}}

    for category, matrix in dependenciesConfig.items():
        params = {}
        for item in default:
            params[item] = matrix[item] if item in matrix else default[item]

        for phpVersion in params["phpVersions"]:
            name = "install-dependencies-php%s" % phpVersion

            result = {
                "kind": "pipeline",
                "type": "docker",
                "name": name,
                "workspace": {
                    "base": dir["base"],
                    "path": "src",
                },
                "steps": cacheRestore() +
                         cacheClearOnEventPush(phpVersion) +
                         composerInstall(phpVersion) +
                         vendorbinCodestyle(phpVersion) +
                         vendorbinCodesniffer(phpVersion) +
                         vendorbinPhan(phpVersion) +
                         vendorbinPhpstan(phpVersion) +
                         vendorbinBehat() +
                         yarnInstall(params["nodeJsVersion"]) +
                         cacheRebuildOnEventPush() +
                         cacheFlushOnEventPush(),
                "depends_on": [],
                "trigger": {
                    "ref": [
                        "refs/pull/**",
                        "refs/tags/**",
                    ],
                },
            }

            for branch in config["branches"]:
                result["trigger"]["ref"].append("refs/heads/%s" % branch)

            pipelines.append(result)

    return pipelines

def codestyle():
    pipelines = []

    if "codestyle" not in config:
        return pipelines

    default = {
        "phpVersions": ["7.4"],
    }

    if "defaults" in config:
        if "codestyle" in config["defaults"]:
            for item in config["defaults"]["codestyle"]:
                default[item] = config["defaults"]["codestyle"][item]

    codestyleConfig = config["codestyle"]

    if type(codestyleConfig) == "bool":
        if codestyleConfig:
            # the config has 'codestyle' true, so specify an empty dict that will get the defaults
            codestyleConfig = {}
        else:
            return pipelines

    if len(codestyleConfig) == 0:
        # 'codestyle' is an empty dict, so specify a single section that will get the defaults
        codestyleConfig = {"doDefault": {}}

    for category, matrix in codestyleConfig.items():
        params = {}
        for item in default:
            params[item] = matrix[item] if item in matrix else default[item]

        for phpVersion in params["phpVersions"]:
            name = "coding-standard-php%s" % phpVersion

            result = {
                "kind": "pipeline",
                "type": "docker",
                "name": name,
                "workspace": {
                    "base": dir["base"],
                    "path": "src",
                },
                "steps": cacheRestore() +
                         composerInstall(phpVersion) +
                         vendorbinCodestyle(phpVersion) +
                         vendorbinCodesniffer(phpVersion) +
                         [
                             {
                                 "name": "php-style",
                                 "image": "owncloudci/php:%s" % phpVersion,
                                 "pull": "always",
                                 "commands": [
                                     "make test-php-style",
                                 ],
                             },
                         ],
                "depends_on": [],
                "trigger": {
                    "ref": [
                        "refs/pull/**",
                        "refs/tags/**",
                    ],
                },
            }

            for branch in config["branches"]:
                result["trigger"]["ref"].append("refs/heads/%s" % branch)

            pipelines.append(result)

    return pipelines

def changelog(ctx):
    repo_slug = ctx.build.source_repo if ctx.build.source_repo else ctx.repo.slug
    pipelines = []

    result = {
        "kind": "pipeline",
        "type": "docker",
        "name": "changelog",
        "clone": {
            "disable": True,
        },
        "steps": [
            {
                "name": "clone",
                "image": "plugins/git-action:1",
                "pull": "always",
                "settings": {
                    "actions": [
                        "clone",
                    ],
                    "remote": "https://github.com/%s" % (repo_slug),
                    "branch": ctx.build.source if ctx.build.event == "pull_request" else "master",
                    "path": dir["server"],
                    "netrc_machine": "github.com",
                    "netrc_username": {
                        "from_secret": "github_username",
                    },
                    "netrc_password": {
                        "from_secret": "github_token",
                    },
                },
            },
            {
                "name": "generate",
                "image": "toolhippie/calens:latest",
                "pull": "always",
                "commands": [
                    "calens >| CHANGELOG.md",
                    "calens -t changelog/CHANGELOG-html.tmpl >| CHANGELOG.html",
                ],
            },
            {
                "name": "diff",
                "image": "owncloudci/alpine:latest",
                "pull": "always",
                "commands": [
                    "git diff",
                ],
            },
            {
                "name": "output",
                "image": "toolhippie/calens:latest",
                "pull": "always",
                "commands": [
                    "cat CHANGELOG.md",
                ],
            },
            {
                "name": "publish",
                "image": "plugins/git-action:1",
                "pull": "always",
                "settings": {
                    "actions": [
                        "commit",
                        "push",
                    ],
                    "message": "Automated changelog update [skip ci]",
                    "branch": "master",
                    "author_email": "devops@owncloud.com",
                    "author_name": "ownClouders",
                    "netrc_machine": "github.com",
                    "netrc_username": {
                        "from_secret": "github_username",
                    },
                    "netrc_password": {
                        "from_secret": "github_token",
                    },
                },
                "when": {
                    "ref": {
                        "exclude": [
                            "refs/pull/**",
                        ],
                    },
                },
            },
        ],
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/heads/master",
                "refs/pull/**",
            ],
        },
    }

    pipelines.append(result)

    return pipelines

def checkForRecentBuilds(ctx):
    pipelines = []

    result = {
        "kind": "pipeline",
        "type": "docker",
        "name": "stop-recent-builds",
        "workspace": {
            "base": dir["base"],
            "path": "src",
        },
        "steps": stopRecentBuilds(ctx),
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/heads/master",
                "refs/tags/**",
                "refs/pull/**",
            ],
        },
    }

    pipelines.append(result)

    return pipelines

def stopRecentBuilds(ctx):
    return [{
        "name": "stop-recent-builds",
        "image": "drone/cli:alpine",
        "pull": "always",
        "environment": {
            "DRONE_SERVER": "https://drone.owncloud.com",
            "DRONE_TOKEN": {
                "from_secret": "drone_token",
            },
        },
        "commands": [
            "drone build ls %s --status running > %s/recentBuilds.txt" % (ctx.repo.slug, dir["server"]),
            "drone build info %s ${DRONE_BUILD_NUMBER} > %s/thisBuildInfo.txt" % (ctx.repo.slug, dir["server"]),
            "cd %s && ./tests/acceptance/cancelBuilds.sh" % dir["server"],
        ],
        "when": {
            "event": [
                "pull_request",
            ],
        },
    }]

def phpstan():
    pipelines = []

    if "phpstan" not in config:
        return pipelines

    default = {
        "phpVersions": ["7.4"],
        "logLevel": "2",
    }

    if "defaults" in config:
        if "phpstan" in config["defaults"]:
            for item in config["defaults"]["phpstan"]:
                default[item] = config["defaults"]["phpstan"][item]

    phpstanConfig = config["phpstan"]

    if type(phpstanConfig) == "bool":
        if phpstanConfig:
            # the config has 'phpstan' true, so specify an empty dict that will get the defaults
            phpstanConfig = {}
        else:
            return pipelines

    if len(phpstanConfig) == 0:
        # 'phpstan' is an empty dict, so specify a single section that will get the defaults
        phpstanConfig = {"doDefault": {}}

    for category, matrix in phpstanConfig.items():
        params = {}
        for item in default:
            params[item] = matrix[item] if item in matrix else default[item]

        for phpVersion in params["phpVersions"]:
            name = "phpstan-php%s" % phpVersion

            result = {
                "kind": "pipeline",
                "type": "docker",
                "name": name,
                "workspace": {
                    "base": dir["base"],
                    "path": "src",
                },
                "steps": cacheRestore() +
                         composerInstall(phpVersion) +
                         vendorbinPhpstan(phpVersion) +
                         installServer(phpVersion, "sqlite", params["logLevel"]) +
                         [
                             {
                                 "name": "php-phpstan",
                                 "image": "owncloudci/php:%s" % phpVersion,
                                 "pull": "always",
                                 "commands": [
                                     "make test-php-phpstan",
                                 ],
                             },
                         ],
                "depends_on": [],
                "trigger": {
                    "ref": [
                        "refs/pull/**",
                        "refs/tags/**",
                    ],
                },
            }

            pipelines.append(result)

    return pipelines

def phan():
    pipelines = []

    if "phan" not in config:
        return pipelines

    default = {
        "phpVersions": ["7.3", "7.4"],
        "logLevel": "2",
    }

    if "defaults" in config:
        if "phan" in config["defaults"]:
            for item in config["defaults"]["phan"]:
                default[item] = config["defaults"]["phan"][item]

    phanConfig = config["phan"]

    if type(phanConfig) == "bool":
        if phanConfig:
            # the config has 'phan' true, so specify an empty dict that will get the defaults
            phanConfig = {}
        else:
            return pipelines

    if len(phanConfig) == 0:
        # 'phan' is an empty dict, so specify a single section that will get the defaults
        phanConfig = {"doDefault": {}}

    for category, matrix in phanConfig.items():
        params = {}
        for item in default:
            params[item] = matrix[item] if item in matrix else default[item]

        for phpVersion in params["phpVersions"]:
            name = "phan-php%s" % phpVersion

            result = {
                "kind": "pipeline",
                "type": "docker",
                "name": name,
                "workspace": {
                    "base": dir["base"],
                    "path": "src",
                },
                "steps": cacheRestore() +
                         composerInstall(phpVersion) +
                         vendorbinPhan(phpVersion) +
                         installServer(phpVersion, "sqlite", params["logLevel"]) +
                         [
                             {
                                 "name": "phan",
                                 "image": "owncloudci/php:%s" % phpVersion,
                                 "pull": "always",
                                 "commands": [
                                     "make test-php-phan",
                                 ],
                             },
                         ],
                "depends_on": [],
                "trigger": {
                    "ref": [
                        "refs/pull/**",
                        "refs/tags/**",
                    ],
                },
            }

            pipelines.append(result)

    return pipelines

def litmus():
    pipelines = []

    if "litmus" not in config:
        return pipelines

    default = {
        "phpVersions": ["7.3", "7.4"],
        "logLevel": "2",
        "useHttps": True,
    }

    if "defaults" in config:
        if "litmus" in config["defaults"]:
            for item in config["defaults"]["litmus"]:
                default[item] = config["defaults"]["litmus"][item]

    litmusConfig = config["litmus"]

    if type(litmusConfig) == "bool":
        if litmusConfig:
            # the config has 'litmus' true, so specify an empty dict that will get the defaults
            litmusConfig = {}
        else:
            return pipelines

    if len(litmusConfig) == 0:
        # 'litmus' is an empty dict, so specify a single section that will get the defaults
        litmusConfig = {"doDefault": {}}

    for category, matrix in litmusConfig.items():
        params = {}
        for item in default:
            params[item] = matrix[item] if item in matrix else default[item]

        for phpVersion in params["phpVersions"]:
            name = "litmus-php%s" % phpVersion
            db = "mariadb:10.2"
            image = "owncloud/litmus:latest"
            environment = {
                "LITMUS_PASSWORD": "admin",
                "LITMUS_USERNAME": "admin",
                "TESTS": "basic copymove props locks http",
            }
            litmusCommand = "/usr/local/bin/litmus-wrapper"

            result = {
                "kind": "pipeline",
                "type": "docker",
                "name": name,
                "workspace": {
                    "base": dir["base"],
                    "path": "src",
                },
                "steps": cacheRestore() +
                         composerInstall(phpVersion) +
                         installServer(phpVersion, db, params["logLevel"], params["useHttps"]) +
                         setupLocalStorage(phpVersion) +
                         fixPermissions(phpVersion, False) +
                         createShare(phpVersion) +
                         owncloudLog("server", "src") +
                         [
                             {
                                 "name": "old-endpoint",
                                 "image": image,
                                 "pull": "always",
                                 "environment": environment,
                                 "commands": [
                                     "source .env",
                                     'export LITMUS_URL="https://server/remote.php/webdav"',
                                     litmusCommand,
                                 ],
                             },
                             {
                                 "name": "new-endpoint",
                                 "image": image,
                                 "pull": "always",
                                 "environment": environment,
                                 "commands": [
                                     "source .env",
                                     'export LITMUS_URL="https://server/remote.php/dav/files/admin"',
                                     litmusCommand,
                                 ],
                             },
                             {
                                 "name": "new-mount",
                                 "image": image,
                                 "pull": "always",
                                 "environment": environment,
                                 "commands": [
                                     "source .env",
                                     'export LITMUS_URL="https://server/remote.php/dav/files/admin/local_storage/"',
                                     litmusCommand,
                                 ],
                             },
                             {
                                 "name": "old-mount",
                                 "image": image,
                                 "pull": "always",
                                 "environment": environment,
                                 "commands": [
                                     "source .env",
                                     'export LITMUS_URL="https://server/remote.php/webdav/local_storage/"',
                                     litmusCommand,
                                 ],
                             },
                             {
                                 "name": "new-shared",
                                 "image": image,
                                 "pull": "always",
                                 "environment": environment,
                                 "commands": [
                                     "source .env",
                                     'export LITMUS_URL="https://server/remote.php/dav/files/admin/new_folder/"',
                                     litmusCommand,
                                 ],
                             },
                             {
                                 "name": "old-shared",
                                 "image": image,
                                 "pull": "always",
                                 "environment": environment,
                                 "commands": [
                                     "source .env",
                                     'export LITMUS_URL="https://server/remote.php/webdav/new_folder/"',
                                     litmusCommand,
                                 ],
                             },
                             {
                                 "name": "public-share",
                                 "image": image,
                                 "pull": "always",
                                 "environment": {
                                     "LITMUS_PASSWORD": "admin",
                                     "LITMUS_USERNAME": "admin",
                                     "TESTS": "basic copymove http",
                                 },
                                 "commands": [
                                     "source .env",
                                     "export LITMUS_URL='https://server/remote.php/dav/public-files/'$PUBLIC_TOKEN",
                                     litmusCommand,
                                 ],
                             },
                         ],
                "services": databaseService(db) +
                            owncloudService(phpVersion, "server", dir["server"], params["useHttps"]),
                "depends_on": [],
                "trigger": {
                    "ref": [
                        "refs/pull/**",
                        "refs/tags/**",
                    ],
                },
            }

            pipelines.append(result)

    return pipelines

def dav():
    pipelines = []

    if "dav" not in config:
        return pipelines

    default = {
        "phpVersions": ["7.3", "7.4"],
        "logLevel": "2",
    }

    if "defaults" in config:
        if "dav" in config["defaults"]:
            for item in config["defaults"]["dav"]:
                default[item] = config["defaults"]["dav"][item]

    davConfig = config["dav"]

    if type(davConfig) == "bool":
        if davConfig:
            # the config has 'dav' true, so specify an empty dict that will get the defaults
            davConfig = {}
        else:
            return pipelines

    if len(davConfig) == 0:
        # 'dav' is an empty dict, so specify a single section that will get the defaults
        davConfig = {"doDefault": {}}

    for category, matrix in davConfig.items():
        params = {}
        for item in default:
            params[item] = matrix[item] if item in matrix else default[item]

        for phpVersion in params["phpVersions"]:
            for davType in ["caldav-new", "caldav-old", "carddav-new", "carddav-old"]:
                name = "%s-php%s" % (davType, phpVersion)
                db = "mariadb:10.2"

                if (davType == "caldav-new"):
                    scriptPath = "apps/dav/tests/ci/caldav"

                if (davType == "caldav-old"):
                    scriptPath = "apps/dav/tests/ci/caldav-old-endpoint"

                if (davType == "carddav-new"):
                    scriptPath = "apps/dav/tests/ci/carddav"

                if (davType == "carddav-old"):
                    scriptPath = "apps/dav/tests/ci/carddav-old-endpoint"

                result = {
                    "kind": "pipeline",
                    "type": "docker",
                    "name": name,
                    "workspace": {
                        "base": dir["base"],
                        "path": "src",
                    },
                    "steps": cacheRestore() +
                             composerInstall(phpVersion) +
                             installServer(phpVersion, db, params["logLevel"]) +
                             davInstall(phpVersion, scriptPath) +
                             fixPermissions(phpVersion, False) +
                             owncloudLog("server", "src") +
                             [
                                 {
                                     "name": "dav-test",
                                     "image": "owncloudci/php:%s" % phpVersion,
                                     "pull": "always",
                                     "commands": [
                                         "bash %s/script.sh" % scriptPath,
                                     ],
                                 },
                             ],
                    "services": databaseService(db),
                    "depends_on": [],
                    "trigger": {
                        "ref": [
                            "refs/pull/**",
                            "refs/tags/**",
                        ],
                    },
                }

                pipelines.append(result)

    return pipelines

def javascript(ctx, withCoverage):
    pipelines = []

    if "javascript" not in config:
        return pipelines

    default = {
        "nodeJsVersion": "14",
        "coverage": True,
        "logLevel": "2",
        "skip": False,
    }

    if "defaults" in config:
        if "javascript" in config["defaults"]:
            for item in config["defaults"]["javascript"]:
                default[item] = config["defaults"]["javascript"][item]

    matrix = config["javascript"]

    if type(matrix) == "bool":
        if matrix:
            # the config has 'javascript' true, so specify an empty dict that will get the defaults
            matrix = {}
        else:
            return pipelines

    params = {}
    for item in default:
        params[item] = matrix[item] if item in matrix else default[item]

    if params["skip"]:
        return pipelines

    # if we only want pipelines with coverage, and this pipeline does not do coverage, then do not include it
    if withCoverage and not params["coverage"]:
        return pipelines

    # if we only want pipelines without coverage, and this pipeline does coverage, then do not include it
    if not withCoverage and params["coverage"]:
        return pipelines

    result = {
        "kind": "pipeline",
        "type": "docker",
        "name": "test-javascript",
        "workspace": {
            "base": dir["base"],
            "path": "src",
        },
        "steps": cacheRestore() +
                 yarnInstall(params["nodeJsVersion"]) +
                 [
                     {
                         "name": "test-js",
                         "image": "owncloudci/nodejs:%s" % params["nodeJsVersion"],
                         "pull": "always",
                         "commands": [
                             "make test-js",
                         ],
                     },
                 ],
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/pull/**",
                "refs/tags/**",
            ],
        },
    }

    if params["coverage"]:
        result["steps"].append(
            {
                "name": "coverage-cache",
                "image": "plugins/s3",
                "pull": "always",
                "settings": {
                    "endpoint": {
                        "from_secret": "cache_s3_endpoint",
                    },
                    "bucket": "cache",
                    "source": "tests/output/coverage/lcov.info",
                    "target": "%s/%s/coverage" % (ctx.repo.slug, ctx.build.commit + "-${DRONE_BUILD_NUMBER}"),
                    "path_style": True,
                    "strip_prefix": "tests/output/coverage",
                    "access_key": {
                        "from_secret": "cache_s3_access_key",
                    },
                    "secret_key": {
                        "from_secret": "cache_s3_secret_key",
                    },
                },
            },
        )

    for branch in config["branches"]:
        result["trigger"]["ref"].append("refs/heads/%s" % branch)

    return [result]

def phpTests(ctx, testType, withCoverage):
    pipelines = []

    if testType not in config:
        return pipelines

    errorFound = False

    default = {
        "phpVersions": ["7.3", "7.4"],
        "databases": [
            "sqlite",
            "mariadb:10.2",
            "mariadb:10.3",
            "mariadb:10.4",
            "mariadb:10.5",
            "mariadb:10.6",
            "mysql:5.5",
            "mysql:5.7",
            "mysql:8.0",
            "postgres:9.4",
            "postgres:10.3",
            "oracle",
        ],
        "coverage": True,
        "includeKeyInMatrixName": False,
        "logLevel": "2",
        "cephS3": False,
        "scalityS3": False,
        "externalTypes": ["none"],
        "extraSetup": [],
        "extraServices": [],
        "extraEnvironment": {},
        "extraCommandsBeforeTestRun": [],
        "extraApps": {},
        "skip": False,
    }

    if "defaults" in config:
        if testType in config["defaults"]:
            for item in config["defaults"][testType]:
                default[item] = config["defaults"][testType][item]

    phpTestConfig = config[testType]

    if type(phpTestConfig) == "bool":
        if phpTestConfig:
            # the config has just True, so specify an empty dict that will get the defaults
            phpTestConfig = {}
        else:
            return pipelines

    if len(phpTestConfig) == 0:
        # the PHP test config is an empty dict, so specify a single section that will get the defaults
        phpTestConfig = {"doDefault": {}}

    for category, matrix in phpTestConfig.items():
        params = {}
        for item in default:
            params[item] = matrix[item] if item in matrix else default[item]

        if params["skip"]:
            continue

        # if we only want pipelines with coverage, and this pipeline does not do coverage, then do not include it
        if withCoverage and not params["coverage"]:
            continue

        # if we only want pipelines without coverage, and this pipeline does coverage, then do not include it
        if not withCoverage and params["coverage"]:
            continue

        for phpVersion in params["phpVersions"]:
            if testType == "phpunit":
                command = "su-exec www-data bash tests/drone/test-phpunit.sh"
            else:
                command = "unknown tbd"

            for db in params["databases"]:
                for externalType in params["externalTypes"]:
                    keyString = "-" + category if params["includeKeyInMatrixName"] else ""
                    filesExternalType = externalType if externalType != "none" else ""
                    externalNameString = "-" + externalType if externalType != "none" else ""
                    name = "%s%s-php%s-%s%s" % (testType, keyString, phpVersion, getShortDbNameAndVersion(db), externalNameString)
                    maxLength = 50
                    nameLength = len(name)
                    if nameLength > maxLength:
                        print("Error: generated phpunit stage name of length", nameLength, "is not supported. The maximum length is " + str(maxLength) + ".", name)
                        errorFound = True

                    if ((externalType == "scality") or (params["scalityS3"] != False)):
                        needScality = True
                        filesExternalType = ""
                        primaryObjectStore = "files_primary_s3"
                    else:
                        needScality = False
                        primaryObjectStore = ""

                    if (filesExternalType == ""):
                        # for the regular unit test runs, the clover coverage results are in a file named like:
                        # autotest-clover-sqlite.xml
                        coverageFileNameStart = "autotest"
                        extraCoverageRenameCommand = []
                        extraCoverage = False
                    else:
                        # for the files-external unit test runs, the clover coverage results are in 2 files named like:
                        # autotest-external-clover-sqlite.xml
                        # autotest-external-clover-sqlite-samba.xml
                        coverageFileNameStart = "autotest-external"
                        extraCoverageRenameCommand = [
                            "mv tests/output/coverage/%s-clover-%s-%s.xml tests/output/coverage/clover-%s-%s.xml" % (coverageFileNameStart, getDbName(db), externalType, name, externalType),
                        ]
                        extraCoverage = True

                    if ((externalType == "scality") or (params["cephS3"] != False) or (params["scalityS3"] != False)):
                        # If we need S3 storage, then install the 'files_primary_s3' app
                        extraAppsDict = {
                            "files_primary_s3": "composer install",
                        }
                    else:
                        extraAppsDict = {}

                    if (externalType == "owncloud"):
                        needRedis = True
                    else:
                        needRedis = False

                    for app, command in params["extraApps"].items():
                        extraAppsDict[app] = command

                    result = {
                        "kind": "pipeline",
                        "type": "docker",
                        "name": name,
                        "workspace": {
                            "base": dir["base"],
                            "path": "src",
                        },
                        "steps": cacheRestore() +
                                 composerInstall(phpVersion) +
                                 installServer(phpVersion, db, params["logLevel"]) +
                                 installExtraApps(phpVersion, extraAppsDict, dir["server"]) +
                                 setupScality(phpVersion, needScality) +
                                 params["extraSetup"] +
                                 fixPermissions(phpVersion, False) +
                                 owncloudLog("server", "src") +
                                 [
                                     {
                                         "name": "%s-tests" % testType,
                                         "image": "owncloudci/php:%s" % phpVersion,
                                         "pull": "always",
                                         "environment": {
                                             "COVERAGE": params["coverage"],
                                             "DB_TYPE": getDbName(db),
                                             "FILES_EXTERNAL_TYPE": filesExternalType,
                                             "PRIMARY_OBJECTSTORE": primaryObjectStore,
                                             "SCALITY": needScality,
                                         },
                                         "commands": params["extraCommandsBeforeTestRun"] + [
                                             command,
                                         ],
                                     },
                                 ],
                        "services": databaseService(db) +
                                    cephService(params["cephS3"]) +
                                    scalityService(needScality) +
                                    webdavService(externalType == "webdav") +
                                    sambaService(externalType == "samba") +
                                    sftpService(externalType == "sftp") +
                                    redisService(needRedis) +
                                    owncloudDockerService(externalType == "owncloud") +
                                    params["extraServices"],
                        "depends_on": [],
                        "trigger": {
                            "ref": [
                                "refs/pull/**",
                                "refs/tags/**",
                            ],
                        },
                    }

                    if params["coverage"] and not needScality:
                        result["steps"].append({
                            "name": "coverage-rename",
                            "image": "owncloudci/php:%s" % phpVersion,
                            "pull": "always",
                            "commands": [
                                "mv tests/output/coverage/%s-clover-%s.xml tests/output/coverage/clover-%s.xml" % (coverageFileNameStart, getDbName(db), name),
                            ] + extraCoverageRenameCommand,
                        })
                        result["steps"].append({
                            "name": "coverage-cache-1",
                            "image": "plugins/s3",
                            "pull": "always",
                            "settings": {
                                "endpoint": {
                                    "from_secret": "cache_s3_endpoint",
                                },
                                "bucket": "cache",
                                "source": "tests/output/coverage/clover-%s.xml" % (name),
                                "target": "%s/%s/coverage" % (ctx.repo.slug, ctx.build.commit + "-${DRONE_BUILD_NUMBER}"),
                                "path_style": True,
                                "strip_prefix": "tests/output/coverage",
                                "access_key": {
                                    "from_secret": "cache_s3_access_key",
                                },
                                "secret_key": {
                                    "from_secret": "cache_s3_secret_key",
                                },
                            },
                        })
                        if extraCoverage:
                            result["steps"].append({
                                "name": "coverage-cache-2",
                                "image": "plugins/s3",
                                "pull": "always",
                                "settings": {
                                    "endpoint": {
                                        "from_secret": "cache_s3_endpoint",
                                    },
                                    "bucket": "cache",
                                    "source": "tests/output/coverage/clover-%s-%s.xml" % (name, externalType),
                                    "target": "%s/%s/coverage" % (ctx.repo.slug, ctx.build.commit + "-${DRONE_BUILD_NUMBER}"),
                                    "path_style": True,
                                    "strip_prefix": "tests/output/coverage",
                                    "access_key": {
                                        "from_secret": "cache_s3_access_key",
                                    },
                                    "secret_key": {
                                        "from_secret": "cache_s3_secret_key",
                                    },
                                },
                            })

                    for branch in config["branches"]:
                        result["trigger"]["ref"].append("refs/heads/%s" % branch)

                    pipelines.append(result)

    if errorFound:
        return False

    return pipelines

def acceptance(ctx):
    pipelines = []

    if "acceptance" not in config:
        return pipelines

    if type(config["acceptance"]) == "bool":
        if not config["acceptance"]:
            return pipelines

    errorFound = False

    default = {
        "federatedServerVersions": [""],
        "browsers": ["chrome"],
        "phpVersions": ["7.4"],
        "nodeJsVersion": "14",
        "databases": ["mariadb:10.2"],
        "federatedPhpVersion": "7.4",
        "federatedServerNeeded": False,
        "federatedDb": "",
        "filterTags": "",
        "logLevel": "2",
        "emailNeeded": False,
        "ldapNeeded": False,
        "proxyNeeded": False,
        "cephS3": False,
        "scalityS3": False,
        "testingRemoteSystem": True,
        "useHttps": True,
        "replaceUsernames": False,
        "extraSetup": [],
        "extraServices": [],
        "extraEnvironment": {"OC_LANGUAGE": "en-EN"},
        "extraCommandsBeforeTestRun": [],
        "extraApps": {},
        "useBundledApp": False,
        "includeKeyInMatrixName": False,
        "runAllSuites": False,
        "numberOfParts": 1,
        "skip": False,
        "debugSuites": [],
        "skipExceptParts": [],
        "testAgainstCoreTarball": False,
        "coreTarball": "daily-master-qa",
        "earlyFail": True,
        "selUserNeeded": False,
    }

    if "defaults" in config:
        if "acceptance" in config["defaults"]:
            for item in config["defaults"]["acceptance"]:
                default[item] = config["defaults"]["acceptance"][item]

    for category, matrix in config["acceptance"].items():
        if type(matrix["suites"]) == "list":
            suites = {}
            for suite in matrix["suites"]:
                suites[suite] = suite
        else:
            suites = matrix["suites"]

        if "debugSuites" in matrix and len(matrix["debugSuites"]) != 0:
            if type(matrix["debugSuites"]) == "list":
                suites = {}
                for suite in matrix["debugSuites"]:
                    suites[suite] = suite
            else:
                suites = matrix["debugSuites"]

        for suite, alternateSuiteName in suites.items():
            isWebUI = suite.startswith("webUI")
            isAPI = suite.startswith("api")
            isCLI = suite.startswith("cli")

            if (alternateSuiteName == ""):
                alternateSuiteName = suite

            params = {}
            for item in default:
                params[item] = matrix[item] if item in matrix else default[item]

            if params["skip"]:
                continue

            if ("full-ci" in ctx.build.title.lower()):
                params["earlyFail"] = False

            if isAPI or isCLI:
                params["browsers"] = [""]

            needObjectStore = (params["cephS3"] != False) or (params["scalityS3"] != False)

            extraAppsDict = {}

            if not params["testAgainstCoreTarball"]:
                extraAppsDict["testing"] = "composer install"

            if (needObjectStore):
                # If we need S3 object storage, then install the 'files_primary_s3' app
                extraAppsDict["files_primary_s3"] = "composer install"

            for app, command in params["extraApps"].items():
                extraAppsDict[app] = command

            for federatedServerVersion in params["federatedServerVersions"]:
                for browser in params["browsers"]:
                    for phpVersion in params["phpVersions"]:
                        for db in params["databases"]:
                            for runPart in range(1, params["numberOfParts"] + 1):
                                debugPartsEnabled = (len(params["skipExceptParts"]) != 0)
                                if debugPartsEnabled and runPart not in params["skipExceptParts"]:
                                    continue

                                name = "unknown"
                                federatedDb = db if params["federatedDb"] == "" else params["federatedDb"]

                                federatedDbName = getDbName(federatedDb)

                                if federatedDbName not in ["mariadb", "mysql"]:
                                    # Do not try to run 2 sets of Oracle, Postgres etc databases
                                    # When testing with these, let the federated server use mariadb
                                    federatedDb = "mariadb:10.2"

                                if isWebUI or isAPI or isCLI:
                                    browserString = "" if browser == "" else "-" + browser
                                    keyString = "-" + category if params["includeKeyInMatrixName"] else ""
                                    partString = "" if params["numberOfParts"] == 1 else "-%d-%d" % (params["numberOfParts"], runPart)
                                    federatedServerVersionString = "-" + federatedServerVersion.replace("daily-", "").replace("-qa", "") if (federatedServerVersion != "") else ""
                                    name = "%s%s%s%s%s-%s-php%s" % (alternateSuiteName, keyString, partString, federatedServerVersionString, browserString, getShortDbNameAndVersion(db), phpVersion)
                                    maxLength = 50
                                    nameLength = len(name)
                                    if nameLength > maxLength:
                                        print("Error: generated stage name of length", nameLength, "is not supported. The maximum length is " + str(maxLength) + ".", name)
                                        errorFound = True

                                environment = {}
                                for env in params["extraEnvironment"]:
                                    environment[env] = params["extraEnvironment"][env]

                                if (params["useHttps"]):
                                    protocol = "https"
                                else:
                                    protocol = "http"

                                if (params["proxyNeeded"]):
                                    serverUnderTest = "proxy"
                                else:
                                    serverUnderTest = "server"

                                environment["TEST_SERVER_URL"] = "%s://%s" % (protocol, serverUnderTest)

                                environment["BEHAT_FILTER_TAGS"] = params["filterTags"]
                                environment["REPLACE_USERNAMES"] = params["replaceUsernames"]
                                environment["DOWNLOADS_DIRECTORY"] = "%s/downloads" % dir["server"]

                                if (params["runAllSuites"] == False):
                                    environment["BEHAT_SUITE"] = suite
                                else:
                                    environment["DIVIDE_INTO_NUM_PARTS"] = params["numberOfParts"]
                                    environment["RUN_PART"] = runPart

                                if isWebUI:
                                    environment["SELENIUM_HOST"] = "selenium"
                                    environment["SELENIUM_PORT"] = "4444"
                                    environment["BROWSER"] = browser
                                    environment["PLATFORM"] = "Linux"
                                    makeParameter = "test-acceptance-webui"

                                if isAPI:
                                    makeParameter = "test-acceptance-api"

                                if isCLI:
                                    makeParameter = "test-acceptance-cli"

                                if params["emailNeeded"]:
                                    environment["MAILHOG_HOST"] = "email"

                                if params["ldapNeeded"]:
                                    environment["TEST_WITH_LDAP"] = True

                                if params["testingRemoteSystem"]:
                                    environment["TESTING_REMOTE_SYSTEM"] = True
                                    suExecCommand = ""
                                else:
                                    environment["TESTING_REMOTE_SYSTEM"] = False

                                    # The test suite (may/will) run local commands, rather than calling the testing app to do them
                                    # Those commands need to be executed as www-data (which owns the files)
                                    suExecCommand = "su-exec www-data "

                                if params["testAgainstCoreTarball"]:
                                    pathOfServerUnderTest = "/drone/core"
                                else:
                                    pathOfServerUnderTest = dir["server"]

                                if (needObjectStore):
                                    environment["OC_TEST_ON_OBJECTSTORE"] = "1"
                                    if (params["cephS3"] != False):
                                        environment["S3_TYPE"] = "ceph"
                                    if (params["scalityS3"] != False):
                                        environment["S3_TYPE"] = "scality"

                                federationDbSuffix = "fed"

                                result = {
                                    "kind": "pipeline",
                                    "type": "docker",
                                    "name": name,
                                    "workspace": {
                                        "base": dir["base"],
                                        "path": "src",
                                    },
                                    "steps": cacheRestore() +
                                             composerInstall(phpVersion) +
                                             vendorbinBehat() +
                                             yarnInstall(params["nodeJsVersion"]) +
                                             ((
                                                 installCoreFromTarball(params["coreTarball"], db, params["logLevel"], params["useHttps"], params["federatedServerNeeded"], params["proxyNeeded"], pathOfServerUnderTest)
                                             ) if params["testAgainstCoreTarball"] else (
                                                 installServer(phpVersion, db, params["logLevel"], params["useHttps"], params["federatedServerNeeded"], params["proxyNeeded"])
                                             )) +
                                             (
                                                 installAndConfigureFederated(ctx, federatedServerVersion, params["federatedPhpVersion"], params["logLevel"], protocol, federatedDb, federationDbSuffix) +
                                                 owncloudLog("federated", "federated") if params["federatedServerNeeded"] else []
                                             ) +
                                             installExtraApps(phpVersion, extraAppsDict, pathOfServerUnderTest) +
                                             setupCeph(phpVersion, params["cephS3"]) +
                                             setupScality(phpVersion, params["scalityS3"]) +
                                             params["extraSetup"] +
                                             waitForServer(phpVersion, params["federatedServerNeeded"]) +
                                             waitForBrowserService(phpVersion, isWebUI) +
                                             fixPermissions(phpVersion, params["federatedServerNeeded"], params["selUserNeeded"], pathOfServerUnderTest) +
                                             owncloudLog("server", pathOfServerUnderTest) +
                                             [
                                                 ({
                                                     "name": "acceptance-tests",
                                                     "image": "owncloudci/php:8.0",
                                                     "pull": "always",
                                                     "environment": environment,
                                                     "commands": params["extraCommandsBeforeTestRun"] + [
                                                         "touch %s/saved-settings.sh" % dir["base"],
                                                         ". %s/saved-settings.sh" % dir["base"],
                                                         "%smake %s" % (suExecCommand, makeParameter),
                                                     ],
                                                     "volumes": [{
                                                         "name": "downloads",
                                                         "path": "%s/downloads" % dir["server"],
                                                     }],
                                                 }),
                                             ] + buildGithubCommentForBuildStopped(name, params["earlyFail"]) + githubComment(params["earlyFail"]) + stopBuild(params["earlyFail"]),
                                    "services": databaseService(db) +
                                                occUpgradeService(isCLI) +
                                                browserService(browser) +
                                                emailService(params["emailNeeded"]) +
                                                ldapService(params["ldapNeeded"]) +
                                                proxyService(params["proxyNeeded"]) +
                                                cephService(params["cephS3"]) +
                                                scalityService(params["scalityS3"]) +
                                                params["extraServices"] +
                                                owncloudService(phpVersion, "server", pathOfServerUnderTest, params["useHttps"]) +
                                                ((
                                                    owncloudService(params["federatedPhpVersion"], "federated", dir["federated"], params["useHttps"]) +
                                                    databaseServiceForFederation(federatedDb, federationDbSuffix)
                                                ) if params["federatedServerNeeded"] else []),
                                    "depends_on": [],
                                    "trigger": {
                                        "ref": [
                                            "refs/pull/**",
                                            "refs/tags/**",
                                        ],
                                    },
                                    "volumes": [{
                                        "name": "downloads",
                                        "temp": {},
                                    }],
                                }

                                pipelines.append(result)

    if errorFound:
        return False

    return pipelines

def sonarAnalysis(ctx, phpVersion = "7.4", nodeJsVersion = "14"):
    sonar_env = {
        "SONAR_TOKEN": {
            "from_secret": "sonar_token",
        },
        "SONAR_SCANNER_OPTS": "-Xdebug",
    }

    if ctx.build.event == "pull_request":
        sonar_env.update({
            "SONAR_PULL_REQUEST_BASE": "%s" % (ctx.build.target),
            "SONAR_PULL_REQUEST_BRANCH": "%s" % (ctx.build.source),
            "SONAR_PULL_REQUEST_KEY": "%s" % (ctx.build.ref.replace("refs/pull/", "").split("/")[0]),
        })

    repo_slug = ctx.build.source_repo if ctx.build.source_repo else ctx.repo.slug

    result = {
        "kind": "pipeline",
        "type": "docker",
        "name": "sonar-analysis",
        "workspace": {
            "base": dir["base"],
            "path": "src",
        },
        "clone": {
            "disable": True,  # Sonarcloud does not apply issues on already merged branch
        },
        "steps": [
                     {
                         "name": "clone",
                         "image": "owncloudci/alpine:latest",
                         "commands": [
                             "git clone https://github.com/%s.git ." % (repo_slug),
                             "git checkout $DRONE_COMMIT",
                         ],
                     },
                 ] +
                 cacheRestore() +
                 composerInstall(phpVersion) +
                 yarnInstall(nodeJsVersion) +
                 installServer(phpVersion, "sqlite") +
                 [
                     {
                         "name": "sync-from-cache",
                         "image": "minio/mc:RELEASE.2020-12-10T01-26-17Z",
                         "pull": "always",
                         "environment": {
                             "MC_HOST_cache": {
                                 "from_secret": "cache_s3_connection_url",
                             },
                         },
                         "commands": [
                             "mkdir -p results",
                             "mc mirror cache/cache/%s/%s/coverage results/" % (ctx.repo.slug, ctx.build.commit + "-${DRONE_BUILD_NUMBER}"),
                         ],
                     },
                     {
                         "name": "setup-before-sonarcloud",
                         "image": "owncloudci/php:%s" % phpVersion,
                         "pull": "always",
                         "commands": [
                             "pwd",
                             "ls -l",
                             "ls -l results",
                             "ls -l apps",
                             "ls -l config",
                             "cd apps",
                             "git clone https://github.com/owncloud/files_primary_s3.git",
                             "cd files_primary_s3",
                             "composer install",
                             "cd %s" % dir["server"],
                         ],
                     },
                     {
                         "name": "sonarcloud",
                         "image": "sonarsource/sonar-scanner-cli",
                         "pull": "always",
                         "environment": sonar_env,
                     },
                     {
                         "name": "purge-cache",
                         "image": "minio/mc:RELEASE.2020-12-10T01-26-17Z",
                         "environment": {
                             "MC_HOST_cache": {
                                 "from_secret": "cache_s3_connection_url",
                             },
                         },
                         "commands": [
                             "mc rm --recursive --force cache/cache/%s/%s" % (ctx.repo.slug, ctx.build.commit + "-${DRONE_BUILD_NUMBER}"),
                         ],
                     },
                 ],
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/heads/master",
                "refs/pull/**",
                "refs/tags/**",
            ],
        },
    }

    for branch in config["branches"]:
        result["trigger"]["ref"].append("refs/heads/%s" % branch)

    return result

def notify():
    result = {
        "kind": "pipeline",
        "type": "docker",
        "name": "chat-notifications",
        "clone": {
            "disable": True,
        },
        "steps": [
            {
                "name": "notify-rocketchat",
                "image": "plugins/slack:1",
                "pull": "always",
                "settings": {
                    "webhook": {
                        "from_secret": config["rocketchat"]["from_secret"],
                    },
                    "channel": config["rocketchat"]["channel"],
                },
            },
        ],
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/tags/**",
            ],
            "status": [
                "success",
                "failure",
            ],
        },
    }

    for branch in config["branches"]:
        result["trigger"]["ref"].append("refs/heads/%s" % branch)

    return result

def stopBuild(earlyFail):
    if (earlyFail):
        return [{
            "name": "stop-build",
            "image": "drone/cli:alpine",
            "pull": "always",
            "environment": {
                "DRONE_SERVER": "https://drone.owncloud.com",
                "DRONE_TOKEN": {
                    "from_secret": "drone_token",
                },
            },
            "commands": [
                "drone build stop owncloud/core ${DRONE_BUILD_NUMBER}",
            ],
            "when": {
                "status": [
                    "failure",
                ],
                "event": [
                    "pull_request",
                ],
            },
        }]

    else:
        return []

def buildGithubCommentForBuildStopped(alternateSuiteName, earlyFail):
    if (earlyFail):
        return [{
            "name": "build-github-comment-buildStop",
            "image": "owncloud/ubuntu:16.04",
            "pull": "always",
            "commands": [
                'echo ":boom: Acceptance tests pipeline <strong>%s</strong> failed. The build has been cancelled.\\n\\n${DRONE_BUILD_LINK}/${DRONE_JOB_NUMBER}${DRONE_STAGE_NUMBER}/1\\n" >> %s/comments.file' % (alternateSuiteName, dir["server"]),
            ],
            "when": {
                "status": [
                    "failure",
                ],
                "event": [
                    "pull_request",
                ],
            },
        }]

    else:
        return []

def githubComment(earlyFail):
    if (earlyFail):
        return [{
            "name": "github-comment",
            "image": "jmccann/drone-github-comment:1",
            "pull": "if-not-exists",
            "settings": {
                "message_file": "%s/comments.file" % dir["server"],
            },
            "environment": {
                "GITHUB_TOKEN": {
                    "from_secret": "github_token",
                },
            },
            "when": {
                "status": [
                    "failure",
                ],
                "event": [
                    "pull_request",
                ],
            },
        }]

    else:
        return []

def databaseService(db):
    dbName = getDbName(db)
    if (dbName == "mariadb") or (dbName == "mysql"):
        service = {
            "name": dbName,
            "image": db,
            "pull": "always",
            "environment": {
                "MYSQL_USER": getDbUsername(db),
                "MYSQL_PASSWORD": getDbPassword(db),
                "MYSQL_DATABASE": getDbDatabase(db),
                "MYSQL_ROOT_PASSWORD": getDbRootPassword(),
            },
        }
        if (db == "mysql:8.0"):
            service["command"] = ["--default-authentication-plugin=mysql_native_password"]
        return [service]

    if dbName == "postgres":
        return [{
            "name": dbName,
            "image": db,
            "pull": "always",
            "environment": {
                "POSTGRES_USER": getDbUsername(db),
                "POSTGRES_PASSWORD": getDbPassword(db),
                "POSTGRES_DB": getDbDatabase(db),
            },
        }]

    if dbName == "oracle":
        return [{
            "name": dbName,
            "image": "owncloudci/oracle-xe:latest",
            "pull": "always",
            "environment": {
                "ORACLE_USER": getDbUsername(db),
                "ORACLE_PASSWORD": getDbPassword(db),
                "ORACLE_DB": getDbDatabase(db),
                "ORACLE_DISABLE_ASYNCH_IO": "true",
            },
        }]

    return []

def browserService(browser):
    if browser == "chrome":
        return [{
            "name": "selenium",
            "image": "selenium/standalone-chrome-debug:3.141.59-oxygen",
            "pull": "always",
            "environment": {
                "JAVA_OPTS": "-Dselenium.LOGGER.level=WARNING",
            },
            "volumes": [{
                "name": "downloads",
                "path": "/home/seluser/Downloads",
            }],
        }]

    if browser == "firefox":
        return [{
            "name": "selenium",
            "image": "selenium/standalone-firefox-debug:3.8.1",
            "pull": "always",
            "environment": {
                "JAVA_OPTS": "-Dselenium.LOGGER.level=WARNING",
                "SE_OPTS": "-enablePassThrough false",
            },
            "volumes": [{
                "name": "downloads",
                "path": "/home/seluser/Downloads",
            }],
        }]

    return []

def waitForBrowserService(phpVersion, isWebUi):
    if isWebUi:
        return [{
            "name": "wait-for-selenium",
            "image": "owncloudci/php:%s" % phpVersion,
            "pull": "always",
            "commands": [
                "wait-for-it -t 600 selenium:4444",
            ],
        }]
    return []

def emailService(emailNeeded):
    if emailNeeded:
        return [{
            "name": "email",
            "image": "mailhog/mailhog",
            "pull": "always",
        }]

    return []

def ldapService(ldapNeeded):
    if ldapNeeded:
        return [{
            "name": "ldap",
            "image": "osixia/openldap",
            "pull": "always",
            "environment": {
                "LDAP_DOMAIN": "owncloud.com",
                "LDAP_ORGANISATION": "owncloud",
                "LDAP_ADMIN_PASSWORD": "admin",
                "LDAP_TLS_VERIFY_CLIENT": "never",
            },
        }]

    return []

def proxyService(proxyNeeded):
    if proxyNeeded:
        return [{
            "name": "proxy",
            "image": "pottava/proxy",
            "pull": "always",
            "environment": {
                "PROXY_URL": "http://server",
            },
        }]

    return []

def occUpgradeService(needed):
    if not needed:
        return []

    return [{
        "name": "occupgrade",
        "image": "owncloudci/php:7.4",
        "pull": "always",
        "command": [
            "php -S occupgrade:8123 tests/acceptance/occUpgrade.php",
        ],
    }]

def webdavService(needed):
    if not needed:
        return []

    return [{
        "name": "webdav",
        "image": "owncloudci/php:latest",
        "pull": "always",
        "environment": {
            "APACHE_CONFIG_TEMPLATE": "webdav",
        },
        "command": [
            "/usr/local/bin/apachectl",
            "-D",
            "FOREGROUND",
        ],
    }]

def sambaService(needed):
    if not needed:
        return []

    return [{
        "name": "samba",
        "image": "owncloudci/samba:latest",
        "pull": "always",
        "command": [
            "-u",
            "test;test",
            "-s",
            "public;/tmp;yes;no;no;test;none;test",
            "-S",
        ],
    }]

def sftpService(needed):
    if not needed:
        return []

    # 'test:12345:1001::upload'
    # Creates a user 'test' with password '12345', UID '1001'
    # The user has a folder called 'upload' that they can write to.
    # The tests depend on the 'upload' folder already existing, because
    # "Just remember that the users can't create new files directly under their
    #  own home directory, so make sure there are at least one subdirectory
    #  if you want them to upload files" https://hub.docker.com/r/atmoz/sftp/
    # Also see apps/files_external/tests/env/start-sftp-atmoz.sh where the
    # docker image can be started "locally".
    return [{
        "name": "sftp",
        "image": "atmoz/sftp",
        "pull": "always",
        "environment": {
            "SFTP_USERS": "test:12345:1001::upload",
        },
    }]

def scalityService(scalityS3):
    if not scalityS3:
        return []

    return [{
        "name": "scality",
        "image": "owncloudci/scality-s3server:latest",
        "pull": "always",
        "environment": {
            "HOST_NAME": "scality",
        },
    }]

def cephService(cephS3):
    if not cephS3:
        return []

    return [{
        "name": "ceph",
        "image": "owncloudci/ceph:tag-build-master-jewel-ubuntu-16.04",
        "pull": "always",
        "environment": {
            "NETWORK_AUTO_DETECT": "4",
            "RGW_NAME": "ceph",
            "CEPH_DEMO_UID": "owncloud",
            "CEPH_DEMO_ACCESS_KEY": "owncloud123456",
            "CEPH_DEMO_SECRET_KEY": "secret123456",
        },
    }]

def owncloudService(phpVersion, name, pathOfServerUnderTest, ssl):
    if ssl:
        environment = {
            "APACHE_WEBROOT": pathOfServerUnderTest,
            "APACHE_CONFIG_TEMPLATE": "ssl",
            "APACHE_SSL_CERT_CN": name,
            "APACHE_SSL_CERT": "%s/%s.crt" % (dir["base"], name),
            "APACHE_SSL_KEY": "%s/%s.key" % (dir["base"], name),
            "APACHE_LOGGING_PATH": "/dev/null",
        }
    else:
        environment = {
            "APACHE_WEBROOT": pathOfServerUnderTest,
            "APACHE_LOGGING_PATH": "/dev/null",
        }

    return [{
        "name": name,
        "image": "owncloudci/php:%s" % phpVersion,
        "pull": "always",
        "environment": environment,
        "command": [
            "/usr/local/bin/apachectl",
            "-e",
            "debug",
            "-D",
            "FOREGROUND",
        ],
    }]

def getShortDbNameAndVersion(db):
    return "%s%s" % (getDbType(db), getDbVersion(db))

def getDbName(db):
    return db.partition(":")[0]

def getDbVersion(db):
    return db.partition(":")[2]

def getDbUsername(db):
    name = getDbName(db)

    # The Oracle image has the Db Username hardcoded
    if name == "oracle":
        return "autotest"

    return "owncloud"

def getDbPassword(db):
    name = getDbName(db)

    # The Oracle image has the Db Password hardcoded
    if name == "oracle":
        return "owncloud"

    return "owncloud"

def getDbRootPassword():
    return "owncloud"

def getDbDatabase(db):
    name = getDbName(db)

    # The Oracle image has the Db Name hardcoded
    if name == "oracle":
        return "XE"

    return "owncloud"

def getDbType(db):
    dbName = getDbName(db)
    if dbName == "postgres":
        return "pgsql"

    if dbName == "oracle":
        return "oci"

    return dbName

def cacheRestore():
    return [{
        "name": "cache-restore",
        "image": "plugins/s3-cache:1",
        "pull": "always",
        "settings": {
            "access_key": {
                "from_secret": "cache_s3_access_key",
            },
            "endpoint": {
                "from_secret": "cache_s3_endpoint",
            },
            "restore": True,
            "secret_key": {
                "from_secret": "cache_s3_secret_key",
            },
        },
        "when": {
            "instance": [
                "drone.owncloud.services",
                "drone.owncloud.com",
            ],
        },
    }]

def cacheClearOnEventPush(phpVersion):
    return [{
        "name": "cache-clear",
        "image": "owncloudci/php:%s" % phpVersion,
        "pull": "always",
        "commands": [
            "rm -Rf %s/.cache/composer" % dir["server"],
            "rm -Rf %s/.cache/yarn" % dir["server"],
        ],
        "when": {
            "event": [
                "push",
            ],
            "instance": [
                "drone.owncloud.services",
                "drone.owncloud.com",
            ],
        },
    }]

def cacheRebuildOnEventPush():
    return [{
        "name": "cache-rebuild",
        "image": "plugins/s3-cache:1",
        "pull": "always",
        "settings": {
            "access_key": {
                "from_secret": "cache_s3_access_key",
            },
            "endpoint": {
                "from_secret": "cache_s3_endpoint",
            },
            "mount": [
                ".cache",
            ],
            "rebuild": True,
            "secret_key": {
                "from_secret": "cache_s3_secret_key",
            },
        },
        "when": {
            "event": [
                "push",
            ],
            "instance": [
                "drone.owncloud.services",
                "drone.owncloud.com",
            ],
        },
    }]

def cacheFlushOnEventPush():
    return [{
        "name": "cache-flush",
        "image": "plugins/s3-cache:1",
        "pull": "always",
        "settings": {
            "access_key": {
                "from_secret": "cache_s3_access_key",
            },
            "endpoint": {
                "from_secret": "cache_s3_endpoint",
            },
            "flush": True,
            "flush_age": "14",
            "secret_key": {
                "from_secret": "cache_s3_secret_key",
            },
        },
        "when": {
            "event": [
                "push",
            ],
            "instance": [
                "drone.owncloud.services",
                "drone.owncloud.com",
            ],
        },
    }]

def composerInstall(phpVersion):
    return [{
        "name": "composer-install",
        "image": "owncloudci/php:%s" % phpVersion,
        "pull": "always",
        "environment": {
            "COMPOSER_HOME": "%s/.cache/composer" % dir["server"],
        },
        "commands": [
            "make install-composer-deps",
        ],
    }]

def vendorbinCodestyle(phpVersion):
    return [{
        "name": "vendorbin-codestyle",
        "image": "owncloudci/php:%s" % phpVersion,
        "pull": "always",
        "environment": {
            "COMPOSER_HOME": "%s/.cache/composer" % dir["server"],
        },
        "commands": [
            "make vendor-bin-codestyle",
        ],
    }]

def vendorbinCodesniffer(phpVersion):
    return [{
        "name": "vendorbin-codesniffer",
        "image": "owncloudci/php:%s" % phpVersion,
        "pull": "always",
        "environment": {
            "COMPOSER_HOME": "%s/.cache/composer" % dir["server"],
        },
        "commands": [
            "make vendor-bin-codesniffer",
        ],
    }]

def vendorbinPhan(phpVersion):
    return [{
        "name": "vendorbin-phan",
        "image": "owncloudci/php:%s" % phpVersion,
        "pull": "always",
        "environment": {
            "COMPOSER_HOME": "%s/.cache/composer" % dir["server"],
        },
        "commands": [
            "make vendor-bin-phan",
        ],
    }]

def vendorbinPhpstan(phpVersion):
    return [{
        "name": "vendorbin-phpstan",
        "image": "owncloudci/php:%s" % phpVersion,
        "pull": "always",
        "environment": {
            "COMPOSER_HOME": "%s/.cache/composer" % dir["server"],
        },
        "commands": [
            "make vendor-bin-phpstan",
        ],
    }]

def vendorbinBehat():
    return [{
        "name": "vendorbin-behat",
        "image": "owncloudci/php:8.0",
        "pull": "always",
        "environment": {
            "COMPOSER_HOME": "%s/.cache/composer" % dir["server"],
        },
        "commands": [
            "make vendor-bin-behat",
        ],
    }]

def yarnInstall(nodeJsVersion):
    return [{
        "name": "yarn-install",
        "image": "owncloudci/nodejs:%s" % nodeJsVersion,
        "pull": "always",
        "environment": {
            "NPM_CONFIG_CACHE": "%s/.cache/npm" % dir["server"],
            "YARN_CACHE_FOLDER": "%s/.cache/yarn" % dir["server"],
            "bower_storage__packages": "%s/.cache/bower" % dir["server"],
        },
        "commands": [
            "make install-nodejs-deps",
        ],
    }]

def davInstall(phpVersion, scriptPath):
    return [{
        "name": "dav-install",
        "image": "owncloudci/php:%s" % phpVersion,
        "pull": "always",
        "commands": [
            "bash %s/install.sh" % scriptPath,
        ],
    }]

def setupLocalStorage(phpVersion):
    return [{
        "name": "setup-storage",
        "image": "owncloudci/php:%s" % phpVersion,
        "pull": "always",
        "environment": {
            "OC_PASS": "123456",
        },
        "commands": [
            "mkdir -p %s/work/local_storage" % dir["server"],
            "php occ app:enable files_external",
            "php occ config:system:set files_external_allow_create_new_local --value=true",
            "php occ config:app:set core enable_external_storage --value=yes",
            "php occ files_external:create local_storage local null::null -c datadir=%s/work/local_storage" % dir["server"],
            "php occ user:add --password-from-env user1",
        ],
    }]

def createShare(phpVersion):
    return [{
        "name": "create-share",
        "image": "owncloudci/php:%s" % phpVersion,
        "pull": "always",
        "commands": [
            'curl -k -s -u user1:123456 -X MKCOL "https://server/remote.php/webdav/new_folder"',
            'curl -k -s -u user1:123456 "https://server/ocs/v2.php/apps/files_sharing/api/v1/shares" --data "path=/new_folder&shareType=0&permissions=15&name=new_folder&shareWith=admin"',
            'echo -n "PUBLIC_TOKEN=" > .env',
            'curl -k -s -u user1:123456 "https://server/ocs/v2.php/apps/files_sharing/api/v1/shares" --data "path=/new_folder&shareType=3&permissions=15&name=new_folder" | grep token | cut -d">" -f2 | cut -d"<" -f1 >> .env',
        ],
    }]

def installExtraApps(phpVersion, extraApps, pathOfServerUnderTest):
    commandArray = []
    for app, command in extraApps.items():
        commandArray.append("ls %s/apps/%s || git clone https://github.com/owncloud/%s.git %s/apps/%s" % (pathOfServerUnderTest, app, app, pathOfServerUnderTest, app))
        if (command != ""):
            commandArray.append("cd %s/apps/%s" % (pathOfServerUnderTest, app))
            commandArray.append(command)
        commandArray.append("cd %s" % pathOfServerUnderTest)
        commandArray.append("php occ a:l")
        commandArray.append("php occ a:e %s" % app)
        commandArray.append("php occ a:l")

    if (commandArray == []):
        return []

    return [{
        "name": "install-extra-apps",
        "image": "owncloudci/php:%s" % phpVersion,
        "pull": "always",
        "commands": commandArray,
    }]

def databaseServiceForFederation(db, suffix):
    dbName = getDbName(db)

    if dbName not in ["mariadb", "mysql"]:
        print("Not implemented federated database for ", dbName)
        return []

    service = {
        "name": dbName + suffix,
        "image": db,
        "pull": "always",
        "environment": {
            "MYSQL_USER": getDbUsername(db),
            "MYSQL_PASSWORD": getDbPassword(db),
            "MYSQL_DATABASE": getDbDatabase(db) + suffix,
            "MYSQL_ROOT_PASSWORD": getDbRootPassword(),
        },
    }
    if (db == "mysql:8.0"):
        service["command"] = ["--default-authentication-plugin=mysql_native_password"]
    return [service]

def installServer(phpVersion, db, logLevel = "2", ssl = False, federatedServerNeeded = False, proxyNeeded = False):
    return [{
        "name": "install-server",
        "image": "owncloudci/php:%s" % phpVersion,
        "pull": "always",
        "environment": {
            "DB_TYPE": getDbName(db),
            "DB_USERNAME": getDbUsername(db),
            "DB_PASSWORD": getDbPassword(db),
            "DB_NAME": getDbDatabase(db),
        },
        "commands": [
            "bash tests/drone/install-server.sh",
            "php occ a:l",
            "php occ config:system:set trusted_domains 1 --value=server",
        ] + ([
            "php occ config:system:set trusted_domains 2 --value=federated",
            "php occ config:system:set csrf.disabled --value=true",
        ] if federatedServerNeeded else []) + [
        ] + ([
            "php occ config:system:set trusted_domains 3 --value=proxy",
        ] if proxyNeeded else []) + [
            "php occ log:manage --level %s" % logLevel,
            "php occ config:list",
        ] + ([
            "php occ security:certificates:import %s/server.crt" % dir["base"],
        ] if ssl else []) + ([
            "php occ security:certificates:import %s/federated.crt" % dir["base"],
        ] if federatedServerNeeded and ssl else []) + [
            "php occ security:certificates",
        ],
    }]

def installAndConfigureFederated(ctx, federatedServerVersion, phpVersion, logLevel, protocol, db, dbSuffix = "fed"):
    return [
        installFederated(ctx, federatedServerVersion, db, dbSuffix),
        configureFederated(phpVersion, logLevel, protocol),
    ]

def installFederated(ctx, federatedServerVersion, db, dbSuffix = "fed"):
    host = getDbName(db)
    dbType = host

    username = getDbUsername(db)
    password = getDbPassword(db)
    database = getDbDatabase(db) + dbSuffix

    if host == "mariadb":
        dbType = "mysql"
    elif host == "postgres":
        dbType = "pgsql"
    elif host == "oracle":
        dbType = "oci"

    installerSettings = {
        "core_path": dir["federated"],
        "db_type": dbType,
        "db_name": database,
        "db_host": host + dbSuffix,
        "db_username": username,
        "db_password": password,
    }

    if (federatedServerVersion == "git"):
        if (ctx.build.source_repo == ctx.repo.slug):
            # The PR comes from a branch that is in the same repo
            # So use that branch for installing the federated server
            installerSettings["git_reference"] = ctx.build.source
        else:
            # The PR comes from a branch that is in some other repo
            # e.g. a community contribution from a fork
            # Rather than jumping through hoops to find that code,
            # install the federated server from owncloud/core master
            installerSettings["git_reference"] = "master"
    else:
        installerSettings["version"] = federatedServerVersion

    return {
        "name": "install-federated",
        "image": "owncloudci/core:nodejs14",
        "pull": "always",
        "settings": installerSettings,
    }

def configureFederated(phpVersion, logLevel, protocol):
    return {
        "name": "configure-federated",
        "image": "owncloudci/php:%s" % phpVersion,
        "pull": "always",
        "commands": [
            "cd %s" % dir["federated"],
            "php occ a:l",
            "php occ a:e testing",
            "php occ a:l",
            "php occ config:system:set trusted_domains 1 --value=server",
            "php occ config:system:set trusted_domains 2 --value=federated",
            "php occ log:manage --level %s" % logLevel,
            "php occ config:list",
            'echo "export TEST_SERVER_FED_URL=%s://federated" > %s/saved-settings.sh' % (protocol, dir["base"]),
            "php occ security:certificates:import %s/server.crt" % dir["base"],
            "php occ security:certificates:import %s/federated.crt" % dir["base"],
            "php occ security:certificates",
        ],
    }

def setupCeph(phpVersion, cephS3):
    if not cephS3:
        return []

    return [{
        "name": "setup-ceph",
        "image": "owncloudci/php:%s" % phpVersion,
        "pull": "always",
        "commands": [
            "wait-for-it -t 600 ceph:80",
            "cd %s/apps/files_primary_s3" % dir["server"],
            "cp tests/drone/ceph.config.php %s/config" % dir["server"],
            "cd /var/www/owncloud/server",
            "./apps/files_primary_s3/tests/drone/create-bucket.sh",
        ],
    }]

def setupScality(phpVersion, scalityS3):
    if type(scalityS3) == "bool":
        if scalityS3:
            # specify an empty dict that will get the defaults
            scalityS3 = {}
        else:
            return []

    specialConfig = "." + scalityS3["config"] if "config" in scalityS3 else ""
    configFile = "scality%s.config.php" % specialConfig
    createExtraBuckets = scalityS3["createExtraBuckets"] if "createExtraBuckets" in scalityS3 else False

    return [{
        "name": "setup-scality",
        "image": "owncloudci/php:%s" % phpVersion,
        "pull": "always",
        "commands": [
            "wait-for-it -t 600 scality:8000",
            "cp %s/apps/files_primary_s3/tests/drone/%s %s/config" % (dir["server"], configFile, dir["server"]),
            "php occ s3:create-bucket owncloud --accept-warning",
        ] + ([
            "for I in $(seq 1 9); do php ./occ s3:create-bucket owncloud$I --accept-warning; done",
        ] if createExtraBuckets else []),
    }]

def fixPermissions(phpVersion, federatedServerNeeded, selUserNeeded = False, pathOfServerUnderTest = dir["server"]):
    return [{
        "name": "fix-permissions",
        "image": "owncloudci/php:%s" % phpVersion,
        "pull": "always",
        "commands": [
            "chown -R www-data %s" % pathOfServerUnderTest,
        ] + ([
            "chown -R www-data %s" % dir["federated"],
        ] if federatedServerNeeded else []) + ([
            "chmod 777 /home/seluser/Downloads/",
        ] if selUserNeeded else []),
        "volumes": [{
            "name": "downloads",
            "path": "/home/seluser/Downloads/",
        }],
    }]

def waitForServer(phpVersion, federatedServerNeeded):
    return [{
        "name": "wait-for-server",
        "image": "owncloudci/php:%s" % phpVersion,
        "pull": "always",
        "commands": [
            "wait-for-it -t 600 server:80",
        ] + ([
            "wait-for-it -t 600 federated:80",
        ] if federatedServerNeeded else []),
    }]

def owncloudLog(server, folder):
    return [{
        "name": "owncloud-log-%s" % server,
        "image": "owncloud/ubuntu:18.04",
        "pull": "always",
        "detach": True,
        "commands": [
            "tail -f %s/data/owncloud.log" % folder,
        ],
    }]

def owncloudDockerService(ocDockerService):
    if not ocDockerService:
        return []

    db = "postgres"

    return [
        {
            "name": "oc-server",
            "image": "owncloud/server",
            "pull": "always",
            "environment": {
                "OWNCLOUD_VERSION": "latest",
                "OWNCLOUD_DOMAIN": "oc-server",
                "OWNCLOUD_ADMIN_USERNAME": "admin",
                "OWNCLOUD_ADMIN_PASSWORD": "admin",
                "HTTP_PORT": "8080",
                "OWNCLOUD_REDIS_ENABLED": "true",
                "OWNCLOUD_REDIS_HOST": "redis",
                "OWNCLOUD_DB_TYPE": getDbType(db),
                "OWNCLOUD_DB_NAME": getDbUsername(db),
                "OWNCLOUD_DB_USERNAME": getDbUsername(db),
                "OWNCLOUD_DB_PASSWORD": getDbPassword(db),
                "OWNCLOUD_DB_HOST": getDbName(db),
            },
        },
    ] + databaseService(db)

def redisService(redisService):
    if not redisService:
        return []

    return [{
        "name": "redis",
        "image": "webhippie/redis:latest",
        "pull": "always",
        "environment": {
            "REDIS_DATABASES": 1,
        },
    }]

def dependsOn(earlierStages, nextStages):
    for earlierStage in earlierStages:
        for nextStage in nextStages:
            nextStage["depends_on"].append(earlierStage["name"])

def installCoreFromTarball(version, db, logLevel = "2", ssl = False, federatedServerNeeded = False, proxyNeeded = False, pathOfServerUnderTest = "/drone/core"):
    host = getDbName(db)
    dbType = host

    username = getDbUsername(db)
    password = getDbPassword(db)
    database = getDbDatabase(db)

    if host == "mariadb":
        dbType = "mysql"

    if host == "postgres":
        dbType = "pgsql"

    if host == "oracle":
        dbType = "oci"

    return [{
        "name": "install-tarball",
        "image": "owncloudci/core:nodejs14",
        "pull": "always",
        "settings": {
            "version": version,
            "core_path": pathOfServerUnderTest,
            "db_type": dbType,
            "db_name": database,
            "db_host": host,
            "db_username": username,
            "db_password": password,
        },
    }, {
        "name": "configure-tarball",
        "image": "owncloudci/php:7.4",
        "pull": "always",
        "commands": [
            "cd %s" % pathOfServerUnderTest,
            "php occ a:l",
            "php occ a:e testing",
            "php occ a:l",
            "php occ config:system:set trusted_domains 1 --value=server",
        ] + ([
            "php occ config:system:set trusted_domains 2 --value=federated",
        ] if federatedServerNeeded else []) + [
        ] + ([
            "php occ config:system:set trusted_domains 3 --value=proxy",
        ] if proxyNeeded else []) + [
            "php occ log:manage --level %s" % logLevel,
            "php occ config:list",
        ] + ([
            "php occ security:certificates:import %s/server.crt" % dir["base"],
        ] if ssl else []) + ([
            "php occ security:certificates:import %s/federated.crt" % dir["base"],
        ] if federatedServerNeeded and ssl else []) + [
            "php occ security:certificates",
        ],
    }]

def installFederatedFromTarball(federatedServerVersion, phpVersion, logLevel, protocol, db, dbSuffix = "-federated"):
    host = getDbName(db)
    dbType = host

    username = getDbUsername(db)
    password = getDbPassword(db)
    database = getDbDatabase(db) + dbSuffix

    if host == "mariadb":
        dbType = "mysql"
    elif host == "postgres":
        dbType = "pgsql"
    elif host == "oracle":
        dbType = "oci"
    return [
        {
            "name": "install-federated",
            "image": "owncloudci/core:nodejs14",
            "pull": "always",
            "settings": {
                "version": federatedServerVersion,
                "core_path": dir["federated"],
                "db_type": "mysql",
                "db_name": database,
                "db_host": host + dbSuffix,
                "db_username": username,
                "db_password": password,
            },
        },
        {
            "name": "configure-federation",
            "image": "owncloudci/php:%s" % phpVersion,
            "pull": "always",
            "commands": [
                'echo "export TEST_SERVER_FED_URL=%s://federated" > %s/saved-settings.sh' % (protocol, dir["base"]),
                "cd %s" % dir["federated"],
                "php occ a:l",
                "php occ a:e testing",
                "php occ a:l",
                "php occ config:system:set trusted_domains 1 --value=server",
                "php occ config:system:set trusted_domains 2 --value=federated",
                "php occ log:manage --level %s" % logLevel,
                "php occ config:list",
                "php occ security:certificates:import %s/server.crt" % dir["base"],
                "php occ security:certificates:import %s/federated.crt" % dir["base"],
                "php occ security:certificates",
            ],
        },
    ]

def installTestRunner(ctx, phpVersion):
    return [{
        "name": "install-testrunner",
        "image": "owncloudci/php:%s" % phpVersion,
        "pull": "always",
        "commands": [
            "mkdir /tmp/testrunner",
            "git clone -b %s --depth=1 https://github.com/owncloud/core.git /tmp/testrunner" % ctx.build.source if ctx.build.event == "pull_request" else "master",
            "rsync -aIX /tmp/testrunner/tests %s/tests" % dir["server"],
        ],
    }]

def checkStarlark():
    return [{
        "kind": "pipeline",
        "type": "docker",
        "name": "check-starlark",
        "steps": [
            {
                "name": "format-check-starlark",
                "image": "owncloudci/bazel-buildifier",
                "pull": "always",
                "commands": [
                    "buildifier --mode=check .drone.star",
                ],
            },
            {
                "name": "show-diff",
                "image": "owncloudci/bazel-buildifier",
                "pull": "always",
                "commands": [
                    "buildifier --mode=fix .drone.star",
                    "git diff",
                ],
                "when": {
                    "status": [
                        "failure",
                    ],
                },
            },
        ],
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/pull/**",
            ],
        },
    }]
