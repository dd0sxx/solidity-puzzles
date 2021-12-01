/*
 * @notice to be called in an emergency by the owner. In initial versions, multisig. Then governance.
 * The function takes all tokens out, incentivizing with ETH according to how much token was saved.
 * Any remaining ETH is sent to the owner.
 * Finally, the upgrade is triggered.
 */
function emergencyUpgrade(address newImplementation, address recipient) public onlyOwner {
	uint tokenBalance = token.balanceOf(address(this));
	
	// Transfer out deposited tokens to the owner
	token.transfer(owner(), tokenBalance);

	uint256 amount = oracle.getPrice(token) * tokenBalance;
	payable(recipient).sendValue(amount);

	// Any remaining ETH goes to the owner
	if(address(this).balance > 0) {
		payable(owner()).sendValue(address(this).balance);
	}

	// Trigger the contract upgrade
	upgradeTo(newImplementation);
}

/*
-----
Src: https://youtu.be/5WE6PEc305w?t=1103
Instructor Q's to investigate:

What's behind onlyOwner? What are our trust assumptions?

What kind of tokens? Could transfer fail?

Can the owner handle tokens? Can the owner handle ETH?

What kind of oracle? does that introduce attack vector?

	- do we have permission?
	- is it up?
	- is this token suported at time of transaction?
	- what units is it in?
	- what if price returns as zero?

sendValue(amount) assumes we have ETH - what if we have no ETH?

is recipient of ETH trusted? DoS? Reentrancy?

upgradeTo:
	- if any of that fails, upgrade fails
	- what pattern is being used?
	- is new implementation correctly initialized
	- does it respect storage layouts?
	- does it need upgrade logic?
	- is there function clashing?
	- are there safety checks to avoid bricking the upgradeability?
	- "what are the off chain validations?" (testing, deploy scripts, etc.)

----
*/
