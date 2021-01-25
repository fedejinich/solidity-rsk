const Blake2b = artifacts.require("Blake2b")

contract("Blake2b Tests", async accounts => {
  it("should emit ResultOk once", async () => {
    const instance = await Blake2b.deployed()

    const result = await instance.runTest()
    const events = result.receipt.logs.map(l => l.event)
    const resultOkEvents = events.filter(e => e == "ResultOk")

    assert.equal(1, resultOkEvents.length)
  })
})