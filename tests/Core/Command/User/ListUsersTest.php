<?php
/**
 * @author Semih Serhat Karakaya <karakayasemi@itu.edu.tr>
 *
 * @copyright Copyright (c) 2018, ownCloud GmbH
 * @license AGPL-3.0
 *
 * This code is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License, version 3,
 * as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License, version 3,
 * along with this program.  If not, see <http://www.gnu.org/licenses/>
 *
 */

namespace Tests\Core\Command\User;

use OC\Core\Command\User\ListUsers;
use Symfony\Component\Console\Tester\CommandTester;
use Test\TestCase;

/**
 * Class ListUsersTest
 *
 * @group DB
 */
class ListUsersTest extends TestCase {
	/** @var CommandTester */
	private $commandTester;

	protected function setUp(): void {
		parent::setUp();

		\OC::$server->getUserManager()->createUser('testlistuser', 'password');
		$command = new ListUsers(\OC::$server->getUserManager());
		$this->commandTester = new CommandTester($command);
	}

	protected function tearDown(): void {
		parent::tearDown();
		\OC::$server->getUserManager()->get('testlistuser')->delete();
	}

	/**
	 * @dataProvider inputProvider
	 * @param array $input
	 * @param string $expectedOutput
	 */
	public function testCommandInput($input, $expectedOutputs) {
		$this->commandTester->execute($input);
		$output = $this->commandTester->getDisplay();
		foreach ($expectedOutputs as $expectedOutput) {
			$this->assertStringContainsString($expectedOutput, $output);
		}
	}

	public function inputProvider() {
		return [
			[[], ['testlistuser']],
			[['search-pattern' => 'testlist'], ['testlistuser']],
			[['search-pattern' => 't'], ['testlistuser']],
			[['search-pattern' => 'li'], ['testlistuser']],
			[['--attributes' => [
				'uid', 'displayname', 'email', 'quota', 'enabled', 'lastlogin',
				'home', 'backend', 'cloudid', 'searchterms'
			]], [
				'uid', 'displayName', 'email', 'quota', 'enabled', 'lastLogin',
				'home', 'backend', 'cloudId', 'searchTerms'
				]
			],
			[['--show-all-attributes' => true], [
				'uid', 'displayName', 'email', 'quota', 'enabled', 'lastLogin',
				'home', 'backend', 'cloudId', 'searchTerms'
			]
			]
		];
	}
}
