pragma solidity 0.4.24;

contract Vote {
    
    struct Candidator {
        string name;
        uint upVote;
    }
    
    bool live;
    address owner;
    Candidator[] public candidatorList;
    
    mapping(address => bool) voted;
    
    event AddCandidator(string name);
    event UpVote(string candidator, uint upVote);
    event FinishVote(bool live);
    event Voting(address owner);
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    constructor() public {
        owner = msg.sender;
        live = true;
        
        emit Voting(owner);
    }
    
    function addCandidator(string _name) public onlyOwner{
        require(candidatorList.length < 5);
        require(live);
        candidatorList.push(Candidator(_name, 0));
        
        emit AddCandidator(_name);
    }
    
    function getCandidator(uint _indexOfCandidator) public view returns(string memory, uint) {
        require(_indexOfCandidator < candidatorList.length);
        return(candidatorList[_indexOfCandidator].name, candidatorList[_indexOfCandidator].upVote);
    }
    
    function upVote(uint _indexOfCandidator) public {
        require(_indexOfCandidator < candidatorList.length);
        require(live);
        require(!voted[msg.sender]);
        candidatorList[_indexOfCandidator].upVote++;
        
        voted[msg.sender] = true;
        
        emit UpVote(candidatorList[_indexOfCandidator].name, candidatorList[_indexOfCandidator].upVote);
    }
    
    function finishVote() public onlyOwner {
        live = false;
        
        emit FinishVote(live);
    }
}
