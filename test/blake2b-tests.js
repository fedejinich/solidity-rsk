const Blake2b = artifacts.require("Blake2b")

contract("Blake2b Tests", async accounts => {

  it("should return a succesful receipt", async () => {
    const instance = await Blake2b.deployed()

    const result = await instance.runTest() // it's a view function
    
    assert.isOk(result)
  })
})