const func = async function (hre) {
	const {
		deployments: { deploy },
		getNamedAccounts,
	} = hre

	const { deployer } = await getNamedAccounts()

	await deploy('WeekdayNFT', { from: deployer, args: [], log: true })
}

module.exports = func
