const { expect } = require('chai')
const { ethers } = require('hardhat')

describe('WeekdayNFT', function () {
	it('Should return the current day of the week', async function () {
		const WeekdayNFT = await ethers.getContractFactory('WeekdayNFT')
		const contract = await WeekdayNFT.deploy()
		await contract.deployed()

		expect(await contract.getWeekDay()).to.equal(getDayOfWeek())
	})
})

const getDayOfWeek = () => {
	const weekDays = [
		'Thursday', // The Unix epoch was on Thursday
		'Wednesday',
		'Tuesday',
		'Monday',
		'Sunday',
		'Saturday',
		'Friday',
	]

	const timestamp = new Date().getTime()
	const secondsInDay = 1 * 60 * 60 * 24
	const secondsInWeek = secondsInDay * 7
	const startDayTimestamp = Math.floor(timestamp / (secondsInDay * 1000)) * (secondsInDay * 1000)

	const modulo = (a, n) => ((a % n) + n) % n

	return weekDays[modulo(startDayTimestamp, secondsInWeek) / secondsInDay]
}
