/**
 * Use this file to configure your truffle project. It's seeded with some
 * common settings for different networks and features like migrations,
 * compilation and testing. Uncomment the ones you need or modify
 * them to suit your project as necessary.
 *
 * More information about configuration can be found at:
 *
 * truffleframework.com/docs/advanced/configuration
 *
 * To deploy via Infura you'll need a wallet provider (like @truffle/hdwallet-provider)
 * to sign your transactions before they're sent to a remote public node. Infura accounts
 * are available for free at: infura.io/register.
 *
 * You'll also need a mnemonic - the twelve word phrase the wallet uses to generate
 * public/private key pairs. If you're publishing your code to GitHub make sure you load this
 * phrase from a file you've .gitignored so it doesn't accidentally become public.
 */

const HDWalletProvider = require('@truffle/hdwallet-provider');
const mnemonicRopsten = "talk velvet inmate bamboo hover puzzle era abuse ride outside rent trip spike tide awesome";
// const mnemonicTestnet;
// const addressTestnet;

module.exports = {
  /**
   * Networks define how you connect to your ethereum client and let you set the
   * defaults web3 uses to send transactions. If you don't specify one truffle
   * will spin up a development blockchain for you on port 9545 when you
   * run `develop` or `test`. You can ask a truffle command to use a specific
   * network from the command line, e.g
   *
   * $ truffle test --network <network-name>
   */

  networks: {
    regtest: {
      provider: () => new HDWalletProvider(
        "c85ef7d79691fe79573b1a7064c19c1a9819ebdbd1faaab1a8ec92344438aaf4", "http://localhost:4444"
      ),
      network_id: 33,
      from: "0xcd2a3d9f938e13cd947ec05abc7fe734df8dd826"
    },
    // testnet: {
    //   provider: () => new HDWalletProvider(
    //     mnemonicTestnet, "http://localhost:4444"
    //   ),
    //   network_id: 32,
    //   from: addressTestnet
    // },
    ropstenInfura: {
      provider: () => new HDWalletProvider(
        mnemonicRopsten, "https://ropsten.infura.io/v3/PROJECT_ID"
      ),
      network_id: 3
    },
    gethRegtest: {
      provider: () => new HDWalletProvider(
        "c85ef7d79691fe79573b1a7064c19c1a9819ebdbd1faaab1a8ec92344438aaf4", "http://localhost:8545"
      ),
      network_id: 1337
    }
  },

  // Set default mocha options here, use special reporters etc.
  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.5.16",      // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      // settings: {          // See the solidity docs for advice about optimization and evmVersion
      //  optimizer: {
      //    enabled: false,
      //    runs: 200
      //  },
      //  evmVersion: "byzantium"
      // }
    }
  }
}
