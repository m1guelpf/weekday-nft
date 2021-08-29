require('hardhat-deploy')
require('@nomiclabs/hardhat-waffle')
require('@nomiclabs/hardhat-etherscan')
const fs = require('fs')

const mnemonic = fs.readFileSync('.secret').toString().trim()

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
	solidity: '0.8.7',
	namedAccounts: {
		deployer: 0,
	},
	networks: {
		mumbai: {
			url: 'https://rpc-mumbai.maticvigil.com',
			gasPrice: 30,
			accounts: { mnemonic },
		},
		polygon: {
			url: 'https://rpc-mainnet.maticvigil.com',
			gasPrice: 30,
			accounts: { mnemonic },
		},
	},
}
