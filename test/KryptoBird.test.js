const { assert } = require('chai');

const KryptoBird = artifacts.require('./KryptoBird');

require('chai')
    .use(require('chai-as-promised'))
    .should()

contract('KryptoBird', accounts => {
    let contract;
    before(async () => {
        contract = await KryptoBird.deployed();
    })

    // testing container - describe
    describe('deployment', async () => {
        // text samples with writting it
        it('deploys successfuly', async () => {
            const address = await contract.address;
            assert.notEqual(address, '')
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
            assert.notEqual(address, 0x0)
        })

        it('has a name KryptoBird', async () => {
            const name = await contract.name();
            assert.equal(name, 'KryptoBird');
        })

        it('has a symbol KBIRDZ', async () => {
            const symbol = await contract.symbol();
            assert.equal(symbol, 'KBIRDZ');
        })
    });

    describe('minting', async () => {
        it('creates a new token', async () => {
            const result = await contract.mint('https_0');
            const totalSupply = await contract.totalSupply();
            // success
            assert.equal(totalSupply, 1);
            const event = result.logs[0].args;
            assert.equal(event._from, '0x0000000000000000000000000000000000000000', 'from is the contract');
            assert.equal(event._to, accounts[0], 'to is message sender');

            // Faillure
            await contract.mint('https_0').should.be.rejected;
        })
    })

    describe('indexing', async () => {
        it('lists KryptoBirdz', async () => {
            await contract.mint('https_1');
            await contract.mint('https_2');
            await contract.mint('https_3');
            await contract.mint('https_4');
            const totalSupply = await contract.totalSupply();

            // Loop through list and grab KBirdz
            let result = [];
            let KryptoBird;
            for (let i = 0; i < totalSupply; i++) {
                KryptoBird = await contract.kryptoBirdz(i)
                result.push(KryptoBird)
            }
            const expectedArray = ['https_0', 'https_1', 'https_2', 'https_3', 'https_4'];
            assert.equal(expectedArray.join(','), result.join(','));
        })
    })
});