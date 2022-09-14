const { assert } = require('chai');

const KryptoBird = artifacts.require('./KryptoBird');

require('chai')
    .use(require('chai-as-promised'))
    .should()

contract('KryptoBird', async (accounts) => {
    let contract;

    // testing container - describe

    describe('deployment', async () => {
        // text samples with writting it
        it('deploys successfuly', async () => {
            contract = await KryptoBird.deployed();
            const address = contract.address;

            assert.notEqual(address, '')
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
            assert.notEqual(address, 0x0)
        })
    })
});