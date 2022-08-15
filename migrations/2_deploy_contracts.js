const Kryptobird = artifacts.require('Kryptobird');

module.exports = deployer => {
    deployer.deploy(Kryptobird);
}