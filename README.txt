🏗️ Crowdfunding Smart Contract
This is a decentralized crowdfunding smart contract built using Solidity. It allows contributors to fund a project, vote on fund allocation, and receive refunds if the target is not met.

🚀 Features
✅ Accepts contributions from multiple users
✅ Enforces a minimum contribution amount
✅ Allows contributors to vote on spending requests
✅ Ensures transparency by requiring majority approval for fund withdrawals
✅ Enables refunds if the funding goal is not reached before the deadline

📜 Smart Contract Overview
Contributors can donate and participate in funding rounds.
Manager can create spending requests and withdraw funds if the majority of contributors approve.
Voting Mechanism ensures that funds are allocated based on collective decision-making.
Refund System refunds contributors if the target is not met before the deadline.
🔧 Installation & Deployment
Clone the repository:
sh
Copy
Edit
git clone https://github.com/your-username/crowdfunding-smart-contract.git
cd crowdfunding-smart-contract
Install dependencies (if using Hardhat or Truffle):
sh
Copy
Edit
npm install
Compile the contract:
sh
Copy
Edit
npx hardhat compile
Deploy to a test network:
sh
Copy
Edit
npx hardhat run scripts/deploy.js --network goerli
📜 Contract Functions
Function	Description
contribution()	Allows users to contribute to the crowdfunding campaign
createRequests(description, recipient, value)	Manager creates spending requests
voteRequest(requestNo)	Contributors vote to approve spending requests
makePayment(requestNo)	Manager executes approved payments
refund()	Allows contributors to claim refunds if the target is not met
getContractBalance()	Returns the contract’s balance
🎯 Future Enhancements
UI integration for an interactive experience
Enhanced security mechanisms
Multi-round funding support
📌 License
This project is licensed under MIT.
