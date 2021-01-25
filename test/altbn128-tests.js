const Altbn128 = artifacts.require("Altbn128")

contract("Altbn128 Tests", async accounts => {
  it("runAddTest: should emit ResultOk once", async () => {
    const instance = await Altbn128.deployed()

    const result = await instance.runAddTest()
    const events = result.receipt.logs.map(l => l.event)
    const resultOkEvents = events.filter(e => e == "ResultOk")

    assert.equal(1, resultOkEvents.length)
  })

  it("runScalarMulTest: should emit ResultOk once", async () => {
    const instance = await Altbn128.deployed()

    const result = await instance.runScalarMulTest()
    const events = result.receipt.logs.map(l => l.event)
    const resultOkEvents = events.filter(e => e == "ResultOk")

    assert.equal(1, resultOkEvents.length)
  })

  it("runPairingTest: should emit ResultOk once", async () => {
    const instance = await Altbn128.deployed()

    const result = await instance.runPairingTest()
    const events = result.receipt.logs.map(l => l.event)
    const resultOkEvents = events.filter(e => e == "ResultOk")

    assert.equal(1, resultOkEvents.length)
  })
})