pragma solidity 0.4.24;

contract Vote {
    
    //structure
    struct Candidator {
        string name;
        uint upVote;
    }
    
    //variable
    bool live;
    address owner;
    Candidator[] public candidatorList;
    
    //mapping
    mapping(address => bool) voted;
    
    
    //event
    event AddCandidator(string name);
    event UpVote(string candidator, uint upVote);
    event FinishVote(bool live);
    event Voting(address owner);
    
    //modifier
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    //constructor
    constructor() public {
        owner = msg.sender;
        live = true;
        
        emit Voting(owner);
    }
    
    
    //candidator
    function addCandidator(string _name) public onlyOwner{
        require(candidatorList.length < 5);
        require(live==true);
        candidatorList.push(Candidator(_name, 0));
        //emit event
        emit AddCandidator(_name);
    }
    
    //voting
    function upVote(uint _indexOfCandidator) public {
        require(_indexOfCandidator < candidatorList.length);
        require(live==true);
        require(voted[msg.sender]==false);
        candidatorList[_indexOfCandidator].upVote++;
        
        voted[msg.sender] = true;
        
        emit UpVote(candidatorList[_indexOfCandidator].name, candidatorList[_indexOfCandidator].upVote);
    }
    //finish vote
    function finishVote() public onlyOwner {
        require(live==true);
        live = false;
        
        emit FinishVote(live);
    }
}
